import 'package:flutter_multitenancy/commands/impl/build/build.dart';
import 'package:flutter_multitenancy/common/utils/logger/log_utils.dart';
import 'package:flutter_multitenancy/common/utils/shell/shel.utils.dart';
import 'package:flutter_multitenancy/core/generator.dart';
import 'package:flutter_multitenancy/functions/build/copy_files.dart';
import 'package:flutter_multitenancy/functions/build/run_flag.dart';

class BuildAppbundleCommand extends BuildCommand {
  @override
  String get commandName => 'appbundle';

  @override
  Future<void> execute() async {
    var args = List<String>.from(FlutterMultitenancy.arguments);
    args.removeRange(0, 2);
    var tenants = args.where((element) => !element.startsWith('-')).toList();
    var buildFlags =
        flags.where((flag) => acceptedFlags.contains(flag)).toList();

    if (tenants.length == 1) {
      var tenantName = tenants.first;
      LogService.info('Copying tenant "$tenantName" files …');
      await copyFiles(tenantName);
      await ShellUtils.pubGet();
      if (buildFlags.isEmpty) {
        buildFlags.forEach((flag) {
          runFlag(flag);
        });
      }
      LogService.info('Building "$tenantName" $commandName …');
      await ShellUtils.build(commandName);
    } else {
      for (var element in tenants) {
        var tenantName = element;
        LogService.info('Copying tenant "$tenantName" files …');
        await copyFiles(tenantName);
        await ShellUtils.pubGet();
        buildFlags.forEach((flag) {
          runFlag(flag);
        });
        LogService.info('Building "$tenantName" $commandName …');
        await ShellUtils.build(commandName);
      }
    }
  }
}
