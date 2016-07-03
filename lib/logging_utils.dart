// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart' as logging;

logging.Logger _logger;

info(String message, [int level = 0]) => _logger.info(_repeat("\t", level), message);
trace(String message, [int level = 0]) => _logger.finer(_repeat("\t", level), message);
debug(String message, [int level = 0]) => _logger.fine(_repeat("\t", level), message);
alert(String message, [int level = 0]) => _logger.shout(_repeat("\t", level), message);

perf(String name, int ms) => _logger.fine("PERF: $name : $ms");

/// Setup log streaming to the right place for local and remote deployment.
setupLogging([String loggerName = "sintr_common"]) {
  _logger = new logging.Logger(loggerName);

  // TODO(lukechurch): Add support for container logs
  _setupLocalLogging();
}

/// Setup log streaming to stdOut.
_setupLocalLogging() {
  // Setup the logging
  logging.hierarchicalLoggingEnabled = false;
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
    print('${rec.loggerName}: ${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

String _repeat(String s, int count) {
  StringBuffer sb = new StringBuffer();
  for (int i = 0; i < count; i++) {
    sb.write(s);
  }
  return sb.toString();
}
