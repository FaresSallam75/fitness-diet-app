import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/dio_services/dio.dart';
import 'package:ordering_app/core/error/failure.dart';

class MenuRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> getMenuData() async {
    final response = await DioService.postData(
      url: ApiEndPoints.viewMenu,
      body: {},
    );

    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = Map<String, dynamic>.from(response.data);
    }
    if (data['status'] == 'success') {
      final convertedData = List<Map<String, dynamic>>.from(data['data']);
      return Right(convertedData);
    } else {
      return Left(ServerFailure("Error Of Getting Data."));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> addCartData(
    Map<String, dynamic> mapData,
  ) async {
    final response = await DioService.postData(
      url: ApiEndPoints.cartAdd,
      body: mapData,
    );

    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = Map<String, dynamic>.from(response.data);
    }

    if (data['status'] == 'success') {
      if (data.containsKey('data')) {
        if (data['data'] is List) {
          // ✅ case: list of items
          final convertedData = List<Map<String, dynamic>>.from(data['data']);
          log(
            "convertedData (single): ==================== ${convertedData.toString()}",
          );
          return Right(convertedData);
        } else if (data['data'] is Map) {
          // ✅ case: single object
          final convertedData = [Map<String, dynamic>.from(data['data'])];
          log(
            "convertedData (single): ==================== ${convertedData.toString()}",
          );
          return Right(convertedData);
        }
      }
      // ✅ case: success with no data
      return Right([]);
    } else {
      return Left(ServerFailure("Error Of Getting Failed."));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> removeCartData(
    Map<String, dynamic> mapData,
  ) async {
    final response = await DioService.postData(
      url: ApiEndPoints.cartRemove,
      body: mapData,
    );

    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = Map<String, dynamic>.from(response.data);
    }

    if (data['status'] == 'success') {
      if (data.containsKey('data')) {
        if (data['data'] is List) {
          final convertedData = List<Map<String, dynamic>>.from(data['data']);
          return Right(convertedData);
        } else if (data['data'] is Map) {
          final convertedData = [Map<String, dynamic>.from(data['data'])];
          return Right(convertedData);
        }
      }

      return Right([]);
    } else {
      return Left(ServerFailure("Error Of Getting Failed."));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> viewCartData(
    Map<String, dynamic> mapData,
  ) async {
    final response = await DioService.postData(
      url: ApiEndPoints.cartview,
      body: mapData,
    );

    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = Map<String, dynamic>.from(response.data);
    }

    if (data['status'] == 'success') {
      if (data.containsKey('data')) {
        if (data['data'] is List) {
          // ✅ case: list of items
          final convertedData = List<Map<String, dynamic>>.from(data['data']);
          print("convertedData: ==================== $convertedData");
          return Right(convertedData);
        } else if (data['data'] is Map) {
          // ✅ case: single object
          final convertedData = [Map<String, dynamic>.from(data['data'])];
          print("convertedData (single): ==================== $convertedData");
          return Right(convertedData);
        }
      }
      // ✅ case: success with no data
      return Right([]);
    } else {
      return Left(ServerFailure("Error Of Getting Failed."));
    }
  }
}
