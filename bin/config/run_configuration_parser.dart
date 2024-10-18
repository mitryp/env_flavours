import 'package:args/args.dart';
import 'package:env_flavours/src/domain/typedefs.dart';

const envFileFlagName = 'env';
const envFileFlagDefault = '.env';
const envsDirFlagName = 'sources';
const envsDirFlagDefault = 'envs';

RunConfiguration parseRunConfig(ArgResults results) {
  final envFileName = results.option(envFileFlagName) ?? envFileFlagDefault;
  final envDirName = results.option(envsDirFlagName) ?? envsDirFlagDefault;

  return (envDirName: envDirName, envFileName: envFileName);
}

void configureParser(ArgParser parser) {
  parser
    ..addOption(envFileFlagName, abbr: 'n', defaultsTo: envFileFlagDefault)
    ..addOption(envsDirFlagName, abbr: 's', defaultsTo: envsDirFlagDefault);
}
