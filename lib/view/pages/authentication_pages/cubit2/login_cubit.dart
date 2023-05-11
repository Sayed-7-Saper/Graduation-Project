import 'package:artech/core/routes/share/api_helper.dart';
import 'package:artech/view/pages/authentication_pages/cubit2/login_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../model/login_model.dart';

// class LoginCubit extends Cubit<LoginStates>{
//   LoginCubit():super(LoginInitialState());
//   static LoginCubit get(context)=>BlocProvider.of(context);
//   void userLogin({
//   @required int phoneNumber,
//
//   }){
//     AppUserModel loginModel ;
//     emit(LoginLoadingState());
//     DioHelper.postData(
//         url: LOGIN,
//         data: {
//           "phone_number":phoneNumber,
//         },
//     ).then((value){
//      // print(value.data);
//       loginModel = AppUserModel.fromJson(value.data);
//       emit(LoginSuccessState(loginModel));
//     }).catchError((error){
//       print(error.toString());
//       emit(LoginErrorState(error.toString()));
//       print(error.toString());
//
//     });
//
//   }
//
// }

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  Future<AppUserModel> userLogin({
    required String email, // int
    required String password

  }) async {
    AppUserModel loginModel;
    emit(LoginLoadingState());
    try{
      Map<String, dynamic> data = await Api().post(
          url: 'http://142.93.115.216/user/api/register_or_login/',
          body: {
            "email": email,
            "password": password,
          });
      loginModel = AppUserModel.fromJson(data);
      emit(LoginSuccessState(loginModel));
      return loginModel;
    }on Exception catch (error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
      throw Exception("Error on server !");
    }

    //.then((value) {
    //    loginModel = AppUserModel.fromJson(value.data);
    //    emit(LoginSuccessState(loginModel));
    //  }).catchError((error) {
    //    emit(LoginErrorState(error.toString()));
    //    print(error.toString());
    //  });
    // // return AppUserModel.fromJson(data);
  }
}