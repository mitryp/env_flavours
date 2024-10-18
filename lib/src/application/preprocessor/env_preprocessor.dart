import 'dart:async';

import '../../domain/typedefs.dart';

abstract interface class EnvPreprocessor {
  /// Returns a content for the new env configuration to be written, ensuring
  /// that the output contains an env name declaration comment line.
  Future<String> process(EnvConfiguration sourceConf);
}
