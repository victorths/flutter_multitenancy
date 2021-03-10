import '../../../common/utils/logger/log_utils.dart';
import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../exception_handler/exceptions/cli_exception.dart';
import '../../interface/command.dart';

class BuildCommand extends Command {
  @override
  String get commandName => 'build';

  @override
  List<String> get acceptedFlags => ['--icon', '--splash'];

  @override
  Future<void> execute() async {}

  @override
  String get hint => Translation(LocaleKeys.hint_build).tr;

  @override
  bool validate() {
    var flagsNotAceppts = flags;
    flagsNotAceppts.removeWhere((element) => acceptedFlags.contains(element));
    if (flagsNotAceppts.isNotEmpty) {
      LogService.info(LocaleKeys.info_unnecessary_flag.trArgsPlural(
        LocaleKeys.info_unnecessary_flag_prural,
        flagsNotAceppts.length,
        [flagsNotAceppts.toString()],
      ));
    }
    var args = List<String>.from(FlutterMultitenancy.arguments);
    args.removeAt(0);
    if (args.isEmpty) {
      final codeSample1 = LogService.code('multitenancy build apk geld');
      throw CliException(
          'Por favor, digite o nome do tenant que deseja buildar',
          codeSample: '''
  $codeSample1
''');
    }
    return true;
  }
}
