import 'package:flutter_multitenancy/commands/impl/build/build.dart';
import 'package:flutter_multitenancy/common/utils/logger/log_utils.dart';
import 'package:flutter_multitenancy/common/utils/shell/shel.utils.dart';
import 'package:flutter_multitenancy/core/generator.dart';
import 'package:flutter_multitenancy/functions/build/copy_files.dart';
import 'package:flutter_multitenancy/functions/build/run_flag.dart';

class SwitchTenantCommand extends BuildCommand {
  @override
  String get commandName => 'switch';

  @override
  List<String> get alias => ['sw'];

  @override
  Future<void> execute() async {
    var args = List<String>.from(FlutterMultitenancy.arguments);
    args.removeAt(0);
    var tenants = args.where((element) => !element.startsWith('-')).toList();
    var buildFlags =
        args.where((flag) => acceptedFlags.contains(flag)).toList();

    if (tenants.length == 1) {
      var tenantName = tenants.first;
      LogService.info('Copying tenant "$tenantName" files …');
      await copyFiles(tenantName);
      await ShellUtils.pubGet();
      buildFlags.forEach((flag) async {
        await runFlag(flag);
      });
    } else {
      for (var element in tenants) {
        var tenantName = element;
        LogService.info('Copying tenant "$tenantName" files …');
        await copyFiles(tenantName);
        await ShellUtils.pubGet();
        buildFlags.forEach((flag) {
          runFlag(flag);
        });
      }
    }
  }
}
