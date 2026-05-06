// // // // import 'package:admin/core/routes/app_pages.dart';
// // // // // import 'package:get/get_connect.dart';
// // // // import 'package:get/get.dart';
// // // // import '../utility/constants.dart';
// // // // import 'package:get_storage/get_storage.dart';

// // // // class HttpService {
// // // //   final String baseUrl = MAIN_URL;
// // // //   final box = GetStorage();

// // // //   Response _handleResponse(Response response) {
// // // //     // 🔐 Unauthorized
// // // //     if (response.statusCode == 401) {
// // // //       box.remove('accessToken');
// // // //       box.remove('refreshToken');
// // // //       Get.offAllNamed(AppPages.LOGIN);

// // // //       return Response(
// // // //         statusCode: 401,
// // // //         body: {'message': 'Session expired. Please login again.'},
// // // //       );
// // // //     }

// // // //     // ❌ Server error
// // // //     if (response.statusCode != null && response.statusCode! >= 500) {
// // // //       return Response(
// // // //         statusCode: response.statusCode,
// // // //         body: {'message': 'Server error. Please try again later.'},
// // // //       );
// // // //     }

// // // //     // ❌ Bad request / validation
// // // //     if (response.statusCode != null && response.statusCode! >= 400) {
// // // //       return Response(
// // // //         statusCode: response.statusCode,
// // // //         body: {'message': response.body?['message'] ?? 'Something went wrong'},
// // // //       );
// // // //     }

// // // //     // ✅ Success
// // // //     return response;
// // // //   }

// // // //   Response _handleException(dynamic e) {
// // // //     print('HTTP ERROR: $e');

// // // //     // 🌐 No internet / timeout
// // // //     if (e.toString().contains('SocketException')) {
// // // //       return Response(
// // // //         statusCode: 0,
// // // //         body: {'message': 'No internet connection'},
// // // //       );
// // // //     }

// // // //     // ⏱ Timeout
// // // //     if (e.toString().contains('TimeoutException')) {
// // // //       return Response(
// // // //         statusCode: 0,
// // // //         body: {'message': 'Request timeout'},
// // // //       );
// // // //     }

// // // //     // ❌ Unknown error
// // // //     return Response(
// // // //       statusCode: 500,
// // // //       body: {'message': e.toString()},
// // // //     );
// // // //   }

// // // //   Map<String, String> get _headers {
// // // //     final token = box.read('accessToken');

// // // //     return {
// // // //       // 'Content-Type': 'application/json',
// // // //       if (token != null) 'Authorization': token,
// // // //     };
// // // //   }

// // // //   Future<Response> getItems({required String endpointUrl}) async {
// // // //     try {
// // // //       final response = await GetConnect().get(
// // // //         '$baseUrl/$endpointUrl',
// // // //         headers: _headers,
// // // //       );

// // // //       return _handleResponse(response);
// // // //     } catch (e) {
// // // //       return _handleException(e);
// // // //     }
// // // //   }

// // // //   Future<Response> addItem(
// // // //       {required String endpointUrl, required dynamic itemData}) async {
// // // //     try {
// // // //       final response = await GetConnect().post(
// // // //         '$baseUrl/$endpointUrl',
// // // //         itemData,
// // // //         headers: _headers,
// // // //       );

// // // //       return _handleResponse(response);
// // // //     } catch (e) {
// // // //       return _handleException(e);
// // // //     }
// // // //   }

// // // //   Future<Response> updateItem(
// // // //       {required String endpointUrl,
// // // //       required String itemId,
// // // //       required dynamic itemData}) async {
// // // //     try {
// // // //       final response = await GetConnect().put(
// // // //         '$baseUrl/$endpointUrl/$itemId',
// // // //         itemData,
// // // //         headers: _headers,
// // // //       );
// // // //       return _handleResponse(response);
// // // //     } catch (e) {
// // // //       return _handleException(e);
// // // //     }
// // // //   }

// // // //   Future<Response> deleteItem(
// // // //       {required String endpointUrl, required String itemId}) async {
// // // //     try {
// // // //       final response = await GetConnect().delete(
// // // //         '$baseUrl/$endpointUrl/$itemId',
// // // //         headers: _headers,
// // // //       );

// // // //       return _handleResponse(response);
// // // //     } catch (e) {
// // // //       return _handleException(e);
// // // //     }
// // // //   }
// // // // }

// // // //   // contentType: 'multipart/form-data',

// // // import 'package:admin/core/routes/app_pages.dart';
// // // import 'package:get/get.dart';
// // // import '../utility/constants.dart';
// // // import 'package:get_storage/get_storage.dart';

// // // class HttpService {
// // //   final String baseUrl = MAIN_URL;
// // //   final box = GetStorage();

// // //   // 🔍 LOG HELPER
// // //   void _logResponse(String method, String url, Response response,
// // //       {dynamic body}) {
// // //     print('================ HTTP DEBUG ================');
// // //     print('REQUEST → [$method] $url');
// // //     if (body != null) print('REQUEST BODY → $body');

