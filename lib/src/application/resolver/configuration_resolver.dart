import '../../domain/typedefs.dart';

abstract interface class ConfigurationResolver {
  /// Returns the existing environment configurations within the env sources directory.
  Future<ConfigurationMap> resolveConfigurations();

  /// Returns the current [EnvConfiguration] in the directory, if any is present.
  Future<EnvConfiguration?> resolveCurrent();
}
