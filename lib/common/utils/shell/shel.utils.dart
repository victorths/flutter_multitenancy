import 'dart:io';

import 'package:process_run/process_run.dart';

import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/log_utils.dart';
import '../pub_dev/pub_dev_api.dart';
import '../pubspec/pubspec_lock.dart';

class ShellUtils {
  static Future<void> pubGet() async {
    LogService.info('Running `flutter pub get` …');
    await run('flutter', ['pub', 'get'], verbose: true);
  }

  static Future<void> generateIcon() async {
    LogService.info('Generating native icons …');
    await run('flutter', ['pub', 'run', 'flutter_launcher_icons:main'],
        verbose: true);
  }

  static Future<void> generateSplash() async {
    LogService.info('Generating splash …');
    await run('flutter', ['pub', 'run', 'flutter_native_splash:create'],
        verbose: true);
  }

  static Future<void> build(String type) async {
    LogService.info('Generating splash …');
    await run('flutter', ['build', type, '--release'], verbose: true);
  }

  static Future<void> update(
      [bool isGit = false, bool forceUpdate = false]) async {
    isGit = FlutterMultitenancy.arguments.contains('--git');
    forceUpdate = FlutterMultitenancy.arguments.contains('-f');
    if (!isGit && !forceUpdate) {
      var versionInPubDev =
          await PubDevApi.getLatestVersionFromPackage('flutter_multitenancy');

      var versionInstalled = await PubspecLock.getVersionCli(disableLog: true);

      if (versionInstalled == versionInPubDev) {
        return LogService.info(
            Translation(LocaleKeys.info_cli_last_version_already_installed.tr));
      }
    }

    LogService.info('Upgrading flutter_multitenancy …');
    var res;
    if (Platform.script.path.contains('flutter')) {
      if (isGit) {
        res = await run(
            'flutter',
            [
              'pub',
              'global',
              'activate',
              '-sgit',
              'https://github.com/victorths/flutter_multitenancy/'
            ],
            verbose: true);
      } else {
        res = await run(
            'flutter',
            [
              'pub',
              'global',
              'activate',
              'flutter_multitenancy',
            ],
            verbose: true);
      }
    } else {
      if (isGit) {
        res = await run(
            'dart',
            [
              'pub',
              'global',
              'activate',
              '-sgit',
              'https://github.com/victorths/flutter_multitenancy'
            ],
            verbose: true);
      } else {
        res = await run(
            'dart',
            [
              'pub',
              'global',
              'activate',
              'flutter_multitenancy',
            ],
            verbose: true);
      }
    }
    if (res.stderr.toString().isNotEmpty) {
      return LogService.error(LocaleKeys.error_update_cli.tr);
    }
    LogService.success(LocaleKeys.sucess_update_cli.tr);
  }
}
