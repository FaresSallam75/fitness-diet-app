// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:ordering_app/core/dio_services/api_end_point.dart';
// import 'package:ordering_app/core/dio_services/dio.dart';
// import 'package:ordering_app/core/error/failure.dart';

// class CartRepository {
//   Future<Either<Failure, List<Map<String, dynamic>>>> addCartData(
//     Map<String, dynamic> mapData,
//   ) async {
//     final response = await DioService.postData(
//       url: ApiEndPoints.cartAdd,
//       body: mapData,
//     );

//     late Map<String, dynamic> data;
//     if (response.data is String) {
//       data = jsonDecode(response.data);
//     } else {
//       data = Map<String, dynamic>.from(response.data);
//     }
//     if (data['status'] == 'success') {
//       final convertedData = List<Map<String, dynamic>>.from(data['data']);
//       return Right(convertedData);
//     } else {
//       return Left(ServerFailure("Error Of Getting Failed."));
//     }
//   }
// }
