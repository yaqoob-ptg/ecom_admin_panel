// // import 'package:admin/core/routes/app_pages.dart';
// // // import 'package:get/get_connect.dart';
// // import 'package:get/get.dart';
// // import '../utility/constants.dart';
// // import 'package:get_storage/get_storage.dart';

// // class HttpService {
// //   final String baseUrl = MAIN_URL;
// //   final box = GetStorage();

// //   Response _handleResponse(Response response) {
// //     // 🔐 Unauthorized
// //     if (response.statusCode == 401) {
// //       box.remove('accessToken');
// //       box.remove('refreshToken');
// //       Get.offAllNamed(AppPages.LOGIN);

// //       return Response(
// //         statusCode: 401,
// //         body: {'message': 'Session expired. Please login again.'},
// //       );
// //     }

// //     // ❌ Server error
// //     if (response.statusCode != null && response.statusCode! >= 500) {
// //       return Response(
// //         statusCode: response.statusCode,
// //         body: {'message': 'Server error. Please try again later.'},
// //       );
// //     }

// //     // ❌ Bad request / validation
// //     if (response.statusCode != null && response.statusCode! >= 400) {
// //       return Response(
// //         statusCode: response.statusCode,
// //         body: {'message': response.body?['message'] ?? 'Something went wrong'},
// //       );
// //     }

// //     // ✅ Success
// //     return response;
// //   }

// //   Response _handleException(dynamic e) {
// //     print('HTTP ERROR: $e');

// //     // 🌐 No internet / timeout
// //     if (e.toString().contains('SocketException')) {
// //       return Response(
// //         statusCode: 0,
// //         body: {'message': 'No internet connection'},
// //       );
// //     }

// //     // ⏱ Timeout
// //     if (e.toString().contains('TimeoutException')) {
// //       return Response(
// //         statusCode: 0,
// //         body: {'message': 'Request timeout'},
// //       );
// //     }

// //     // ❌ Unknown error
// //     return Response(
// //       statusCode: 500,
// //       body: {'message': e.toString()},
// //     );
// //   }

// //   Map<String, String> get _headers {
// //     final token = box.read('accessToken');

// //     return {
// //       // 'Content-Type': 'application/json',
// //       if (token != null) 'Authorization': token,
// //     };
// //   }

// //   Future<Response> getItems({required String endpointUrl}) async {
// //     try {
// //       final response = await GetConnect().get(
// //         '$baseUrl/$endpointUrl',
// //         headers: _headers,
// //       );

// //       return _handleResponse(response);
// //     } catch (e) {
// //       return _handleException(e);
// //     }
// //   }

// //   Future<Response> addItem(
// //       {required String endpointUrl, required dynamic itemData}) async {
// //     try {
// //       final response = await GetConnect().post(
// //         '$baseUrl/$endpointUrl',
// //         itemData,
// //         headers: _headers,
// //       );

// //       return _handleResponse(response);
// //     } catch (e) {
// //       return _handleException(e);
// //     }
// //   }

// //   Future<Response> updateItem(
// //       {required String endpointUrl,
// //       required String itemId,
// //       required dynamic itemData}) async {
// //     try {
// //       final response = await GetConnect().put(
// //         '$baseUrl/$endpointUrl/$itemId',
// //         itemData,
// //         headers: _headers,
// //       );
// //       return _handleResponse(response);
// //     } catch (e) {
// //       return _handleException(e);
// //     }
// //   }

// //   Future<Response> deleteItem(
// //       {required String endpointUrl, required String itemId}) async {
// //     try {
// //       final response = await GetConnect().delete(
// //         '$baseUrl/$endpointUrl/$itemId',
// //         headers: _headers,
// //       );

// //       return _handleResponse(response);
// //     } catch (e) {
// //       return _handleException(e);
// //     }
// //   }
// // }

// //   // contentType: 'multipart/form-data',

// import 'package:admin/core/routes/app_pages.dart';
// import 'package:get/get.dart';
// import '../utility/constants.dart';
// import 'package:get_storage/get_storage.dart';

// class HttpService {
//   final String baseUrl = MAIN_URL;
//   final box = GetStorage();

//   // 🔍 LOG HELPER
//   void _logResponse(String method, String url, Response response,
//       {dynamic body}) {
//     print('================ HTTP DEBUG ================');
//     print('REQUEST → [$method] $url');
//     if (body != null) print('REQUEST BODY → $body');

//     print('STATUS → ${response.statusCode}');
//     print('RESPONSE → ${response.body}');
//     print('HEADERS → ${response.headers}');
//     print('============================================');
//   }

//   void _logError(String method, String url, dynamic e) {
//     print('================ HTTP ERROR ================');
//     print('REQUEST → [$method] $url');
//     print('ERROR → $e');
//     print('===========================================');
//   }

//   Response _handleResponse(Response response) {
//     // 🔐 Unauthorized
//     if (response.statusCode == 401) {
//       box.remove('accessToken');
//       box.remove('refreshToken');
//       Get.offAllNamed(AppPages.LOGIN);

