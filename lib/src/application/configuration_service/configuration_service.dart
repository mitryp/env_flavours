import '../../domain/typedefs.dart';

abstract interface class ConfigurationService {
  Future<void> apply(EnvConfiguration sourceConf);
}
