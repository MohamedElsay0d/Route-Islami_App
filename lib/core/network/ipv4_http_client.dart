import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// بيعمل http client بيستخدم IPv4 بس.
/// السبب: شبكة الـ Android emulator فيها IPv6 بايظ،
/// فـ Dart بيحاول IPv6 ويستنى لحد الـ timeout.
///
/// على موبايل حقيقي ممكن تستخدم http.Client() عادي وتشيل الملف ده.
http.Client createIPv4HttpClient() {
  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15)
    ..connectionFactory = _connect;

  return IOClient(client);
}

Future<ConnectionTask<Socket>> _connect(
  Uri uri,
  String? proxyHost,
  int? proxyPort,
) async {
  final host = proxyHost ?? uri.host;
  final port = proxyPort ?? uri.port;

  // 1) هات عنوان IPv4 بس
  final addresses = await InternetAddress.lookup(
    host,
    type: InternetAddressType.IPv4,
  );

  // 2) اتصل TCP
  final socket = await Socket.connect(
    addresses.isEmpty ? host : addresses.first,
    port,
    timeout: const Duration(seconds: 15),
  );

  // 3) لو مش https (أو فيه proxy) رجّع الـ socket زي ما هو
  if (proxyHost != null || uri.scheme != 'https') {
    return ConnectionTask.fromSocket<Socket>(
      Future<Socket>.value(socket),
      socket.destroy,
    );
  }

  // 4) https: اعمل TLS بنفسك
  try {
    final secureSocket = await SecureSocket.secure(socket, host: uri.host);

    return ConnectionTask.fromSocket<SecureSocket>(
      Future<SecureSocket>.value(secureSocket),
      secureSocket.destroy,
    );
  } catch (_) {
    socket.destroy();
    rethrow;
  }
}