//       return Response(
//         statusCode: 401,
//         body: {
//           'message': response.body?['message'] ??
//               'Session expired. Please login again.'
//         },
//       );
//     }

//     // ❌ Server error (KEEP ORIGINAL BODY)
//     if (response.statusCode != null && response.statusCode! >= 500) {
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body, // 🔥 don't override
//       );
//     }

//     // ❌ Client error (KEEP ORIGINAL BODY)
//     if (response.statusCode != null && response.statusCode! >= 400) {
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body, // 🔥 don't override
//       );
//     }

//     return response;
//   }

//   Response _handleException(dynamic e) {
//     print('❌ EXCEPTION → $e');

//     if (e.toString().contains('SocketException')) {
//       return Response(
//         statusCode: 0,
//         body: {'message': 'No internet connection'},
//       );
//     }

//     if (e.toString().contains('TimeoutException')) {
//       return Response(
//         statusCode: 0,
//         body: {'message': 'Request timeout'},
//       );
//     }

//     return Response(
//       statusCode: 500,
//       body: {'message': e.toString()},
//     );
//   }

//   Map<String, String> get _headers {
//     final token = box.read('accessToken');

//     return {
//       // 'Content-Type': 'application/json',
//       if (token != null) 'Authorization': token,
//     };
//   }

//   Future<Response> getItems({required String endpointUrl}) async {
//     final url = '$baseUrl/$endpointUrl';

//     try {
//       final response = await GetConnect().get(
//         url,
//         headers: _headers,
//       );

//       _logResponse('GET', url, response);

//       return _handleResponse(response);
//     } catch (e) {
//       _logError('GET', url, e);
//       return _handleException(e);
//     }
//   }

//   Future<Response> addItem({
//     required String endpointUrl,
//     required dynamic itemData,
//   }) async {
//     final url = '$baseUrl/$endpointUrl';

//     try {
//       final response = await GetConnect().post(
//         url,
//         itemData,
//         headers: _headers,
//       );

//       _logResponse('POST', url, response, body: itemData);

//       return _handleResponse(response);
//     } catch (e) {
//       _logError('POST', url, e);
//       return _handleException(e);
//     }
//   }

//   Future<Response> updateItem({
//     required String endpointUrl,
//     required String itemId,
//     required dynamic itemData,
//   }) async {
//     final url = '$baseUrl/$endpointUrl/$itemId';

//     try {
//       final response = await GetConnect().put(
//         url,
//         itemData,
//         headers: _headers,
//       );

//       _logResponse('PUT', url, response, body: itemData);

//       return _handleResponse(response);
//     } catch (e) {
//       _logError('PUT', url, e);
//       return _handleException(e);
//     }
//   }

//   Future<Response> deleteItem({
//     required String endpointUrl,
//     required String itemId,
//   }) async {
//     final url = '$baseUrl/$endpointUrl/$itemId';

//     try {
//       final response = await GetConnect().delete(
//         url,
//         headers: _headers,
//       );

//       _logResponse('DELETE', url, response);

//       return _handleResponse(response);
//     } catch (e) {
//       _logError('DELETE', url, e);
//       return _handleException(e);
//     }
//   }
// }

import 'package:admin/core/routes/app_pages.dart';
import 'package:get/get.dart';
import '../utility/constants.dart';
import 'package:get_storage/get_storage.dart';

class HttpService {
  final String baseUrl = MAIN_URL;
  final box = GetStorage();
  bool _isRefreshing = false; // 🔒 prevent concurrent refresh calls

