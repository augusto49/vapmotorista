class User {
  final int userId;
  final bool isDriver;
  final String email;
  final String fullName;
  final String accessToken;
  final String refreshToken;
  final String cidade;
  final String telefone;
  final String cpf;
  final String dataNascimento;
  final String genero;
  final String? chavePix;
  final String? fotoRosto;
  final String cep;
  final String endereco;
  final String numero;
  final String? complemento;
  final String bairro;
  final String uf;
  final String? cnhDocumento;
  final String? veiculoDocumento;
  final String placaVeiculo;
  final String modeloVeiculo;
  final int anoVeiculo;
  final String corVeiculo;
  final bool termoAceite;
  final String status;

  User({
    required this.userId,
    required this.isDriver,
    required this.email,
    required this.fullName,
    required this.accessToken,
    required this.refreshToken,
    required this.cidade,
    required this.telefone,
    required this.cpf,
    required this.dataNascimento,
    required this.genero,
    this.chavePix,
    this.fotoRosto,
    required this.cep,
    required this.endereco,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.uf,
    this.cnhDocumento,
    this.veiculoDocumento,
    required this.placaVeiculo,
    required this.modeloVeiculo,
    required this.anoVeiculo,
    required this.corVeiculo,
    required this.termoAceite,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? 0,
      isDriver: json['is_driver'],
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      cidade: json['cidade'] ?? '',
      telefone: json['telefone'] ?? '',
      cpf: json['cpf'] ?? '',
      dataNascimento: json['data_nascimento'] ?? '',
      genero: json['genero'] ?? '',
      chavePix: json['chave_pix'],
      fotoRosto: json['foto_rosto'],
      cep: json['cep'] ?? '',
      endereco: json['endereco'] ?? '',
      numero: json['numero'] ?? '',
      complemento: json['complemento'],
      bairro: json['bairro'] ?? '',
      uf: json['uf'] ?? '',
      cnhDocumento: json['cnh_documento'],
      veiculoDocumento: json['veiculo_documento'],
      placaVeiculo: json['placa_veiculo'] ?? '',
      modeloVeiculo: json['modelo_veiculo'] ?? '',
      anoVeiculo: json['ano_veiculo'] ?? 0,
      corVeiculo: json['cor_veiculo'] ?? '',
      termoAceite: json['termo_aceite'] ?? false,
      status: json['status'] ?? 'pending',
    );
  }
}
