import 'package:flutter_multitenancy/commands/impl/build/app_bundle.dart';
import 'package:flutter_multitenancy/commands/impl/build/ios.dart';

import 'impl/commads_export.dart';
import 'interface/command.dart';

final List<Command> commands = [
  CommandParent(
    "build",
    [
      BuildApkCommand(),
      BuildIosCommand(),
      BuildAppbundleCommand(),
    ],
    ['b'],
  ),
  SwitchTenantCommand(),
  HelpCommand(),
  VersionCommand(),
  UpdateCommand(),
];

class CommandParent extends Command {
  final String _name;
  final List<String> _alias;
  final List<Command> _childrens;
  CommandParent(this._name, this._childrens, [this._alias = const []]);

  @override
  String get commandName => _name;
  @override
  List<Command> get childrens => _childrens;
  @override
  List<String> get alias => _alias;

  @override
  Future<void> execute() async {}

  @override
  String get hint => '';

  @override
  bool validate() => true;
}
