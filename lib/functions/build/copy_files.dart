import 'dart:async';

import 'package:io/io.dart';

FutureOr<void> copyFiles(String tenantName) async {
  await copyPath("./tenants/" + tenantName, "./");
  // await copyPath("../example/tenants/" + tenantName, "../example");
}
