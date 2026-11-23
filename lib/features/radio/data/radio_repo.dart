import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islami_app/core/network/ipv4_http_client.dart';
import 'package:islami_app/features/radio/model/radio_model.dart';
import 'package:islami_app/features/radio/model/reciter_model.dart';

class RadioRepo {
  RadioRepo({http.Client? client}) : _client = client ?? createIPv4HttpClient();
  static const String _baseURL = 'https://www.mp3quran.net/api/v3';
  static const String _language = 'en';
  static const Duration _timeOut = Duration(seconds: 15);

  final http.Client _client;

  Future<List<RadioModel>> getRadios() async {
    final json = await _get('/radios');
    final radios = json['radios'] as List<dynamic>? ?? const [];
    return radios
        .map(
          (toElement) =>
              RadioModel.fromJson(toElement as Map<String, dynamic>),
        )
        .toList(growable: false);
  }

  Future<List<ReciterModel>> getReciters() async {
    final json = await _get('/reciters');
    final reciters = json['reciters'] as List<dynamic>? ?? const [];
    return reciters
        .map(
          (toElement) =>
              ReciterModel.fromJson(toElement as Map<String, dynamic>),
        )
        .toList(growable: false);
  }

  Future<Map<String, dynamic>> _get(String path) async {
    final url = Uri.parse('$_baseURL$path?language=$_language');

    http.Response response;

    try {
      response = await _client.get(url).timeout(_timeOut);
    } on TimeoutException {
      throw const RadioApiException(
        'Request timed out. Check your connection.',
      );
    } catch (error) {
      throw RadioApiException('Network error: $error');
    }

    if (response.statusCode != 200) {
      throw RadioApiException(
        'Request failed with status ${response.statusCode}.',
      );
    }

    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));

      if (decoded is! Map<String, dynamic>) {
        throw const RadioApiException('Unexpected response format.');
      }

      return decoded;
    } on FormatException {
      throw const RadioApiException('Invalid JSON response.');
    }
  }

  void dispose() => _client.close();
}

class RadioApiException implements Exception {
  const RadioApiException(this.message);

  final String message;

  @override
  String toString() => message;
}