import 'dart:io';

/// An environment configuration having a [name] and a source [File] [file].
typedef EnvConfiguration = ({String name, File file});

/// A [Map] matching configuration names with their source files.
typedef ConfigurationMap = Map<String, File>;

/// A configuration for the current package execution.
typedef RunConfiguration = ({String envFileName, String envDirName});
