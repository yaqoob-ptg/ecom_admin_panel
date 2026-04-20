// import 'package:admin/core/routes/app_pages.dart';
// // import 'package:get/get_connect.dart';
// import 'package:get/get.dart';
// import '../utility/constants.dart';
// import 'package:get_storage/get_storage.dart';

// class HttpService {
//   final String baseUrl = MAIN_URL;
//   final box = GetStorage();

//   Response _handleResponse(Response response) {
//     // 🔐 Unauthorized
//     if (response.statusCode == 401) {
//       box.remove('accessToken');
//       box.remove('refreshToken');
//       Get.offAllNamed(AppPages.LOGIN);

//       return Response(
//         statusCode: 401,
//         body: {'message': 'Session expired. Please login again.'},
//       );
//     }

//     // ❌ Server error
//     if (response.statusCode != null && response.statusCode! >= 500) {
//       return Response(
//         statusCode: response.statusCode,
//         body: {'message': 'Server error. Please try again later.'},
//       );
//     }

//     // ❌ Bad request / validation
//     if (response.statusCode != null && response.statusCode! >= 400) {
//       return Response(
//         statusCode: response.statusCode,
//         body: {'message': response.body?['message'] ?? 'Something went wrong'},
//       );
//     }

//     // ✅ Success
//     return response;
//   }

//   Response _handleException(dynamic e) {
//     print('HTTP ERROR: $e');

//     // 🌐 No internet / timeout
//     if (e.toString().contains('SocketException')) {
//       return Response(
//         statusCode: 0,
//         body: {'message': 'No internet connection'},
//       );
//     }

//     // ⏱ Timeout
//     if (e.toString().contains('TimeoutException')) {
//       return Response(
//         statusCode: 0,
//         body: {'message': 'Request timeout'},
//       );
//     }

//     // ❌ Unknown error
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
//     try {
//       final response = await GetConnect().get(
//         '$baseUrl/$endpointUrl',
//         headers: _headers,
//       );

//       return _handleResponse(response);
//     } catch (e) {
//       return _handleException(e);
//     }
//   }

//   Future<Response> addItem(
//       {required String endpointUrl, required dynamic itemData}) async {
//     try {
//       final response = await GetConnect().post(
//         '$baseUrl/$endpointUrl',
//         itemData,
//         headers: _headers,
//       );

//       return _handleResponse(response);
//     } catch (e) {
//       return _handleException(e);
//     }
//   }

//   Future<Response> updateItem(
//       {required String endpointUrl,
//       required String itemId,
//       required dynamic itemData}) async {
//     try {
//       final response = await GetConnect().put(
//         '$baseUrl/$endpointUrl/$itemId',
//         itemData,
//         headers: _headers,
//       );
//       return _handleResponse(response);
//     } catch (e) {
//       return _handleException(e);
//     }
//   }

//   Future<Response> deleteItem(
//       {required String endpointUrl, required String itemId}) async {
//     try {
//       final response = await GetConnect().delete(
//         '$baseUrl/$endpointUrl/$itemId',
//         headers: _headers,
//       );

//       return _handleResponse(response);
//     } catch (e) {
//       return _handleException(e);
//     }
//   }
// }

//   // contentType: 'multipart/form-data',

import 'package:admin/core/routes/app_pages.dart';
import 'package:get/get.dart';
import '../utility/constants.dart';
import 'package:get_storage/get_storage.dart';

class HttpService {
  final String baseUrl = MAIN_URL;
  final box = GetStorage();

  // 🔍 LOG HELPER
  void _logResponse(String method, String url, Response response,
      {dynamic body}) {
    print('================ HTTP DEBUG ================');
    print('REQUEST → [$method] $url');
    if (body != null) print('REQUEST BODY → $body');

    print('STATUS → ${response.statusCode}');
    print('RESPONSE → ${response.body}');
    print('HEADERS → ${response.headers}');
    print('============================================');
  }

  void _logError(String method, String url, dynamic e) {
    print('================ HTTP ERROR ================');
    print('REQUEST → [$method] $url');
    print('ERROR → $e');
    print('===========================================');
  }

  Response _handleResponse(Response response) {
    // 🔐 Unauthorized
    if (response.statusCode == 401) {
      box.remove('accessToken');
      box.remove('refreshToken');
      Get.offAllNamed(AppPages.LOGIN);

      return Response(
        statusCode: 401,
        body: {
          'message': response.body?['message'] ??
              'Session expired. Please login again.'
        },
      );
    }

    // ❌ Server error (KEEP ORIGINAL BODY)
    if (response.statusCode != null && response.statusCode! >= 500) {
      return Response(
        statusCode: response.statusCode,
        body: response.body, // 🔥 don't override
      );
    }

    // ❌ Client error (KEEP ORIGINAL BODY)
    if (response.statusCode != null && response.statusCode! >= 400) {
      return Response(
        statusCode: response.statusCode,
        body: response.body, // 🔥 don't override
      );
    }

    return response;
  }

  Response _handleException(dynamic e) {
    print('❌ EXCEPTION → $e');

    if (e.toString().contains('SocketException')) {
      return Response(
        statusCode: 0,
        body: {'message': 'No internet connection'},
      );
    }

    if (e.toString().contains('TimeoutException')) {
      return Response(
        statusCode: 0,
        body: {'message': 'Request timeout'},
      );
    }

    return Response(
      statusCode: 500,
      body: {'message': e.toString()},
    );
  }

  Map<String, String> get _headers {
    final token = box.read('accessToken');

    return {
      // 'Content-Type': 'application/json',
      if (token != null) 'Authorization': token,
    };
  }

  Future<Response> getItems({required String endpointUrl}) async {
    final url = '$baseUrl/$endpointUrl';

    try {
      final response = await GetConnect().get(
        url,
        headers: _headers,
      );

      _logResponse('GET', url, response);

      return _handleResponse(response);
    } catch (e) {
      _logError('GET', url, e);
      return _handleException(e);
    }
  }

  Future<Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl';

    try {
      final response = await GetConnect().post(
        url,
        itemData,
        headers: _headers,
      );

      _logResponse('POST', url, response, body: itemData);

      return _handleResponse(response);
    } catch (e) {
      _logError('POST', url, e);
      return _handleException(e);
    }
  }

  Future<Response> updateItem({
    required String endpointUrl,
    required String itemId,
    required dynamic itemData,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';

    try {
      final response = await GetConnect().put(
        url,
        itemData,
        headers: _headers,
      );

      _logResponse('PUT', url, response, body: itemData);

      return _handleResponse(response);
    } catch (e) {
      _logError('PUT', url, e);
      return _handleException(e);
    }
  }

  Future<Response> deleteItem({
    required String endpointUrl,
    required String itemId,
  }) async {
    final url = '$baseUrl/$endpointUrl/$itemId';

    try {
      final response = await GetConnect().delete(
        url,
        headers: _headers,
      );

      _logResponse('DELETE', url, response);

      return _handleResponse(response);
    } catch (e) {
      _logError('DELETE', url, e);
      return _handleException(e);
    }
  }
}
