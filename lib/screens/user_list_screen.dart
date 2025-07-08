import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import '../utils/app_exceptions.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // late Future<List<UserModel>> _usersFuture;
  Future<List<UserModel>> _usersFuture = Future.value([]);
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // _findUsers();
    Future.delayed(const Duration(milliseconds: 3000), () {
      _findUsers();
    });
  }

  void _findUsers() {
    setState(() {
      _errorMessage = null;
      _usersFuture = UserService().fetchUsers().catchError((e) {
        setState(() {
          if (e is NoInternetException) {
            _errorMessage = 'Sem conexão. Verifique sua internet.';
          } else if (e is FetchDataException ||
              e is BadRequestException ||
              e is UnauthorizedException) {
            _errorMessage = 'Falha ao carregar dados: ${e.message}';
          } else {
            _errorMessage = 'Ocorreu um erro inesperado. Tente novamente.';
          }
        });
        throw e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _findUsers, // recarrega pagina
          ),
        ],
      ),

      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Indicador de carregamento
            return const Center(child: CircularProgressIndicator());
          } else if (_errorMessage != null) {
            // Exibe mensagem de erro amigável
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _findUsers,
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro desconhecido: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados
            return const Center(child: Text('Nenhum usuário encontrado.'));
          } else {
            // Exibe a lista de usuários
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(user.email),
                        const SizedBox(height: 2),
                        Text(user.address.city),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          //ATRASO para o CICULAR PROGRESS INDICATOR
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UserDetailScreen(user: user),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