  // ─── Auth Header ──────────────────────────────────────────────────────────
  Map<String, String> get _headers {
    final token = box.read('accessToken');
    return {
      // ✅ FIX: was missing 'Bearer ' prefix — backend rejects without it
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ─── Force Logout ─────────────────────────────────────────────────────────
  void _forceLogout() {
    box.remove('accessToken');
    box.remove('refreshToken');
    box.remove('userInfo'); // adjust to your USER_INFO_BOX constant
    Get.offAllNamed(AppPages.LOGIN);
  }

  // ─── Refresh Access Token ─────────────────────────────────────────────────
  Future<bool> _refreshAccessToken() async {
    if (_isRefreshing) return false; // avoid parallel refresh calls
    _isRefreshing = true;

    try {
      final refreshToken = box.read('refreshToken');
      if (refreshToken == null) return false;

      final response = await GetConnect().post(
        '$baseUrl/users/refresh-token',
        {'refreshToken': refreshToken},
        // headers: {'Content-Type': 'application/json'},
      );

      _log('REFRESH TOKEN', response.statusCode, response.body);

      if (response.statusCode == 200) {
        final newAccessToken = response.body?['accessToken'];
        if (newAccessToken != null) {
          await box.write('accessToken', newAccessToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      print('❌ Refresh token error: $e');
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  // ─── Handle 401: Try Refresh → Retry → Logout ────────────────────────────
  Future<Response> _handle401AndRetry({
    required Future<Response> Function() retryRequest,
  }) async {
    final refreshed = await _refreshAccessToken();

    if (refreshed) {
      // ✅ Token refreshed — retry the original request with new token
      final retryResponse = await retryRequest();
      if (retryResponse.statusCode == 401) {
        // Refresh succeeded but still 401 — force logout
        _forceLogout();
        return Response(
          statusCode: 401,
          body: {'message': 'Session expired. Please login again.'},
        );
      }
      return _handleResponse(retryResponse);
    } else {
      // Refresh failed — force logout
      _forceLogout();
      return Response(
        statusCode: 401,
        body: {'message': 'Session expired. Please login again.'},
      );
    }
  }

  // ─── Response Handler (no longer handles 401 — that's done above) ─────────
  Response _handleResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 400) {
      return Response(
        statusCode: response.statusCode,
        body: response.body,
      );
    }
    return response;
  }

  // ─── Exception Handler ────────────────────────────────────────────────────
  Response _handleException(dynamic e) {
    print('❌ EXCEPTION → $e');
    final msg = e.toString();

    if (msg.contains('SocketException')) {
      return Response(
          statusCode: 0, body: {'message': 'No internet connection'});
    }
    if (msg.contains('TimeoutException')) {
      return Response(statusCode: 0, body: {'message': 'Request timeout'});
    }
    return Response(statusCode: 500, body: {'message': msg});
  }

  // ─── Logging ──────────────────────────────────────────────────────────────
  void _log(String label, int? status, dynamic body) {
    print('[$label] status=$status body=$body');
  }

  void _logResponse(String method, String url, Response r, {dynamic body}) {
    print('======= HTTP DEBUG =======');
    print('[$method] $url');

    if (body != null) {
      // 1. Create a printable version of the body
      var displayBody = body;

      // 2. If it's a Map, mask sensitive keys
      if (body is Map) {
        displayBody = Map.from(
            body); // Create a shallow copy to avoid modifying the actual request
        const sensitiveKeys = ['password', 'token', 'secret', 'credit_card'];

        for (var key in sensitiveKeys) {
          if (displayBody.containsKey(key)) {
            displayBody[key] = '********';
          }
        }
      }

      print('BODY → $displayBody');
    }

    print('STATUS → ${r.statusCode}');
    print('RESPONSE → ${r.body}');
    print('==========================');
  }

  void _logError(String method, String url, dynamic e) {
    print('======= HTTP ERROR =======');
    print('[$method] $url');
    print('ERROR → $e');
    print('==========================');
  }

  // ─── GET ──────────────────────────────────────────────────────────────────
  Future<Response> getItems({required String endpointUrl}) async {
    final url = '$baseUrl/$endpointUrl';
    try {
      var response = await GetConnect().get(url, headers: _headers);
      _logResponse('GET', url, response);

      if (response.statusCode == 401) {
        return _handle401AndRetry(
          retryRequest: () => GetConnect().get(url, headers: _headers),
        );
      }

      return _handleResponse(response);
    } catch (e) {
      _logError('GET', url, e);
      return _handleException(e);
    }
  }

  // ─── POST ─────────────────────────────────────────────────────────────────
  Future<Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl';
    try {
      var response = await GetConnect().post(url, itemData, headers: _headers);
      _logResponse('POST', url, response, body: itemData);

      if (response.statusCode == 401 &&
          !url.contains(AppPages.LOGIN) &&
          !url.contains("secure-login")) {
        return _handle401AndRetry(
          retryRequest: () =>
              GetConnect().post(url, itemData, headers: _headers),
        );
      }

      return _handleResponse(response);
    } catch (e) {
      _logError('POST', url, e);
      return _handleException(e);
    }
  }

  // ─── PUT ──────────────────────────────────────────────────────────────────
  Future<Response> updateItem({
    required String endpointUrl,
    required String itemId,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';
    try {
      var response = await GetConnect().put(url, itemData, headers: _headers);
      _logResponse('PUT', url, response, body: itemData);

      if (response.statusCode == 401) {
        return _handle401AndRetry(
          retryRequest: () =>
              GetConnect().put(url, itemData, headers: _headers),
        );
      }

      return _handleResponse(response);
    } catch (e) {
      _logError('PUT', url, e);
      return _handleException(e);
    }
  }

  // ─── DELETE ───────────────────────────────────────────────────────────────
  Future<Response> deleteItem({
    required String endpointUrl,
    required String itemId,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';
    try {
      var response = await GetConnect().delete(url, headers: _headers);
      _logResponse('DELETE', url, response);

      if (response.statusCode == 401) {
        return _handle401AndRetry(
          retryRequest: () => GetConnect().delete(url, headers: _headers),
        );
      }

      return _handleResponse(response);
    } catch (e) {
      _logError('DELETE', url, e);
      return _handleException(e);
    }
  }
}
