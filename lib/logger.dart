import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final _dateFormat = DateFormat('HH:mm dd/MM/yyyy');

/// Application-wide [Logger] instance.
///
/// Compact, colored output without emojis or boxes. Each entry shows the
/// timestamp and the caller location (file name and line number); errors also
/// include a stack trace.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    colors: true,
    printEmojis: false,
    noBoxingByDefault: true,
    dateTimeFormat: _dateFormat.format,
  ),
);
