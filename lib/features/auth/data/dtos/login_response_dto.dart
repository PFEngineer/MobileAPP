/// DTO da resposta do login da Galena (`POST /accounts/login`).
///
/// O `galena_network` devolve o corpo cru (`{ expires_in, user }`); o parse/DTO
/// vive aqui, no app. `AccountSummary` está mínimo (só `account_id`) — amplie ao
/// implementar `/accounts/me`.
class LoginResponseDto {
  const LoginResponseDto({required this.expiresIn, required this.user});

  /// Parse tolerante do corpo cru devolvido pela camada de rede.
  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> user =
        (json['user'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    return LoginResponseDto(
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
      user: AccountSummaryDto.fromJson(user),
    );
  }

  /// Validade da sessão em segundos (`expires_in`).
  final int expiresIn;

  /// Retrato da conta autenticada (`user`).
  final AccountSummaryDto user;
}

/// Retrato da conta (`user`) — mesmo objeto de `GET /accounts/me`.
class AccountSummaryDto {
  const AccountSummaryDto({required this.accountId});

  factory AccountSummaryDto.fromJson(Map<String, dynamic> json) =>
      AccountSummaryDto(accountId: json['account_id'] as String? ?? '');

  /// Identificador da conta (`account_id`).
  final String accountId;
}
