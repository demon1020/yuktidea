import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/startup/model/term_condition_model.dart';

import '../../features/country_selection/model/country.dart';
import '../../features/country_selection/model/selected_country.dart';
import '../../features/home/model/logout_model.dart';
import '../../features/otp_verification/model/get_otp_model.dart';
import '../../features/otp_verification/model/verify_otp_model.dart';
import '../../utils/enums/enums.dart';
import '../app_excaptions.dart';

class ApiResponse<T> {
  Status? status;

  T? data;

  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}

class Parser {
  static Future<TermCondition> parseTermConditionResponse(
      String responseBody) async {
    return TermCondition.fromJson(json.decode(responseBody));
  }

  static Future<CountryCode> parseCountriesCodeResponse(
      String responseBody) async {
    return CountryCode.fromJson(json.decode(responseBody));
  }

  static Future<GetOtp> parseGetOtpResponse(String responseBody) async {
    return GetOtp.fromJson(json.decode(responseBody));
  }

  static Future<SelectCountry> parseSelectCountryResponse(
      String responseBody) async {
    return SelectCountry.fromJson(json.decode(responseBody));
  }

  static Future<SelectedCountry> parseSelectedCountryResponse(
      String responseBody) async {
    return SelectedCountry.fromJson(json.decode(responseBody));
  }

  static Future<UserDeleteLogout> parseLogoutResponse(
      String responseBody) async {
    return UserDeleteLogout.fromJson(json.decode(responseBody));
  }

  static Future<UserDeleteLogout> parseDeleteUserResponse(
      String responseBody) async {
    return UserDeleteLogout.fromJson(json.decode(responseBody));
  }

  static Future<VerifyOtp> parseVerifyOtpResponse(String responseBody) async {
    return VerifyOtp.fromJson(json.decode(responseBody));
  }
  //
  // static Future<UserRegister> parseUserRegisterResponse(String responseBody) async {
  //   return UserRegister.fromJson(json.decode(responseBody));
  // }
  //
  // static Future<List<ProductListingModel>> parseProductListResponse(String responseBody) async {
  //   var jsonDataList = jsonDecode(responseBody);
  //   List<ProductListingModel> products = List<ProductListingModel>.from(jsonDataList.map((item) => ProductListingModel.fromJson(item)));
  //   return products;
  // }
  //
  // static Future<ProductListingModel> parseProductResponse(String responseBody) async {
  //   return ProductListingModel.fromJson(json.decode(responseBody));
  // }

  static Future<Either<AppException, Q>> parseResponse<Q, R>(
      http.Response response, ComputeCallback<String, R> callback) async {
    if (response == null) {
      print('response is null ');
      return Left(UnknownError());
    } else {
      // log('callback : ${callback.toString()}response.statusCode : ${response.statusCode} | response.body ${response.body}');
      try {
        switch (response.statusCode) {
          case 200:
            {
              var result = await compute(callback, response.body.toString());
              return Right(result as Q);
            }
          // break;
          case 401:
            return Left(ForbiddenError());
            break;
          case 403:
            return Left(UnAuthorizedError());
            break;
          case 404:
            return Left(ServerError(
                statusCode: response.statusCode, message: "File not found"));
            break;
          case 500:
            return Left(ServerError(
                statusCode: response.statusCode, message: "Server Failure"));
            break;
          default:
            return Left(UnknownError(
                statusCode: response.statusCode, message: response.body));
        }
      } catch (e) {
        // throw e;
        return Left(UnknownError());
      }
    }
  }
}
