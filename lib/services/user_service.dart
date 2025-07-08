import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:teste_tecnico_cronos/models/user_model.dart';
import 'package:teste_tecnico_cronos/utils/app_exceptions.dart';
import 'package:teste_tecnico_cronos/utils/constants.dart';

class UserService {
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('${Constants.basUrl}/users'),
            headers: {
              'User-Agent': 'Chrome/5.0 (FlutterApp)',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));
      return _processResponse(response);
    } on SocketException {
      throw NoInternetException('Verifique sua conexão com a internet.');
    } on TimeoutException {
      throw FetchDataException('A requisição demorou muito para responder.');
    } catch (e) {
      throw FetchDataException('Ocorreu um erro inesperado: $e');
    }
  }

  List<UserModel> _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        List<dynamic> userJson = json.decode(response.body);
        return userJson.map((json) => UserModel.fromJson(json)).toList();
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Erro ao comunicar com o servidor: StatusCode ${response.statusCode}',
        );
    }
  }
}
