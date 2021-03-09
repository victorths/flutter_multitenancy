import '../../common/utils/pubspec/pubspec_lock.dart';

// use from commands/ipml/version/version.dart
@deprecated
Future<void> versionCommand() async {
  var version = await PubspecLock.getVersionCli();
  if (version == null) return;
  print('Version: $version');
}