// // //     print('STATUS → ${response.statusCode}');
// // //     print('RESPONSE → ${response.body}');
// // //     print('HEADERS → ${response.headers}');
// // //     print('============================================');
// // //   }

// // //   void _logError(String method, String url, dynamic e) {
// // //     print('================ HTTP ERROR ================');
// // //     print('REQUEST → [$method] $url');
// // //     print('ERROR → $e');
// // //     print('===========================================');
// // //   }

// // //   Response _handleResponse(Response response) {
// // //     // 🔐 Unauthorized
// // //     if (response.statusCode == 401) {
// // //       box.remove('accessToken');
// // //       box.remove('refreshToken');
// // //       Get.offAllNamed(AppPages.LOGIN);

// // //       return Response(
// // //         statusCode: 401,
// // //         body: {
// // //           'message': response.body?['message'] ??
// // //               'Session expired. Please login again.'
// // //         },
// // //       );
// // //     }

// // //     // ❌ Server error (KEEP ORIGINAL BODY)
// // //     if (response.statusCode != null && response.statusCode! >= 500) {
// // //       return Response(
// // //         statusCode: response.statusCode,
// // //         body: response.body, // 🔥 don't override
// // //       );
// // //     }

// // //     // ❌ Client error (KEEP ORIGINAL BODY)
// // //     if (response.statusCode != null && response.statusCode! >= 400) {
// // //       return Response(
// // //         statusCode: response.statusCode,
// // //         body: response.body, // 🔥 don't override
// // //       );
// // //     }

// // //     return response;
// // //   }

// // //   Response _handleException(dynamic e) {
// // //     print('❌ EXCEPTION → $e');

// // //     if (e.toString().contains('SocketException')) {
// // //       return Response(
// // //         statusCode: 0,
// // //         body: {'message': 'No internet connection'},
// // //       );
// // //     }

// // //     if (e.toString().contains('TimeoutException')) {
// // //       return Response(
// // //         statusCode: 0,
// // //         body: {'message': 'Request timeout'},
// // //       );
// // //     }

// // //     return Response(
// // //       statusCode: 500,
// // //       body: {'message': e.toString()},
// // //     );
// // //   }

// // //   Map<String, String> get _headers {
// // //     final token = box.read('accessToken');

// // //     return {
// // //       // 'Content-Type': 'application/json',
// // //       if (token != null) 'Authorization': token,
// // //     };
// // //   }

// // //   Future<Response> getItems({required String endpointUrl}) async {
// // //     final url = '$baseUrl/$endpointUrl';

// // //     try {
// // //       final response = await GetConnect().get(
// // //         url,
// // //         headers: _headers,
// // //       );

// // //       _logResponse('GET', url, response);

// // //       return _handleResponse(response);
// // //     } catch (e) {
// // //       _logError('GET', url, e);
// // //       return _handleException(e);
// // //     }
// // //   }

// // //   Future<Response> addItem({
// // //     required String endpointUrl,
// // //     required dynamic itemData,
// // //   }) async {
// // //     final url = '$baseUrl/$endpointUrl';

// // //     try {
// // //       final response = await GetConnect().post(
// // //         url,
// // //         itemData,
// // //         headers: _headers,
// // //       );

// // //       _logResponse('POST', url, response, body: itemData);

// // //       return _handleResponse(response);
// // //     } catch (e) {
// // //       _logError('POST', url, e);
// // //       return _handleException(e);
// // //     }
// // //   }

// // //   Future<Response> updateItem({
// // //     required String endpointUrl,
// // //     required String itemId,
// // //     required dynamic itemData,
// // //   }) async {
// // //     final url = '$baseUrl/$endpointUrl/$itemId';

// // //     try {
// // //       final response = await GetConnect().put(
// // //         url,
// // //         itemData,
// // //         headers: _headers,
// // //       );

// // //       _logResponse('PUT', url, response, body: itemData);

// // //       return _handleResponse(response);
// // //     } catch (e) {
// // //       _logError('PUT', url, e);
// // //       return _handleException(e);
// // //     }
// // //   }

// // //   Future<Response> deleteItem({
// // //     required String endpointUrl,
// // //     required String itemId,
// // //   }) async {
// // //     final url = '$baseUrl/$endpointUrl/$itemId';

// // //     try {
// // //       final response = await GetConnect().delete(
// // //         url,
// // //         headers: _headers,
// // //       );

// // //       _logResponse('DELETE', url, response);

// // //       return _handleResponse(response);
// // //     } catch (e) {
// // //       _logError('DELETE', url, e);
// // //       return _handleException(e);
// // //     }
// // //   }
// // // }

// // import 'package:admin/core/routes/app_pages.dart';
// // import 'package:get/get.dart';
// // import '../utility/constants.dart';
// // import 'package:get_storage/get_storage.dart';

// // class HttpService {
// //   final String baseUrl = MAIN_URL;
// //   final box = GetStorage();
// //   bool _isRefreshing = false; // 🔒 prevent concurrent refresh calls
// //   // Inside HttpService class
// //   final _connect = GetConnect()..timeout = const Duration(seconds: 10);
// //   static const int maxRetries = 3;
// //   static const Duration retryDelay = Duration(seconds: 2);

