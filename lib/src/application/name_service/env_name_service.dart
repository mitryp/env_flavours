abstract interface class EnvNameService {
  /// Returns a formatted name declaration for the configuration with the
  /// given [confName].
  String createNameDeclaration(String confName);

  /// Tries to parse a configuration name from the given [line] in the format
  /// of the [createNameDeclaration] output.
  String? readNameDeclarationLine(String line);
}
