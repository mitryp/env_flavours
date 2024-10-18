import 'package:get_it/get_it.dart';

import '../application/configuration_service/configuration_service.dart';
import '../application/configuration_service/configuration_service_impl.dart';
import '../application/name_service/env_name_service.dart';
import '../application/name_service/env_name_service_impl.dart';
import '../application/parser/env_parser.dart';
import '../application/parser/env_parser_impl.dart';
import '../application/preprocessor/env_preprocessor.dart';
import '../application/preprocessor/env_preprocessor_impl.dart';
import '../application/resolver/configuration_resolver.dart';
import '../application/resolver/configuration_resolver_impl.dart';

final getIt = GetIt.instance;

GetIt configureInjections() => getIt
  ..registerFactory<EnvNameService>(() => const EnvNameServiceImpl())
  ..registerFactory<EnvParser>(
    () => EnvParserImpl(config: getIt(), nameService: getIt()),
  )
  ..registerFactory<EnvPreprocessor>(
    () => EnvPreprocessorImpl(nameService: getIt()),
  )
  ..registerFactory<ConfigurationResolver>(
    () => ConfigurationResolverImpl(config: getIt(), parser: getIt()),
  )
  ..registerFactory<ConfigurationService>(
    () => ConfigurationServiceImpl(config: getIt(), preprocessor: getIt()),
  );
