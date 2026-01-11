// ignore_for_file: avoid_print, depend_on_referenced_packages, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'statusrequest.dart';

import 'package:path/path.dart';

class Crud {
  final Map<String, String> _myheaders = {'Accept': 'application/json'};

  Future<Either<StatusRequest, Map>> callApi({
    required String url,
    String method = 'POST',
    Map<String, dynamic>? data,
    File? singleFile,
    String? singleFileField,
    File? secondFile, // ✅ إضافة ملف ثاني
    String? secondFileField, // ✅ إضافة حقل الملف الثاني
    List<File>? multipleFiles,
    String? multipleFilesField,
  }) async {
    try {
      if (method == 'GET') {
        var response = await http.get(Uri.parse(url), headers: _myheaders);
        debugPrint("API Response Status: ${response.statusCode}");
        debugPrint("API Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseMap = jsonDecode(response.body);
          return Right(responseMap);
        } else if (response.statusCode >= 500) {
          debugPrint("Server Error ${response.statusCode}");
          return const Left(StatusRequest.serverfailure);
        } else if (response.statusCode == 404) {
          Map responseMap = jsonDecode(response.body);
          return Right(responseMap);
        } else {
          debugPrint("General Error ${response.statusCode}");
          return const Left(StatusRequest.failure);
        }
      } else {
        var uri = Uri.parse(url);
        var request = http.MultipartRequest(method, uri);
        request.headers.addAll(_myheaders);

        if (data != null) {
          data.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        // ✅ الملف الأول
        if (singleFile != null && singleFileField != null) {
          var length = await singleFile.length();
          var stream = http.ByteStream(singleFile.openRead());
          var multipartFile = http.MultipartFile(
            singleFileField,
            stream,
            length,
            filename: basename(singleFile.path),
          );
          request.files.add(multipartFile);
        }

        // ✅ الملف الثاني (صورة الملكية)
        if (secondFile != null && secondFileField != null) {
          var length = await secondFile.length();
          var stream = http.ByteStream(secondFile.openRead());
          var multipartFile = http.MultipartFile(
            secondFileField,
            stream,
            length,
            filename: basename(secondFile.path),
          );
          request.files.add(multipartFile);
        }

        // ✅ الملفات المتعددة
        if (multipleFiles != null &&
            multipleFiles.isNotEmpty &&
            multipleFilesField != null) {
          for (var file in multipleFiles) {
            var length = await file.length();
            var stream = http.ByteStream(file.openRead());
            var multipartFile = http.MultipartFile(
              '${multipleFilesField}[]',
              stream,
              length,
              filename: basename(file.path),
            );
            request.files.add(multipartFile);
          }
        }

        var response = await request.send().timeout(
          const Duration(seconds: 30),
        );
        var responseBody = await http.Response.fromStream(response);

        debugPrint("Multipart Response Status: ${responseBody.statusCode}");
        debugPrint("Multipart Response Body: ${responseBody.body}");

        Map responseMap = jsonDecode(responseBody.body);

        if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
          return Right(responseMap);
        } else if (responseBody.statusCode >= 500) {
          return const Left(StatusRequest.serverfailure);
        } else {
          return Right(responseMap);
        }
      }
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      return const Left(StatusRequest.offlinefailure);
    } on TimeoutException catch (e) {
      debugPrint("TimeoutException: $e");
      return const Left(StatusRequest.serverfailure);
    } on http.ClientException catch (e) {
      debugPrint("ClientException: $e");
      return const Left(StatusRequest.offlinefailure);
    } on FormatException catch (e) {
      debugPrint("FormatException: $e");
      return const Left(StatusRequest.serverfailure);
    } catch (e) {
      debugPrint("Crud General Error: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }
  // Future<Either<StatusRequest, Map>> callApi({
  //   required String url,
  //   String method = 'POST',
  //   Map<String, dynamic>? data,
  //   File? singleFile,
  //   String? singleFileField,
  //   List<File>? multipleFiles,
  //   String? multipleFilesField,
  // }) async {
  //   try {
  //     if (method == 'GET') {
  //       var response = await http.get(Uri.parse(url), headers: _myheaders);
  //       // .timeout(const Duration(seconds: 30));

  //       debugPrint("API Response Status: ${response.statusCode}");
  //       debugPrint("API Response Body: ${response.body}");

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responseMap = jsonDecode(response.body);
  //         return Right(responseMap);
  //       } else if (response.statusCode >= 500) {
  //         debugPrint("Server Error ${response.statusCode}");
  //         return const Left(StatusRequest.serverfailure);
  //       } else if (response.statusCode == 404) {
  //         Map responseMap = jsonDecode(response.body);
  //         return Right(responseMap);
  //       } else {
  //         debugPrint("General Error ${response.statusCode}");
  //         return const Left(StatusRequest.failure);
  //       }
  //     } else {
  //       var uri = Uri.parse(url);
  //       var request = http.MultipartRequest(method, uri);
  //       request.headers.addAll(_myheaders);

  //       if (data != null) {
  //         data.forEach((key, value) {
  //           request.fields[key] = value.toString();
  //         });
  //       }

  //       if (singleFile != null && singleFileField != null) {
  //         var length = await singleFile.length();
  //         var stream = http.ByteStream(singleFile.openRead());
  //         var multipartFile = http.MultipartFile(
  //           singleFileField,
  //           stream,
  //           length,
  //           filename: basename(singleFile.path),
  //         );
  //         request.files.add(multipartFile);
  //       }

  //       if (multipleFiles != null &&
  //           multipleFiles.isNotEmpty &&
  //           multipleFilesField != null) {
  //         for (var file in multipleFiles) {
  //           var length = await file.length();
  //           var stream = http.ByteStream(file.openRead());
  //           var multipartFile = http.MultipartFile(
  //             '${multipleFilesField}[]',
  //             stream,
  //             length,
  //             filename: basename(file.path),
  //           );
  //           request.files.add(multipartFile);
  //         }
  //       }

  //       var response = await request.send().timeout(
  //         const Duration(seconds: 30),
  //       );
  //       var responseBody = await http.Response.fromStream(response);

  //       debugPrint("Multipart Response Status: ${responseBody.statusCode}");
  //       debugPrint("Multipart Response Body: ${responseBody.body}");

  //       Map responseMap = jsonDecode(responseBody.body);

  //       if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
  //         return Right(responseMap);
  //       } else if (responseBody.statusCode >= 500) {
  //         return const Left(StatusRequest.serverfailure);
  //       } else {
  //         return Right(responseMap);
  //       }
  //     }
  //   } on SocketException catch (e) {
  //     debugPrint("SocketException: $e");
  //     return const Left(StatusRequest.offlinefailure);
  //   } on TimeoutException catch (e) {
  //     debugPrint("TimeoutException: $e");
  //     return const Left(StatusRequest.serverfailure);
  //   } on http.ClientException catch (e) {
  //     debugPrint("ClientException: $e");
  //     return const Left(StatusRequest.offlinefailure);
  //   } on FormatException catch (e) {
  //     debugPrint("FormatException: $e");
  //     return const Left(StatusRequest.serverfailure);
  //   } catch (e) {
  //     debugPrint("Crud General Error: $e");
  //     return const Left(StatusRequest.serverfailure);
  //   }
  // }

  // ==================================================================
  // Future<Either<StatusRequest, Map>> callApi({
  //   required String url,
  //   String method = 'POST',
  //   Map<String, dynamic>? data,
  //   File? singleFile,
  //   String? singleFileField,
  //   List<File>? multipleFiles,
  //   String? multipleFilesField,
  // }) async {
  //   try {
  //     if (method == 'GET') {
  //       var response = await http.get(Uri.parse(url), headers: _myheaders);

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responseMap = jsonDecode(response.body);
  //         return Right(responseMap);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       var uri = Uri.parse(url);
  //       var request = http.MultipartRequest(method, uri);
  //       request.headers.addAll(_myheaders);

  //       if (data != null) {
  //         data.forEach((key, value) {
  //           request.fields[key] = value.toString();
  //         });
  //       }

  //       if (singleFile != null && singleFileField != null) {
  //         var length = await singleFile.length();
  //         var stream = http.ByteStream(singleFile.openRead());
  //         var multipartFile = http.MultipartFile(
  //           singleFileField,
  //           stream,
  //           length,
  //           filename: basename(singleFile.path),
  //         );
  //         request.files.add(multipartFile);
  //       }

  //       if (multipleFiles != null &&
  //           multipleFiles.isNotEmpty &&
  //           multipleFilesField != null) {
  //         for (var file in multipleFiles) {
  //           var length = await file.length();
  //           var stream = http.ByteStream(file.openRead());
  //           var multipartFile = http.MultipartFile(
  //             '${multipleFilesField}[]',
  //             stream,
  //             length,
  //             filename: basename(file.path),
  //           );
  //           request.files.add(multipartFile);
  //         }
  //       }

  //       var response = await request.send();
  //       var responseBody = await http.Response.fromStream(response);
  //       Map responseMap = jsonDecode(responseBody.body);

  //       if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
  //         return Right(responseMap);
  //       } else {
  //         return Right(responseMap);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("Crud Error: $e");
  //     return const Left(StatusRequest.serverfailure);
  //   }
  // }

  Future<Map<String, dynamic>> callApiTest({
    required String url,
    String method = 'POST',
    Map<String, dynamic>? data,
    File? singleFile,
    String? singleFileField,
    List<File>? multipleFiles,
    String? multipleFilesField,
  }) async {
    try {
      if (method == 'GET') {
        var response = await http.get(Uri.parse(url), headers: _myheaders);

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          print('Decoded Response Data: $responseMap');
          return responseMap;
        } else {
          // إرجاع رسالة خطأ بدلاً من رمي استثناء
          return {
            'error': true,
            'message': 'Server returned an error: ${response.statusCode}',
          };
        }
      } else {
        var uri = Uri.parse(url);
        var request = http.MultipartRequest(method, uri);
        request.headers.addAll(_myheaders);

        if (data != null) {
          data.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        if (singleFile != null && singleFileField != null) {
          var length = await singleFile.length();
          var stream = http.ByteStream(singleFile.openRead());
          var multipartFile = http.MultipartFile(
            singleFileField,
            stream,
            length,
            filename: basename(singleFile.path),
          );
          request.files.add(multipartFile);
        }

        if (multipleFiles != null &&
            multipleFiles.isNotEmpty &&
            multipleFilesField != null) {
          for (var file in multipleFiles) {
            var length = await file.length();
            var stream = http.ByteStream(file.openRead());
            var multipartFile = http.MultipartFile(
              '${multipleFilesField}[]',
              stream,
              length,
              filename: basename(file.path),
            );
            request.files.add(multipartFile);
          }
        }

        var response = await request.send();
        var responseBody = await http.Response.fromStream(response);
        print('Response Body: ${responseBody.body}');
        Map<String, dynamic> responseMap = jsonDecode(responseBody.body);

        if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
          print('Decoded Response Data: $responseMap');
          return responseMap;
        } else {
          // إرجاع رسالة خطأ بدلاً من رمي استثناء
          return {
            'error': true,
            'message': 'Server returned an error: ${responseBody.statusCode}',
          };
        }
      }
    } catch (e) {
      // إرجاع رسالة خطأ بدلاً من رمي استثناء
      return {'error': true, 'message': 'An error occurred: $e'};
    }
  }
  // Future<Either<StatusRequest, Map>> callApiTest(
  //   String linkurl, {
  //   String method = 'GET',
  //   Map<String, dynamic>? data,
  // }) async {
  //   try {
  //     http.Response response;

  //     // إرسال الطلب بناءً على الأسلوب (GET أو POST)
  //     if (method == 'POST') {
  //       response = await http.post(
  //         Uri.parse(linkurl),
  //         body: data,
  //       );
  //     } else {
  //       response = await http.get(Uri.parse(linkurl));
  //     }
  //     ;

  //     // ✅ محاولة تحويل الاستجابة إلى JSON
  //     Map responseBody = jsonDecode(response.body);

  //     // ✅ التعامل مع الاستجابات المختلفة بناءً على كود الحالة
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return Right(responseBody);
  //     } else {
  //       return Right(responseBody); // ✅ إرجاع الخطأ بدلاً من `serverfailure`
  //     }
  //   } catch (e) {
  //     print("An error occurred: $e");
  //     return const Left(StatusRequest.serverfailure);
  //   }
  // }
}