// //   // ─── Auth Header ──────────────────────────────────────────────────────────
// //   Map<String, String> get _headers {
// //     final token = box.read('accessToken');
// //     return {
// //       // ✅ FIX: was missing 'Bearer ' prefix — backend rejects without it
// //       if (token != null) 'Authorization': 'Bearer $token',
// //     };
// //   }

// //   // ─── Retry Wrapper ────────────────────────────────────────────────────────
// //   // This wraps any request and retries it if it times out or has a connection error
// //   Future<Response> _requestWrapper(Future<Response> Function() request) async {
// //     int attempt = 0;
// //     while (true) {
// //       try {
// //         attempt++;
// //         final response = await request();

// //         // If it's a 401, handle the token refresh logic
// //         if (response.statusCode == 401) {
// //           return await _handle401AndRetry(retryRequest: request);
// //         }

// //         return _handleResponse(response);
// //       } catch (e) {
// //         // If we've hit max retries or it's not a timeout/network error, throw
// //         if (attempt >= maxRetries) {
// //           return _handleException(e);
// //         }
// //         // Wait before trying again
// //         await Future.delayed(retryDelay);
// //         print('🔄 Retrying request (Attempt $attempt)...');
// //       }
// //     }
// //   }

// //   // ─── Force Logout ─────────────────────────────────────────────────────────
// //   void _forceLogout() {
// //     box.remove('accessToken');
// //     box.remove('refreshToken');
// //     box.remove('userInfo'); // adjust to your USER_INFO_BOX constant
// //     Get.offAllNamed(AppPages.LOGIN);
// //   }

// //   // ─── Refresh Access Token ─────────────────────────────────────────────────
// //   Future<bool> _refreshAccessToken() async {
// //     if (_isRefreshing) return false; // avoid parallel refresh calls
// //     _isRefreshing = true;

// //     try {
// //       final refreshToken = box.read('refreshToken');
// //       if (refreshToken == null) return false;

// //       final response = await GetConnect().post(
// //         '$baseUrl/users/refresh-token',
// //         {'refreshToken': refreshToken},
// //         // headers: {'Content-Type': 'application/json'},
// //       );

// //       _log('REFRESH TOKEN', response.statusCode, response.body);

// //       if (response.statusCode == 200) {
// //         final newAccessToken = response.body?['accessToken'];
// //         if (newAccessToken != null) {
// //           await box.write('accessToken', newAccessToken);
// //           return true;
// //         }
// //       }
// //       return false;
// //     } catch (e) {
// //       print('❌ Refresh token error: $e');
// //       return false;
// //     } finally {
// //       _isRefreshing = false;
// //     }
// //   }

// //   // ─── Handle 401: Try Refresh → Retry → Logout ────────────────────────────
// //   Future<Response> _handle401AndRetry({
// //     required Future<Response> Function() retryRequest,
// //   }) async {
// //     final refreshed = await _refreshAccessToken();

// //     if (refreshed) {
// //       // ✅ Token refreshed — retry the original request with new token
// //       final retryResponse = await retryRequest();
// //       if (retryResponse.statusCode == 401) {
// //         // Refresh succeeded but still 401 — force logout
// //         _forceLogout();
// //         return Response(
// //           statusCode: 401,
// //           body: {'message': 'Session expired. Please login again.'},
// //         );
// //       }
// //       return _handleResponse(retryResponse);
// //     } else {
// //       // Refresh failed — force logout
// //       _forceLogout();
// //       return Response(
// //         statusCode: 401,
// //         body: {'message': 'Session expired. Please login again.'},
// //       );
// //     }
// //   }

// //   // ─── Response Handler (no longer handles 401 — that's done above) ─────────
// //   Response _handleResponse(Response response) {
// //     if (response.statusCode != null && response.statusCode! >= 400) {
// //       return Response(
// //         statusCode: response.statusCode,
// //         body: response.body,
// //       );
// //     }
// //     return response;
// //   }

// //   // ─── Exception Handler ────────────────────────────────────────────────────
// //   Response _handleException(dynamic e) {
// //     print('❌ EXCEPTION → $e');
// //     final msg = e.toString();

// //     if (msg.contains('SocketException')) {
// //       return Response(
// //           statusCode: 0, body: {'message': 'No internet connection'});
// //     }
// //     if (msg.contains('TimeoutException')) {
// //       return Response(statusCode: 0, body: {'message': 'Request timeout'});
// //     }
// //     return Response(statusCode: 500, body: {'message': msg});
// //   }

// //   // ─── Logging ──────────────────────────────────────────────────────────────
// //   void _log(String label, int? status, dynamic body) {
// //     print('[$label] status=$status body=$body');
// //   }

// //   void _logResponse(String method, String url, Response r, {dynamic body}) {
// //     print('======= HTTP DEBUG =======');
// //     print('[$method] $url');

// //     if (body != null) {
// //       // 1. Create a printable version of the body
// //       var displayBody = body;

