import 'package:flutter_multitenancy/core/generator.dart';
import 'package:flutter_multitenancy/exception_handler/exception_handler.dart';

Future<void> main(List<String> arguments) async {
  final command = FlutterMultitenancy(arguments).findCommand();

  if (arguments.contains('--debug')) {
    if (command.validate()) {
      await command.execute();
      // await command.execute().then((value) => checkForUpdate());
    }
  } else {
    try {
      if (command.validate()) {
        await command.execute();
        // await command.execute().then((value) => checkForUpdate());
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
  }
}
