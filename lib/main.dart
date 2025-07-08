import 'package:flutter/material.dart';
import 'package:teste_tecnico_cronos/screens/user_list_screen.dart';
import 'package:teste_tecnico_cronos/ui/ui_config.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desafio Flutter - Usuários',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: UiConfig.theme,
      home:  UserListScreen(),
    );
  }
}
