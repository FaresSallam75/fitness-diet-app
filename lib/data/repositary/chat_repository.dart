import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/src/response.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/dio_services/dio.dart';
import 'package:ordering_app/core/error/failure.dart';

class ChatRepository {
  // Future<Either<Failure, List<Map<String, dynamic>>>> getAllChats() async {
  //   final response = await DioService.postData(
  //     url: ApiEndPoints.viewMessages,
  //     body: {},
  //   );
  //   late Map<String, dynamic> data;
  //   if (response.data is String) {
  //     data = jsonDecode(response.data);
  //   } else {
  //     data = Map<String, dynamic>.from(response.data);
  //   }
  //   if (data['status'] == 'success') {
  //     final convertedData = List<Map<String, dynamic>>.from(data['data']);
  //     log("coached Data ============= $convertedData");
  //     return Right(convertedData);
  //   } else {
  //     return Left(ServerFailure("Error Of Getting Data."));
  //   }
  // }

  Stream<Either<Failure, List<Map<String, dynamic>>>> getAllChats(
    String sender,
    String reciever,
  ) async* {
    try {
      final response = await DioService.postData(
        url: ApiEndPoints.viewMessages,
        body: {"sender": sender, "reciever": reciever},
      );
      late Map<String, dynamic> data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else {
        data = Map<String, dynamic>.from(response.data);
      }
      if (data['status'] == 'success') {
        final convertedData = List<Map<String, dynamic>>.from(data['data']);
        log("chats Data ============= $convertedData");
        yield Right(convertedData);
      } else {
        yield Left(ServerFailure("No Messsage Data."));
      }
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  Stream<Either<Failure, List<Map<String, dynamic>>>> sendMessageData(
    String sender,
    String reciever,
    String message, [
    File? file,
  ]) async* {
    try {
      final Response response;
      if (file == null) {
        response = await DioService.postData(
          url: ApiEndPoints.sendMessage,
          body: {"sender": sender, "reciever": reciever, "message": message},
        );
      } else {
        response = await DioService.uploadImage(
          url: ApiEndPoints.sendMessage,
          data: {"sender": sender, "reciever": reciever, "message": message},
          filePath: file.path,
        );
      }

      late Map<String, dynamic> data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else {
        data = Map<String, dynamic>.from(response.data);
      }

      if (data['status'] == 'success') {
        if (data['data'] != null && data['data'] is List) {
          final convertedData = List<Map<String, dynamic>>.from(data['data']);
          log("chats Data ============= $convertedData");
          yield Right(convertedData);
        } else {
          // No data, return empty list
          yield Right([]);
        }
      } else {
        yield Left(ServerFailure("Error Of Getting Data."));
      }
    } catch (e) {
      log("Error In Chat Repository:============== $e");
      yield Left(ServerFailure(e.toString()));
    }
  }

  Stream<Either<Failure, List<Map<String, dynamic>>>> getCardChats(
    String userId,
  ) async* {
    try {
      final response = await DioService.postData(
        url: ApiEndPoints.cardMessage,
        body: {"userId": userId},
      );

      late Map<String, dynamic> data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else {
        data = Map<String, dynamic>.from(response.data);
      }
      if (data['status'] == 'success') {
        final convertedData = List<Map<String, dynamic>>.from(data['data']);
        log("chats Data ============= $convertedData");
        yield Right(convertedData);
      } else {
        yield Left(ServerFailure("Error Of Getting Data."));
      }
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }
}