// //       // 2. If it's a Map, mask sensitive keys
// //       if (body is Map) {
// //         displayBody = Map.from(
// //             body); // Create a shallow copy to avoid modifying the actual request
// //         const sensitiveKeys = ['password', 'token', 'secret', 'credit_card'];

// //         for (var key in sensitiveKeys) {
// //           if (displayBody.containsKey(key)) {
// //             displayBody[key] = '********';
// //           }
// //         }
// //       }

// //       print('BODY → $displayBody');
// //     }

// //     print('STATUS → ${r.statusCode}');
// //     print('RESPONSE → ${r.body}');
// //     print('==========================');
// //   }

// //   void _logError(String method, String url, dynamic e) {
// //     print('======= HTTP ERROR =======');
// //     print('[$method] $url');
// //     print('ERROR → $e');
// //     print('==========================');
// //   }

// //   // ─── GET ──────────────────────────────────────────────────────────────────
// //   Future<Response> getItems({required String endpointUrl}) async {
// //     final url = '$baseUrl/$endpointUrl';
// //     try {
// //       var response = await GetConnect().get(url, headers: _headers);
// //       _logResponse('GET', url, response);

// //       if (response.statusCode == 401) {
// //         return _handle401AndRetry(
// //           retryRequest: () => GetConnect().get(url, headers: _headers),
// //         );
// //       }

// //       return _handleResponse(response);
// //     } catch (e) {
// //       _logError('GET', url, e);
// //       return _handleException(e);
// //     }
// //   }

// //   // ─── POST ─────────────────────────────────────────────────────────────────
// //   Future<Response> addItem({
// //     required String endpointUrl,
// //     required dynamic itemData,
// //   }) async {
// //     final url = '$baseUrl/$endpointUrl';
// //     try {
// //       var response = await GetConnect().post(url, itemData, headers: _headers);
// //       _logResponse('POST', url, response, body: itemData);

// //       if (response.statusCode == 401 &&
// //           !url.contains(AppPages.LOGIN) &&
// //           !url.contains("secure-login")) {
// //         return _handle401AndRetry(
// //           retryRequest: () =>
// //               GetConnect().post(url, itemData, headers: _headers),
// //         );
// //       }

// //       return _handleResponse(response);
// //     } catch (e) {
// //       _logError('POST', url, e);
// //       return _handleException(e);
// //     }
// //   }

// //   // ─── PUT ──────────────────────────────────────────────────────────────────
// //   Future<Response> updateItem({
// //     required String endpointUrl,
// //     required String itemId,
// //     required dynamic itemData,
// //   }) async {
// //     final url = '$baseUrl/$endpointUrl/$itemId';
// //     try {
// //       var response = await GetConnect().put(url, itemData, headers: _headers);
// //       _logResponse('PUT', url, response, body: itemData);

// //       if (response.statusCode == 401) {
// //         return _handle401AndRetry(
// //           retryRequest: () =>
// //               GetConnect().put(url, itemData, headers: _headers),
// //         );
// //       }

// //       return _handleResponse(response);
// //     } catch (e) {
// //       _logError('PUT', url, e);
// //       return _handleException(e);
// //     }
// //   }

// //   // ─── DELETE ───────────────────────────────────────────────────────────────
// //   Future<Response> deleteItem({
// //     required String endpointUrl,
// //     required String itemId,
// //   }) async {
// //     final url = '$baseUrl/$endpointUrl/$itemId';
// //     try {
// //       var response = await GetConnect().delete(url, headers: _headers);
// //       _logResponse('DELETE', url, response);

// //       if (response.statusCode == 401) {
// //         return _handle401AndRetry(
// //           retryRequest: () => GetConnect().delete(url, headers: _headers),
// //         );
// //       }

// //       return _handleResponse(response);
// //     } catch (e) {
// //       _logError('DELETE', url, e);
// //       return _handleException(e);
// //     }
// //   }
// // }

// import 'dart:async';
// import 'package:admin/core/routes/app_pages.dart';
// import 'package:admin/utility/extensions.dart';
// import 'package:get/get.dart';
// import '../utility/constants.dart';
// import 'package:get_storage/get_storage.dart';

// class HttpService {
//   final String baseUrl = MAIN_URL;
//   final box = GetStorage();

//   // 🔒 Prevent concurrent refresh calls
//   bool _isRefreshing = false;

//   // 🛠️ Unified GetConnect instance with a 10-second Timeout
//   final _connect = GetConnect()..timeout = const Duration(seconds: 10);

//   static const int maxRetries = 3;
//   static const Duration retryDelay = Duration(seconds: 2);

//   // ─── Auth Header ──────────────────────────────────────────────────────────
//   Map<String, String> get _headers {
//     final token = box.read('accessToken');
//     return {
//       if (token != null) 'Authorization': 'Bearer $token',
//     };
//   }

