import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class SSLPinning extends IOClient {
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    return securityContext;
  }

  Future<Response> getResponse(Uri url, {Map<String, String>? headers}) async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback = (cert, host, port) => false;
    IOClient ioClient = IOClient(httpClient);

    return ioClient.get(url);
  }
}
