import 'dart:async';

import 'dart:io';

FutureOr<void> renameFile(String filePath, String newFileName) async {
  var file = File(filePath);
  await file.rename(newFileName);
}
