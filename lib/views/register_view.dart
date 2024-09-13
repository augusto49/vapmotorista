import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campos de registro
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => controller.email.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (value) => controller.password.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                onChanged: (value) => controller.password2.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) => controller.firstName.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                onChanged: (value) => controller.lastName.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Cidade'),
                onChanged: (value) => controller.cidade.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Telefone'),
                onChanged: (value) => controller.telefone.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'CPF'),
                onChanged: (value) => controller.cpf.value = value,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
                onChanged: (value) => controller.dataNascimento.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Gênero'),
                onChanged: (value) => controller.genero.value = value,
              ),

              // Campos adicionais do motorista
              TextField(
                decoration: const InputDecoration(labelText: 'Chave Pix'),
                onChanged: (value) => controller.chavePix.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'CEP'),
                onChanged: (value) => controller.cep.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Endereço'),
                onChanged: (value) => controller.endereco.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Número'),
                onChanged: (value) => controller.numero.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Complemento'),
                onChanged: (value) => controller.complemento.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Bairro'),
                onChanged: (value) => controller.bairro.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'UF'),
                onChanged: (value) => controller.uf.value = value,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Placa do Veículo'),
                onChanged: (value) => controller.placaVeiculo.value = value,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Modelo do Veículo'),
                onChanged: (value) => controller.modeloVeiculo.value = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Ano do Veículo'),
                onChanged: (value) =>
                    controller.anoVeiculo.value = int.parse(value),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Cor do Veículo'),
                onChanged: (value) => controller.corVeiculo.value = value,
              ),

              const SizedBox(height: 20),

              // Selecionar documentos ou imagens (CNH, Documento do Veículo, Foto de Rosto)
              ElevatedButton(
                onPressed: () => controller.selectDocumentOrImage('cnh'),
                child: const Text('Selecionar CNH (Imagem ou PDF)'),
              ),
              Obx(() {
                if (controller.cnhDocumento.value != null) {
                  return Text(
                      'CNH Selecionada: ${controller.cnhDocumento.value!.path}');
                } else {
                  return const Text('Nenhuma CNH selecionada');
                }
              }),

              ElevatedButton(
                onPressed: () => controller.selectDocumentOrImage('veiculo'),
                child: const Text(
                    'Selecionar Documento do Veículo (Imagem ou PDF)'),
              ),
              Obx(() {
                if (controller.veiculoDocumento.value != null) {
                  return Text(
                      'Documento do Veículo Selecionado: ${controller.veiculoDocumento.value!.path}');
                } else {
                  return const Text('Nenhum Documento do Veículo selecionado');
                }
              }),

              ElevatedButton(
                onPressed: () => controller.selectDocumentOrImage('rosto'),
                child: const Text('Selecionar Foto de Rosto'),
              ),
              Obx(() {
                if (controller.fotoRosto.value != null) {
                  return Image.file(controller.fotoRosto.value!, height: 100);
                } else {
                  return const Text('Nenhuma foto de rosto selecionada');
                }
              }),
              CheckboxListTile(
                title: const Text('Aceito os termos'),
                value: controller.termoAceite.value,
                onChanged: (value) =>
                    controller.termoAceite.value = value ?? false,
              ),

              const SizedBox(height: 20),

              // Botão de registro
              ElevatedButton(
                onPressed: () => controller.register(),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
