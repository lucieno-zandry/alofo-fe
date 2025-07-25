import 'dart:io';
import 'package:logger/logger.dart';

class FileLogOutput extends LogOutput {
  final File logFile;
  IOSink? _sink;

  FileLogOutput(this.logFile);

  @override
  void output(OutputEvent event) {
    _sink ??= logFile.openWrite(mode: FileMode.append);
    for (var line in event.lines) {
      _sink!.writeln(line);
    }
    _sink!.flush();
  }
}

// Use a function to create the logger when needed
Logger createFileLogger() {
  final logFile = File('${Directory.systemTemp.path}/alofo_log.txt');
  return Logger(
    printer: PrettyPrinter(),
    output: FileLogOutput(logFile),
  );
}