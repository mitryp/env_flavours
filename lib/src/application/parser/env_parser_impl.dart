import 'dart:io';

import 'package:path/path.dart';

import '../../domain/typedefs.dart';
import '../name_service/env_name_service.dart';
import 'env_parser.dart';

class EnvParserImpl implements EnvParser {
  final RunConfiguration config;
  final EnvNameService nameService;

  const EnvParserImpl({
    required this.config,
    required this.nameService,
  });

  @override
  Future<EnvConfiguration?> parse(File file) async {
    final fileName = basename(file.path);
    late final cleanFileName = basenameWithoutExtension(fileName);

    if (!fileName.endsWith(config.envFileName)) {
      return null;
    }

    final lines = await file.readAsLines();
    final line = lines.firstOrNull;
    final maybeName =
        line != null ? nameService.readNameDeclarationLine(line) : null;

    if (maybeName == null && cleanFileName.isEmpty) {
      return null;
    }

    return (name: maybeName ?? cleanFileName, file: file);
  }
}
