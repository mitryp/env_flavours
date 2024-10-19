import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:env_flavours/src/domain/constants.dart';

import 'commands/info.dart';
import 'commands/set.dart';

CommandRunner<void> buildRunner() {
  final commands = [
    InfoCommand(),
    SetCommand(),
  ];

  final runner = CommandRunner(packageName, packageDescription);

  for (final command in commands) {
    runner.addCommand(command);
  }

  runner.argParser.addFlag(
    'version',
    negatable: false,
    help: 'Prints the tool version.',
  );

  return runner;
}

void printUsage(ArgParser argParser) {
  print('Usage: env_flavours <flags> [arguments]');
  print(argParser.usage);
}

Future<void> main(List<String> args) async {
  final runner = buildRunner();

  try {
    final results = runner.parse(args);

    if (results.wasParsed('help')) {
      return printUsage(runner.argParser);
    }

    if (results.wasParsed('version')) {
      return print('env_flavours version: $packageVersion');
    }

    await runner.run(args);
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(runner.argParser);
  }
}
