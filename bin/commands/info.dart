import 'package:args/command_runner.dart';
import 'package:env_flavours/src/application/resolver/configuration_resolver.dart';
import 'package:env_flavours/src/domain/typedefs.dart';
import 'package:env_flavours/src/utils/configuration_utils.dart';
import 'package:env_flavours/src/utils/injections.dart';
import 'package:io/ansi.dart';

import '../config/run_configuration_parser.dart';
import '../config/print_config.dart';

class InfoCommand extends Command<void> {
  InfoCommand() {
    configureParser(argParser);
  }

  @override
  String get description =>
      'Prints the current dotenv configuration and configured flavours';

  @override
  String get name => 'info';

  @override
  Future<void> run() async {
    final argResults = this.argResults!;
    final config = parseRunConfig(argResults);

    configureInjections() // register the parsed configuration
        .registerSingleton<RunConfiguration>(config);

    final resolver = getIt<ConfigurationResolver>();

    printConfig(config);

    print(wrapWith('Environments in \'${config.envDirName}\':', [cyan, styleBold]));
    final configurations = await resolver.resolveConfigurations();
    if (configurations.isEmpty) {
      print(wrapWith(' - None', [red]));
    }
    for (final conf in configurations.configurations) {
      print(' - ${conf.present()}');
    }

    print(wrapWith('\nCurrent environment: ', [cyan, styleBold]));
    final current = await resolver.resolveCurrent();
    if (current != null) {
      print(' - ${current.present()}');
    } else {
      print(wrapWith(' - None', [red]));
    }
  }
}

extension on EnvConfiguration {
  String present() => '${wrapWith(name, [styleBold])} (${file.path})';
}
