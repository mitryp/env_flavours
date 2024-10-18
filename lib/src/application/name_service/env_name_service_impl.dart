import 'env_name_service.dart';

class EnvNameServiceImpl implements EnvNameService {
  static final _nameDeclarationRegexp = RegExp(r'^#\[(.+)]$');

  const EnvNameServiceImpl();

  @override
  String createNameDeclaration(String confName) => '#[$confName]';

  @override
  String? readNameDeclarationLine(String line) =>
      _nameDeclarationRegexp.matchAsPrefix(line)?.group(1);
}
