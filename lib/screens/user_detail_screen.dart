import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe do Usuário: ${user.name}"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // Permite rolagem se o conteúdo for muito grande
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nome:', user.name),
              const Divider(),
              _buildDetailRow('Email:', user.email),
              const Divider(),
              _buildDetailRow('Telefone:', user.phone),
              const Divider(),
              _buildDetailRow('Website:', user.website),
              const Divider(),
              _buildDetailRow(
                'Endereço:',
                '${user.address.street}, ${user.address.suite}\n${user.address.city}, ${user.address.zipcode}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90, // Ajuste a largura conforme necessário
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