//   // ─── Request Wrapper (The Core Logic) ─────────────────────────────────────
//   /// This centralized method handles:
//   /// 1. Timeouts/Connection retries via a loop
//   /// 2. Automatic 401 Token Refresh and request retry
//   /// 3. Unified Error and Exception handling
//   // Future<Response> _requestWrapper(
//   //   String method,
//   //   String url, {
//   //   dynamic body,
//   //   required Future<Response> Function() request,
//   // }) async {
//   //   int attempt = 0;

//   //   while (true) {
//   //     try {
//   //       attempt++;
//   //       final response = await request();
//   //       print(attempt);
//   //       _logResponse(method, url, response, body: body);

//   //       // 1. Handle Token Expiry (401)
//   //       // Skip refresh logic for login/refresh endpoints to avoid infinite loops
//   //       if (response.statusCode == 401 &&
//   //           !url.contains('login') &&
//   //           !url.contains('refresh-token') &&
//   //           !url.contains('secure-login')) {
//   //         return await _handle401AndRetry(retryRequest: request);
//   //       }

//   //       // 2. Process valid response (includes 4xx/5xx status codes)
//   //       return _handleResponse(response);
//   //     } catch (e) {
//   //       // 3. Retry Logic for Exceptions (Socket/Timeout/Handshake)
//   //       if (attempt < maxRetries) {
//   //         print('🔄 Retry Attempt $attempt for $url due to: $e');
//   //         await Future.delayed(retryDelay);
//   //         continue; // Loop back and try the request again
//   //       }

//   //       // Final failure after max retries
//   //       _logError(method, url, e);
//   //       return _handleException(e);
//   //     }
//   //   }
//   // }
//   Future<Response> _requestWrapper(
//     String method,
//     String url, {
//     dynamic body,
//     required Future<Response> Function() request,
//   }) async {
//     int attempt = 0;

//     while (true) {
//       try {
//         attempt++;
//         final response = await request();
//         _logResponse(method, url, response, body: body);

//         // ─── NEW: RETRY ON BACKEND FAILURE ───
//         // If statusCode is null (timeout) or 500-599 (server error)
//         if (response.statusCode == null ||
//             (response.statusCode! >= 500 && response.statusCode! <= 599)) {
//           if (attempt < maxRetries) {
//             print(
//                 '⚠️ Backend error (${response.statusCode}). Retrying $attempt/$maxRetries...');
//             await Future.delayed(retryDelay);
//             continue; // This jumps back to the start of the 'while' loop
//           }
//         }

//         // 1. Handle Token Expiry (401)
//         if (response.statusCode == 401 &&
//             !url.contains('login') &&
//             !url.contains('refresh-token') &&
//             !url.contains('secure-login')) {
//           return await _handle401AndRetry(retryRequest: request);
//         }

//         // 2. Process valid response
//         return _handleResponse(response);
//       } catch (e) {
//         // 3. Retry Logic for Exceptions (Socket/Timeout/Handshake)
//         if (attempt < maxRetries) {
//           print('🔄 Exception Retry $attempt for $url due to: $e');
//           await Future.delayed(retryDelay);
//           continue;
//         }

//         _logError(method, url, e);
//         return _handleException(e);
//       }
//     }
//   }
//   // ─── API Methods ──────────────────────────────────────────────────────────

//   Future<Response> getItems({required String endpointUrl}) async {
//     final url = '$baseUrl/$endpointUrl';
//     return _requestWrapper(
//       'GET',
//       url,
//       request: () => _connect.get(url, headers: _headers),
//     );
//   }

//   Future<Response> addItem({
//     required String endpointUrl,
//     required dynamic itemData,
//   }) async {
//     final url = '$baseUrl/$endpointUrl';
//     return _requestWrapper(
//       'POST',
//       url,
//       body: itemData,
//       request: () => _connect.post(url, itemData, headers: _headers),
//     );
//   }

//   Future<Response> updateItem({
//     required String endpointUrl,
//     required String itemId,
//     required dynamic itemData,
//   }) async {
//     final url = '$baseUrl/$endpointUrl/$itemId';
//     return _requestWrapper(
//       'PUT',
//       url,
//       body: itemData,
//       request: () => _connect.put(url, itemData, headers: _headers),
//     );
//   }

//   Future<Response> deleteItem({
//     required String endpointUrl,
//     required String itemId,
//   }) async {
//     final url = '$baseUrl/$endpointUrl/$itemId';
//     return _requestWrapper(
//       'DELETE',
//       url,
//       request: () => _connect.delete(url, headers: _headers),
//     );
//   }

//   // ─── 401 & Token Refresh Logic ────────────────────────────────────────────

//   Future<Response> _handle401AndRetry({
//     required Future<Response> Function() retryRequest,
//   }) async {
//     final refreshed = await _refreshAccessToken();

//     if (refreshed) {
//       // Retry the original request with the brand-new token
//       final retryResponse = await retryRequest();

//       if (retryResponse.statusCode == 401) {
//         // If it's still 401, the refresh token might be invalid/expired
//         _forceLogout();
//         return Response(
//           statusCode: 401,
//           body: {'message': 'Session expired. Please login again.'},
//         );
//       }
//       return _handleResponse(retryResponse);
//     } else {
//       // Refresh failed (e.g., refresh token expired)
//       _forceLogout();
//       return Response(
//         statusCode: 401,
//         body: {'message': 'Session expired. Please login again.'},
//       );
//     }
//   }

