import 'dart:io';

import '../../domain/typedefs.dart';
import '../../utils/configuration_utils.dart';
import '../parser/env_parser.dart';
import 'configuration_resolver.dart';

class ConfigurationResolverImpl implements ConfigurationResolver {
  final RunConfiguration config;
  final EnvParser parser;

  const ConfigurationResolverImpl({
    required this.config,
    required this.parser,
  });

  @override
  Future<ConfigurationMap> resolveConfigurations() async {
    final envDir = Directory(config.envDirName);

    if (!await envDir.exists()) {
      return {};
    }

    final entities = await envDir.list().toList();
    final nullableConfigurations =
        await Future.wait(entities.whereType<File>().map(parser.parse));

    return nullableConfigurations.nonNulls.toConfigurationMap();
  }

  @override
  Future<EnvConfiguration?> resolveCurrent() async {
    final envFile = File(config.envFileName);

    if (!await envFile.exists()) {
      return null;
    }

    return parser.parse(envFile);
  }
}
