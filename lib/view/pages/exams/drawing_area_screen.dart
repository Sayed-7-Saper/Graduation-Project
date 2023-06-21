
/*
import 'package:artech/view/components/core/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/methods/get_width_and _height.dart';
import '../../../core/resources/style/color_manger.dart';
import '../../../core/resources/constants.dart';
import '../../../view_model/blocs/app_cubit/cubit.dart';
import '../../../view_model/blocs/app_cubit/states.dart';
import '../../components/core/core_components.dart';
import '../../components/exams/finish_exam_dialog.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class DrawingAreaScreen extends StatelessWidget {
   DrawingAreaScreen({Key? key}) : super(key: key);
  final DrawingController _drawingController = DrawingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: '',
        withLeadingButton: true,
        leadingFunction: (){
          Navigator.pop(context);
        },
      ),
      body:Expanded(
        child:DrawingBoard(
          controller: _drawingController,
          background: Container(width: 400, height: 400, color: Colors.white),
          showDefaultActions: true,
          showDefaultTools: true,
        ) ,
      ),

      /*Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const[
                Icon(Icons.draw_outlined, size: 32,),
                Icon(Icons.crop_square_rounded, size: 32,),
                Icon(Icons.circle_outlined, size: 32,),
                Icon(Icons.brush, size: 32,),
                Icon(Icons.edit_sharp, size: 32,),
                Icon(Icons.draw_outlined, size: 32,),
              ],
            ),
          ),

          const Expanded(
            child: SizedBox(
              width: double.infinity,
            ),
          ),

          BlocConsumer<AppCubit, AppStates>(
            listener: (context, state){},
            builder: (context, state){
              AppCubit cubit = AppCubit.get(context);
              return Text(
                AppCubit.get(context).remainingTime,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                ),
              );
            },
          ),
          SizedBox(height: 20.0.h,),
          customButton(
            text: 'انهاء الامتحان',
            color: Colors.white,
            height: getHeight(72, context),
            textColor: Colors.black,
            withBorder: true,
            width: getWidth(232, context),
            function: (){
              finishExamDialog(
                context: context,
                function: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  AppCubit.get(context).endTimer();

                },
              );
            },
          ),
          SizedBox(height: 30.h,),
        ],
      ),*/
    );
  }
}



*/


// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:artech/view/components/core/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/methods/get_width_and _height.dart';
import '../../../core/resources/style/color_manger.dart';
import '../../../core/resources/constants.dart';
import '../../../view_model/blocs/app_cubit/cubit.dart';
import '../../../view_model/blocs/app_cubit/states.dart';
import '../../components/core/core_components.dart';
import '../../components/exams/finish_exam_dialog.dart';

class DrawingAreaScreen extends StatelessWidget {
  DrawingAreaScreen({Key? key}) : super(key: key);
  final DrawingController _drawingController = DrawingController();
  Future<void> _getImageData(BuildContext context) async {
    final Uint8List? data =
    (await _drawingController.getImageData())?.buffer.asUint8List();
    if (data == null) {
      print(data.toString());
      return;
    }
    showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(child: Image.memory(data)),
          ),
        );
      },
    );
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(
          title: '',
          withLeadingButton: true,
          leadingFunction: () {
            Navigator.pop(context);
          },
        ),
        body: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              DrawingBoard(
                controller: _drawingController,
                background:
                Container(height: 600, width: 500, color: Colors.white),
                showDefaultActions: true,
                showDefaultTools: true,
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      _getImageData(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      width: 70,
                      height: 70,
                      child: const Icon(
                        Icons.save_alt,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  )),
            ],
          ),
        )
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [

      //     Container(
      //       padding: EdgeInsets.all(10.w),
      //       margin: EdgeInsets.all(10.w),
      //       decoration: BoxDecoration(
      //         border: Border.all(color: Colors.black),
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: const[
      //           Icon(Icons.draw_outlined, size: 32,),
      //           Icon(Icons.crop_square_rounded, size: 32,),
      //           Icon(Icons.circle_outlined, size: 32,),
      //           Icon(Icons.brush, size: 32,),
      //           Icon(Icons.edit_sharp, size: 32,),
      //           Icon(Icons.draw_outlined, size: 32,),
      //         ],
      //       ),
      //     ),

      //     const Expanded(
      //       child: SizedBox(
      //         width: double.infinity,
      //       ),
      //     ),

      //     BlocConsumer<AppCubit, AppStates>(
      //       listener: (context, state){},
      //       builder: (context, state){
      //         AppCubit cubit = AppCubit.get(context);
      //         return Text(
      //           AppCubit.get(context).remainingTime,
      //           style: TextStyle(
      //             color: Colors.red,
      //             fontFamily: fontFamily,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 28.sp,
      //           ),
      //         );
      //       },
      //     ),
      //     SizedBox(height: 20.0.h,),
      //     customButton(
      //       text: 'انهاء الامتحان',
      //       color: Colors.white,
      //       height: getHeight(72, context),
      //       textColor: Colors.black,
      //       withBorder: true,
      //       width: getWidth(232, context),
      //       function: (){
      //         finishExamDialog(
      //           context: context,
      //           function: (){
      //             Navigator.pop(context);
      //             Navigator.pop(context);
      //             AppCubit.get(context).endTimer();

      //           },
      //         );
      //       },
      //     ),
      //     SizedBox(height: 30.h,),
      //   ],
      // ),
    );
  }
}