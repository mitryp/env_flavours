import 'dart:io';

import '../../domain/typedefs.dart';
import '../name_service/env_name_service.dart';
import 'env_preprocessor.dart';

class EnvPreprocessorImpl implements EnvPreprocessor {
  final EnvNameService nameService;

  const EnvPreprocessorImpl({required this.nameService});

  @override
  Future<String> process(EnvConfiguration sourceConf) async {
    final processedLines = await _processAsLines(sourceConf);

    return processedLines.join(Platform.lineTerminator);
  }

  Future<List<String>> _processAsLines(EnvConfiguration sourceConf) async {
    final lines = await sourceConf.file.readAsLines();

    final declaredName = nameService.readNameDeclarationLine(lines.first);

    if (declaredName == sourceConf.name) {
      return lines;
    }

    final newDeclarationLine =
        nameService.createNameDeclaration(sourceConf.name);

    return [
      newDeclarationLine,
      if (declaredName == null) lines.first,
      ...lines.skip(1),
    ];
  }
}
