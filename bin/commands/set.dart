import 'package:args/command_runner.dart';
import 'package:env_flavours/src/application/configuration_service/configuration_service.dart';
import 'package:env_flavours/src/application/resolver/configuration_resolver.dart';
import 'package:env_flavours/src/domain/typedefs.dart';
import 'package:env_flavours/src/utils/configuration_utils.dart';
import 'package:env_flavours/src/utils/injections.dart';
import 'package:io/ansi.dart';

import '../config/print_config.dart';
import '../config/run_configuration_parser.dart';

class SetCommand extends Command<void> {
  SetCommand() {
    configureParser(argParser);
  }

  @override
  String get description =>
      'Replaces the env file with the configuration from the sources directory matching the given name';

  @override
  String get name => 'set';

  @override
  Future<void> run() async {
    final argResults = this.argResults!;

    final targetConfiguration = argResults.rest.singleOrNull;

    if (targetConfiguration == null) {
      return print(
        wrapWith(
          'Could not parse \'${argResults.rest.join(' ')}\'\n'
          'If your configuration name contains spaces, please use quotes.',
          [red],
        ),
      );
    }

    final config = parseRunConfig(argResults);

    configureInjections() // register the parsed configuration
        .registerSingleton<RunConfiguration>(config);

    final resolver = getIt<ConfigurationResolver>();

    printConfig(config);

    final configurations = await resolver.resolveConfigurations();
    final file = configurations[targetConfiguration];

    if (file == null) {
      return print(
        wrapWith(
          'No configuration named $targetConfiguration '
          'was found in ${config.envDirName}',
          [red],
        ),
      );
    }

    final toApply = MapEntry(targetConfiguration, file).toConfiguration();

    print('Applying configuration ${toApply.present()}');

    final service = getIt<ConfigurationService>();
    await service.apply(toApply);

    print(wrapWith('Success', [cyan]));
  }
}

extension on EnvConfiguration {
  String present() => '${wrapWith(name, [styleBold])} (${file.path})';
}
