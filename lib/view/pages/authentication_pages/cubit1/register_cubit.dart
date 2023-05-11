import 'dart:io';
import 'package:artech/core/routes/share/api_helper.dart';
import 'package:artech/view/pages/authentication_pages/cubit1/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/login_model.dart';

// class RegisterCubit extends Cubit<RegisterStates>{
//   RegisterCubit():super(RegisterInitialState());
//   static RegisterCubit get(context)=>BlocProvider.of(context);
//   void userRegister({
//     @required String token,
//     @required String first_name,
//     @required String last_name,
//     @required int age,
//     @required String gender,
//     String image,
//   }){
//     AppUserModel loginModel ;
//     emit(RegisterLoadingState());
//     DioHelper.putData(
//       url: REGISTER,
//       token: token,
//       data: {
//         "first_name":first_name,
//         "last_name":last_name,
//         "age":age,
//         "gender":gender,
//         "image":image,
//       },
//     ).then((value){
//       loginModel = AppUserModel.fromJson(value.data);
//       emit(RegisterSuccessState(loginModel));
//
//     }).catchError((error){
//       emit(RegisterErrorState(error.toString()));
//       print(error.toString());
//
//     });
//
//   }
//
//
// }

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  Future<AppUserModel?> userRegister({
    required String token,
    required String name,
    required String email,
    required String password,
    // File image,
  })async{
    AppUserModel loginModel ;
    emit(RegisterLoadingState());
    try{
      Map<String,dynamic> data = await Api().put(
        url: 'http://142.93.115.216/user/profile/api/profile/',
        body: {
          "name":name,
          "email":email,
          "password":password,
          //  "image":image,
        },
        token:token,
      );
      loginModel = AppUserModel.fromJson(data);
      emit(RegisterSuccessState(loginModel));
      return loginModel;
    }on Exception catch(error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    }

    // .then((value){
    //   loginModel = AppUserModel.fromJson(value.data);
    //   emit(RegisterSuccessState(loginModel));
    //
    // }).catchError((error){
    //   emit(RegisterErrorState(error.toString()));
    //   print(error.toString());
    //
    // });
    // return AppUserModel.fromJson(data);

  }

}