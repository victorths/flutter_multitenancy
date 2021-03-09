import '../../../common/utils/pubspec/pubspec_lock.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../interface/command.dart';

// ignore_for_file: avoid_print

class VersionCommand extends Command {
  @override
  String get commandName => '-version';
  @override
  Future<void> execute() async {
    var version = await PubspecLock.getVersionCli();
    if (version == null) return;
    print('Version: $version');
  }

  @override
  String get hint => Translation(LocaleKeys.hint_version).tr;
  @override
  List<String> get alias => ['-v'];
  @override
  bool validate() {
    return true;
  }
}
