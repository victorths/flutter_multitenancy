import 'dart:async';

import 'package:flutter_multitenancy/common/utils/shell/shel.utils.dart';

FutureOr<void> runFlag(String flag) async {
  if (flag == '--icon') await ShellUtils.generateIcon();
  if (flag == '--splash') await ShellUtils.generateSplash();
}
