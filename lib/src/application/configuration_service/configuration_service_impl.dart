import 'dart:io';

import '../../domain/typedefs.dart';
import '../preprocessor/env_preprocessor.dart';
import 'configuration_service.dart';

class ConfigurationServiceImpl implements ConfigurationService {
  final RunConfiguration config;
  final EnvPreprocessor preprocessor;

  const ConfigurationServiceImpl({
    required this.config,
    required this.preprocessor,
  });

  @override
  Future<void> apply(EnvConfiguration sourceConf) async {
    final content = await preprocessor.process(sourceConf);

    final targetFile = File(config.envFileName);

    await targetFile.writeAsString(
      content,
      mode: FileMode.writeOnly,
      flush: true,
    );
  }
}
