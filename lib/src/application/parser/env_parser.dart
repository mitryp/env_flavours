import 'dart:io';

import '../../domain/typedefs.dart';

abstract interface class EnvParser {
  /// Tries to parse an [EnvConfiguration] from the given [file].
  /// If the file is not an [EnvConfiguration], returns null.
  Future<EnvConfiguration?> parse(File file);
}
