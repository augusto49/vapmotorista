import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingVerificationView extends StatelessWidget {
  const PendingVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de Documentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Aguarde a verificação dos seus documentos.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'O processo de verificação pode levar até 48 horas. Você será notificado quando seus documentos forem aprovados.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Status atual: Pendente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Redireciona o usuário para a página de login ou uma página inicial
                Get.offAllNamed('/login');
              },
              child: const Text('Voltar para Login'),
            ),
          ],
        ),
      ),
    );
  }
}
