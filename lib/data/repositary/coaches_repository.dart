import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/core/dio_services/dio.dart';
import 'package:ordering_app/core/error/failure.dart';

class CoachesRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllCoaches() async {
    final response = await DioService.postData(
      url: ApiEndPoints.viewCoaches,
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
      log("coached Data ============= $convertedData");
      return Right(convertedData);
    } else {
      return Left(ServerFailure("Error Of Getting Data."));
    }
  }
}
