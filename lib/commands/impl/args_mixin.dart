import 'package:http/http.dart';

import '../../core/generator.dart';

mixin ArgsMixin {
  final List<String> _args = FlutterMultitenancy.arguments;

  List<String> args = _getArgs();

  List<String> flags = _getFlags();

  String get onCommand {
    return _getArg('on');
  }

  String get withArgument {
    return _getArg('with');
  }

  String get fromArgument {
    return _getArg('from');
  }

  String get name {
    if (_args.first == 'init') {
      return 'home';
    } else {
      return _args[1].split(':').length == 1 || _args[1].split(':')[1].isEmpty
          ? (_args[1].split(':').first == 'project' ? '.' : 'home')
          : _args[1].split(':')[1];
    }
  }

  bool containsArg(String flag) {
    return _args.contains(flag);
  }
}

List<String> _getArgs() {
  var args = List.of(FlutterMultitenancy.arguments);
  var defaultArgs = ['on', 'home', 'from', 'with'];

  for (var arg in defaultArgs) {
    var indexArg = args.indexWhere((element) => (element == arg));
    if (indexArg != -1 && indexArg + 1 < args.length) {
      args..removeAt(indexArg)..removeAt(indexArg);
    }
  }
  args.removeWhere((element) => element.startsWith('-'));
  return args;
}

List<String> _getFlags() {
  var args = List.of(FlutterMultitenancy.arguments);
  var flags = args.where((element) {
    return element.startsWith('-') && element != '--debug';
  }).toList();

  return flags;
}

int _getIndexArg(String arg) {
  return FlutterMultitenancy.arguments.indexWhere((element) => element == arg);
}

String _getArg(String arg) {
  var index = _getIndexArg(arg);
  if (index != -1) {
    if (index + 1 < FlutterMultitenancy.arguments.length) {
      index++;
      return FlutterMultitenancy.arguments[index];
    } else {
      throw ClientException("the '$arg' argument is empty");
    }
  }

  return '';
}