//   Future<bool> _refreshAccessToken() async {
//     if (_isRefreshing) return false;
//     _isRefreshing = true;

//     try {
//       final refreshToken = box.read('refreshToken');
//       if (refreshToken == null) return false;

//       final response = await _connect.post(
//         '$baseUrl/users/refresh-token',
//         {'refreshToken': refreshToken},
//       );

//       // 🔒 Safe logging (mask token)
//       final safeBody = Map<String, dynamic>.from(response.body ?? {});
//       if (safeBody.containsKey('accessToken')) {
//         final token = safeBody['accessToken'];
//         if (token is String && token.length > 10) {
//           safeBody['accessToken'] =
//               '${token.substring(0, 6)}...${token.substring(token.length - 4)}';
//         } else {
//           safeBody['accessToken'] = '***';
//         }
//       }

//       _log('REFRESH TOKEN', response.statusCode, safeBody);

//       if (response.statusCode == 200) {
//         final newAccessToken = response.body?['accessToken'];
//         if (newAccessToken != null) {
//           await box.write('accessToken', newAccessToken);
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       print('❌ Refresh token error: $e');
//       return false;
//     } finally {
//       _isRefreshing = false;
//     }
//   }
//   // ─── Utility & Error Handling ─────────────────────────────────────────────

//   void _forceLogout() {
//     box.remove('accessToken');
//     box.remove('refreshToken');
//     box.remove('userInfo');

//     Get.offAllNamed(AppPages.LOGIN);
//     // Reset DataProvider state
//     try {
//       final context = Get.context;
//       if (context != null) {
//         context.dataProvider.clearData();
//       }
//     } catch (e) {
//       print("Error clearing data: $e");
//     }
//   }

//   Response _handleResponse(Response response) {
//     // If the statusCode is null (timeout) or >= 400, return formatted error
//     if (response.statusCode == null || response.statusCode! >= 400) {
//       return Response(
//         statusCode: response.statusCode ?? 500,
//         body: response.body ?? {'message': 'An unexpected error occurred'},
//       );
//     }
//     return response;
//   }

//   Response _handleException(dynamic e) {
//     final msg = e.toString().toLowerCase();
//     if (msg.contains('socketexception')) {
//       return Response(
//           statusCode: 0, body: {'message': 'No internet connection'});
//     }
//     if (msg.contains('timeoutexception')) {
//       return Response(
//           statusCode: 0,
//           body: {'message': 'Request timed out after $maxRetries attempts'});
//     }
//     return Response(statusCode: 500, body: {'message': e.toString()});
//   }

//   // ─── Logging ──────────────────────────────────────────────────────────────

//   void _log(String label, int? status, dynamic body) {
//     print('[$label] status=$status body=$body');
//   }

//   void _logResponse(String method, String url, Response r, {dynamic body}) {
//     print('======= HTTP DEBUG =======');
//     print('[$method] $url');
//     if (body != null) {
//       var displayBody = body is Map ? Map.from(body) : body;
//       if (displayBody is Map) {
//         const sensitive = ['password', 'token', 'secret', 'credit_card'];
//         for (var key in sensitive) {
//           if (displayBody.containsKey(key)) displayBody[key] = '********';
//         }
//       }
//       print('BODY → $displayBody');
//     }
//     print('STATUS → ${r.statusCode}');
//     print('RESPONSE → ${r.body}');
//     print('==========================');
//   }

//   void _logError(String method, String url, dynamic e) {
//     print('======= HTTP ERROR =======');
//     print('[$method] $url | ERROR → $e');
//     print('==========================');
//   }
// }

import 'dart:async';
import 'package:admin/core/routes/app_pages.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utility/constants.dart';
import 'package:get_storage/get_storage.dart';

class HttpService {
  final String baseUrl = MAIN_URL;
  final box = GetStorage();

  // 🔒 Prevent concurrent refresh calls
  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  // 🚫 Prevent multiple force logout calls
  bool _isLoggingOut = false;

  // 🎯 Request queue for pausing/resuming requests during token refresh
  final List<Completer<Response>> _pendingRequests = [];

