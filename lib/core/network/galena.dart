import 'package:cookie_jar/cookie_jar.dart';
import 'package:galena_network/galena_network.dart';
import 'package:path_provider/path_provider.dart';

import '../telemetry/app_telemetry.dart';

/// Ambiente da Galena API selecionado no build.
///
/// Definido por `--dart-define=GALENA_ENV=hml|prd` (o flavor Android / scheme
/// iOS passam esse define). Default: `hml`.
const String _galenaEnvName = String.fromEnvironment(
  'GALENA_ENV',
  defaultValue: 'hml',
);

/// URLs (host) por ambiente — **injetadas pelo app**. O `galena_network` não
/// hardcoda URL; aqui é a única fonte da baseURL de HML/PRD.
const Map<String, String> _galenaHosts = <String, String>{
  'hml': 'https://api.hml.galena.capital',
  'prd': 'https://api.galena.capital',
};

/// baseURL (host) da Galena para o ambiente atual.
String get galenaBaseUrl => _galenaHosts[_galenaEnvName] ?? _galenaHosts['hml']!;

/// Client HTTP da Galena. Disponível após [initGalenaNetwork].
late final GalenaNetworkClient galenaClient;

/// APIs de autenticação/sessão da Galena. Disponível após [initGalenaNetwork].
late final AuthApi galenaAuthApi;

/// Inicializa a rede da Galena no boot (antes de montar as dependências).
///
/// Usa um [PersistCookieJar] apontando para um diretório do app, então a sessão
/// (cookies `galena_*`) **sobrevive entre execuções**. Erros de rede são
/// reportados ao `core_telemetry` via [AppTelemetry].
Future<void> initGalenaNetwork() async {
  final dir = await getApplicationSupportDirectory();
  final cookieJar = PersistCookieJar(
    storage: FileStorage('${dir.path}/galena_cookies'),
  );
  galenaClient = GalenaNetworkClient(
    baseUrl: galenaBaseUrl,
    cookieJar: cookieJar,
    onError:
        (
          Object error,
          StackTrace? stackTrace,
          Map<String, Object?> attributes,
        ) => AppTelemetry.recordError(
          error,
          stackTrace: stackTrace,
          attributes: attributes,
        ),
  );
  galenaAuthApi = AuthApi(galenaClient);
}
