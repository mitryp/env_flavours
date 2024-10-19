import 'package:env_flavours/src/domain/typedefs.dart';
import 'package:io/ansi.dart';

void printConfig(RunConfiguration config) {
  print(wrapWith('Run configuration:', [cyan, styleBold]));
  print(
    '  env: ${wrapWith(config.envFileName, [styleBold])}\n'
    '  sources: ${wrapWith(config.envDirName, [styleBold])}\n',
  );
}
