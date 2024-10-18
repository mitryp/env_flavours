import 'dart:io';

import '../domain/typedefs.dart';

extension MapToConfigurations on ConfigurationMap {
  Iterable<EnvConfiguration> get configurations =>
      entries.map((e) => (name: e.key, file: e.value));
}

extension ConfigurationsToMap on Iterable<EnvConfiguration> {
  ConfigurationMap toConfigurationMap() =>
      Map.fromEntries(map((e) => e.toMapEntry()));
}

extension ConfigurationToMapEntry on EnvConfiguration {
  MapEntry<String, File> toMapEntry() => MapEntry(name, file);
}