  // 🛠️ Unified GetConnect instance with a 10-second Timeout
  final _connect = GetConnect()..timeout = const Duration(seconds: 10);

  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // ─── Auth Header ──────────────────────────────────────────────────────────
  Map<String, String> get _headers {
    final token = box.read('accessToken');
    return {
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ─── Request Wrapper (The Core Logic) ─────────────────────────────────────
  /// This centralized method handles:
  /// 1. Timeouts/Connection retries via a loop
  /// 2. Automatic 401 Token Refresh with request queuing
  /// 3. Unified Error and Exception handling
  Future<Response> _requestWrapper(
    String method,
    String url, {
    dynamic body,
    required Future<Response> Function() request,
  }) async {
    int attempt = 0;

    while (true) {
      try {
        attempt++;

        // ⏸️ Check if we should wait for ongoing token refresh
        if (_isRefreshing &&
            !url.contains('login') &&
            !url.contains('refresh-token') &&
            !url.contains('secure-login')) {
          debugPrint('⏸️ Pausing request to $url - waiting for token refresh');
          final completer = Completer<Response>();
          _pendingRequests.add(completer);

          // Wait for refresh to complete
          final refreshed = await _refreshCompleter?.future;

          // Remove from queue if still there
          _pendingRequests.remove(completer);

          if (refreshed == true) {
            // Token refreshed successfully, retry the request
            debugPrint('▶️ Resuming request to $url with new token');
            try {
              final retryResponse = await request();
              _logResponse(method, url, retryResponse, body: body);

              if (retryResponse.statusCode == 401) {
                _forceLogout();
                return Response(
                  statusCode: 401,
                  body: {'message': 'Session expired. Please login again.'},
                );
              }
              return _handleResponse(retryResponse);
            } catch (e) {
              _logError(method, url, e);
              return _handleException(e);
            }
          } else {
            // Refresh failed, don't logout here - let the original refresh handler do it
            return Response(
              statusCode: 401,
              body: {'message': 'Session expired. Please login again.'},
            );
          }
        }

        final response = await request();
        _logResponse(method, url, response, body: body);

        // ─── RETRY ON BACKEND FAILURE ───
        // If statusCode is null (timeout) or 500-599 (server error)
        if (response.statusCode == null ||
            (response.statusCode! >= 500 && response.statusCode! <= 599)) {
          if (attempt < maxRetries) {
            debugPrint(
                '⚠️ Backend error (${response.statusCode}). Retrying $attempt/$maxRetries...');
            await Future.delayed(retryDelay);
            continue;
          }
        }

        // 1. Handle Token Expiry (401)
        if (response.statusCode == 401 &&
            !url.contains('login') &&
            !url.contains('refresh-token') &&
            !url.contains('secure-login')) {
          return await _handle401AndRetry(retryRequest: request);
        }

        // 2. Process valid response
        return _handleResponse(response);
      } catch (e) {
        // 3. Retry Logic for Exceptions (Socket/Timeout/Handshake)
        if (attempt < maxRetries) {
          debugPrint('🔄 Exception Retry $attempt for $url due to: $e');
          await Future.delayed(retryDelay);
          continue;
        }

        _logError(method, url, e);
        return _handleException(e);
      }
    }
  }

  // ─── API Methods ──────────────────────────────────────────────────────────

  Future<Response> getItems({required String endpointUrl}) async {
    final url = '$baseUrl/$endpointUrl';
    return _requestWrapper(
      'GET',
      url,
      request: () => _connect.get(url, headers: _headers),
    );
  }

  Future<Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl';
    return _requestWrapper(
      'POST',
      url,
      body: itemData,
      request: () => _connect.post(url, itemData, headers: _headers),
    );
  }

  Future<Response> updateItem({
    required String endpointUrl,
    required String itemId,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';
    return _requestWrapper(
      'PUT',
      url,
      body: itemData,
      request: () => _connect.put(url, itemData, headers: _headers),
    );
  }

  Future<Response> deleteItem({
    required String endpointUrl,
    required String itemId,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';
    return _requestWrapper(
      'DELETE',
      url,
      request: () => _connect.delete(url, headers: _headers),
    );
  }

  // ─── 401 & Token Refresh Logic ────────────────────────────────────────────

  Future<Response> _handle401AndRetry({
    required Future<Response> Function() retryRequest,
  }) async {
    // If a refresh is already in progress, wait for it
    if (_isRefreshing) {
      debugPrint('⏳ Request already waiting for in-progress token refresh');
      final completer = Completer<Response>();
      _pendingRequests.add(completer);

      final refreshed = await _refreshCompleter?.future;
      _pendingRequests.remove(completer);

      if (refreshed == true) {
        // Token was refreshed, retry the original request
        final retryResponse = await retryRequest();

        if (retryResponse.statusCode == 401) {
          // Still 401 after refresh - token might be invalid
          _forceLogout();
          return Response(
            statusCode: 401,
            body: {'message': 'Session expired. Please login again.'},
          );
        }
        return _handleResponse(retryResponse);
      } else {
        // Refresh failed - let the original refresh handler trigger logout
        return Response(
          statusCode: 401,
          body: {'message': 'Session expired. Please login again.'},
        );
      }
    }

    // No refresh in progress, start a new one
    debugPrint('🔄 Starting new token refresh...');
    final refreshed = await _refreshAccessToken();

    if (refreshed) {
      debugPrint('✅ Token refreshed successfully, retrying request');
      // Retry the original request with the new token
      final retryResponse = await retryRequest();

      if (retryResponse.statusCode == 401) {
        // If still 401, the refresh token might be invalid/expired
        _forceLogout();
        return Response(
          statusCode: 401,
          body: {'message': 'Session expired. Please login again.'},
        );
      }
      return _handleResponse(retryResponse);
    } else {
      // Refresh failed (e.g., refresh token expired)
      debugPrint('❌ Token refresh failed, logging out');
      _forceLogout();
      return Response(
        statusCode: 401,
        body: {'message': 'Session expired. Please login again.'},
      );
    }
  }

  Future<bool> _refreshAccessToken() async {
    // If a refresh is already in progress, return the existing future
    if (_isRefreshing) {
      debugPrint('⏳ Refresh already in progress, returning existing future');
      return _refreshCompleter?.future ?? Future.value(false);
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final refreshToken = box.read('refreshToken');
      if (refreshToken == null) {
        debugPrint('❌ No refresh token found');
        _refreshCompleter?.complete(false);
        return false;
      }

      debugPrint('🔄 Making refresh token API call...');
      final response = await _connect.post(
        '$baseUrl/users/refresh-token',
        {'refreshToken': refreshToken},
      );

      // 🔒 Safe logging (mask token)
      final safeBody = Map<String, dynamic>.from(response.body ?? {});
      if (safeBody.containsKey('accessToken')) {
        final token = safeBody['accessToken'];
        if (token is String && token.length > 10) {
          safeBody['accessToken'] =
              '${token.substring(0, 6)}...${token.substring(token.length - 4)}';
        } else {
          safeBody['accessToken'] = '***';
        }
      }

      _log('REFRESH TOKEN', response.statusCode, safeBody);

      if (response.statusCode == 200) {
        final newAccessToken = response.body?['accessToken'];
        if (newAccessToken != null) {
          await box.write('accessToken', newAccessToken);
          debugPrint('✅ Token refresh successful');
          _refreshCompleter?.complete(true);
          return true;
        }
      }

      debugPrint('❌ Token refresh failed with status: ${response.statusCode}');
      _refreshCompleter?.complete(false);
      return false;
    } catch (e) {
      debugPrint('❌ Refresh token error: $e');
      _refreshCompleter?.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  // ─── Utility & Error Handling ─────────────────────────────────────────────

  void _forceLogout() {
    // Prevent multiple logout calls
    if (_isLoggingOut) {
      debugPrint('🛑 Logout already in progress, skipping duplicate call');
      return;
    }

    _isLoggingOut = true;
    debugPrint('🚪 Force logout - clearing session and navigating to login');

    // Complete all pending requests with 401 to stop waiting
    for (var completer in _pendingRequests) {
      if (!completer.isCompleted) {
        completer.complete(Response(
          statusCode: 401,
          body: {'message': 'Session expired. Please login again.'},
        ));
      }
    }
    _pendingRequests.clear();

    // Clear stored credentials
    box.remove('accessToken');
    box.remove('refreshToken');
    box.remove('userInfo');

    // Reset refresh state
    _isRefreshing = false;
    _refreshCompleter = null;

    // Navigate to login and clear data
    Get.offAllNamed(AppPages.LOGIN);

    // Reset DataProvider state
    try {
      final context = Get.context;
      if (context != null) {
        context.dataProvider.clearData();
      }
    } catch (e) {
      debugPrint("Error clearing data: $e");
    }

    // Reset logout flag after a short delay to prevent re-triggering
    Future.delayed(const Duration(milliseconds: 500), () {
      _isLoggingOut = false;
    });
  }

  Response _handleResponse(Response response) {
    // If the statusCode is null (timeout) or >= 400, return formatted error
    if (response.statusCode == null || response.statusCode! >= 400) {
      return Response(
        statusCode: response.statusCode ?? 500,
        body: response.body ?? {'message': 'An unexpected error occurred'},
      );
    }
    return response;
  }

  Response _handleException(dynamic e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('socketexception')) {
      return Response(
          statusCode: 0, body: {'message': 'No internet connection'});
    }
    if (msg.contains('timeoutexception')) {
      return Response(
          statusCode: 0,
          body: {'message': 'Request timed out after $maxRetries attempts'});
    }
    return Response(statusCode: 500, body: {'message': e.toString()});
  }

  // ─── Logging ──────────────────────────────────────────────────────────────

  void _log(String label, int? status, dynamic body) {
    debugPrint('[$label] status=$status body=$body');
  }

  void _logResponse(String method, String url, Response r, {dynamic body}) {
    debugPrint('======= HTTP DEBUG =======');
    debugPrint('[$method] $url');
    if (body != null) {
      var displayBody = body is Map ? Map.from(body) : body;
      if (displayBody is Map) {
        const sensitive = ['password', 'token', 'secret', 'credit_card'];
        for (var key in sensitive) {
          if (displayBody.containsKey(key)) displayBody[key] = '********';
        }
      }
      debugPrint('BODY → $displayBody');
    }
    debugPrint('STATUS → ${r.statusCode}');
    debugPrint('RESPONSE → ${r.body}');
    debugPrint('==========================');
  }

  void _logError(String method, String url, dynamic e) {
    debugPrint('======= HTTP ERROR =======');
    debugPrint('[$method] $url | ERROR → $e');
    debugPrint('==========================');
  }
}
