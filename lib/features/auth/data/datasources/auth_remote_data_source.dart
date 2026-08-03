import 'package:galena_network/galena_network.dart';

import '../../../../core/telemetry/app_telemetry.dart';
import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/auth_repository.dart';
import '../dtos/login_response_dto.dart';
import 'auth_data_source.dart';

/// Autentica na Galena API (`core-accounts`) via [AuthApi].
///
/// A camada de rede devolve o corpo cru; aqui ele é parseado no
/// [LoginResponseDto] do app. Traduz falhas (`GalenaApiException`) em
/// [AuthException] com a mensagem pronta para a tela e, em sucesso, vincula o
/// `account_id` à telemetria. A sessão é mantida por cookie no client.
class AuthRemoteDataSource implements AuthDataSource {
  const AuthRemoteDataSource(this._authApi);

  final AuthApi _authApi;

  @override
  Future<void> authenticate(LoginCredentials credentials) async {
    try {
      final Map<String, dynamic> body = await _authApi.login(
        cpf: credentials.cpf,
        password: credentials.password,
      );
      final LoginResponseDto res = LoginResponseDto.fromJson(body);
      if (res.user.accountId.isNotEmpty) {
        AppTelemetry.setUser(res.user.accountId);
      }
    } on GalenaApiException catch (e) {
      throw AuthException(e.message);
    }
  }
}
