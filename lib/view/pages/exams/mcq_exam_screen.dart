
import 'dart:async';

import 'package:artech/core/resources/constants.dart';
import 'package:artech/view/components/core/core_components.dart';
import 'package:artech/view_model/blocs/app_cubit/cubit.dart';
import 'package:artech/view_model/blocs/app_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/methods/get_width_and _height.dart';
import '../../../core/resources/style/color_manger.dart';
import '../../../model/question_model.dart';
import '../../components/exams/finish_exam_dialog.dart';
import '../../components/exams/mcq_exam/mcq_exam_body.dart';
import 'drawing_area_screen.dart';


class MCQExamScreen extends  StatelessWidget {

  var mcqExamPageController = PageController();



  @override
  Widget build(BuildContext context) {
    AppCubit cubit =AppCubit.get(context);
    Size size = MediaQuery
        .of(context)
        .size;
    List<Widget> screens = [
      MCQExamBody(question: cubit.mcqQuestions[0], questionIndex: 0),
      MCQExamBody(question: cubit.mcqQuestions[1], questionIndex: 1),
      MCQExamBody(question: cubit.mcqQuestions[2], questionIndex: 2),
      MCQExamBody(question: cubit.mcqQuestions[3], questionIndex: 3),
      MCQExamBody(question: cubit.mcqQuestions[4], questionIndex: 4),
      MCQExamBody(question: cubit.mcqQuestions[5], questionIndex: 5),
      MCQExamBody(question: cubit.mcqQuestions[6], questionIndex: 6),
      MCQExamBody(question: cubit.mcqQuestions[7], questionIndex: 7),
      MCQExamBody(question: cubit.mcqQuestions[8], questionIndex: 8),
      MCQExamBody(question: cubit.mcqQuestions[9], questionIndex: 9),
      MCQExamBody(question: cubit.mcqQuestions[10], questionIndex: 10),
      MCQExamBody(question: cubit.mcqQuestions[11], questionIndex: 11),
      MCQExamBody(question: cubit.mcqQuestions[12], questionIndex: 12),
      MCQExamBody(question: cubit.mcqQuestions[13], questionIndex: 13),
      MCQExamBody(question: cubit.mcqQuestions[14], questionIndex: 14),
      MCQExamBody(question: cubit.mcqQuestions[15], questionIndex: 15),
      MCQExamBody(question: cubit.mcqQuestions[16], questionIndex: 16),
      MCQExamBody(question: cubit.mcqQuestions[17], questionIndex: 17),
      MCQExamBody(question: cubit.mcqQuestions[18], questionIndex: 18),
      MCQExamBody(question: cubit.mcqQuestions[19], questionIndex: 19),
      MCQExamBody(question: cubit.mcqQuestions[20], questionIndex: 20),
      MCQExamBody(question: cubit.mcqQuestions[21], questionIndex: 21),
      MCQExamBody(question: cubit.mcqQuestions[22], questionIndex: 22),
      MCQExamBody(question: cubit.mcqQuestions[23], questionIndex: 23),
      MCQExamBody(question: cubit.mcqQuestions[24], questionIndex: 24),
      MCQExamBody(question: cubit.mcqQuestions[25], questionIndex: 25),
      MCQExamBody(question: cubit.mcqQuestions[26], questionIndex: 26),
      MCQExamBody(question: cubit.mcqQuestions[27], questionIndex: 27),
      MCQExamBody(question: cubit.mcqQuestions[28], questionIndex: 28),
      MCQExamBody(question: cubit.mcqQuestions[29], questionIndex: 29),
      //MCQExamBody(question: cubit.mcqQuestions[30], questionIndex: 30),


    ];

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          backgroundColor: AppColors.secondaryScaffoldColor,

          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultHorizontalScreenPadding,
                vertical: 24.0,
              ),
              child: Column(
                children: [

                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (context, index) => screens[index],
                      onPageChanged: (index) {
                        AppCubit.get(context).changeMCQExamPageNumber(index);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: screens.length,
                      controller: mcqExamPageController,
                    ),
                  ),

                  /// pagination
                  SizedBox(
                    height: getWidth(40, context),
                    width: double.infinity,
                    child: Center(
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),////////////////////
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ConditionalBuilder(
                            condition: (AppCubit.get(context).mcqExamPageNumber-index).abs() <=2,
                            builder: (context)=> customButton(
                                text: '${index + 1}',
                                radius: 12, 
                                elevation: 0.0,
                                height: getWidth(44, context),
                                width: getWidth(44, context),
                                textColor: Colors.black,
                                color: AppCubit.get(context).mcqExamPageNumber==index ?AppColors.primaryColor : Colors.white,
                                function: (){
                                  mcqExamPageController.jumpToPage(index);
                            }),


                            fallback: null,
                          );
                        },
                        separatorBuilder: (context, index)=>SizedBox(width: 12.w,),
                        itemCount: screens.length,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h,),
                  BlocConsumer<AppCubit, AppStates>(
                    listener: (context, state){},
                    builder: (context, state){
                      AppCubit cubit = AppCubit.get(context);

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(cubit.mcqExamPageNumber!=0)
                            customButton(
                            text: 'السابق',
                            color: Colors.white,
                            icon: Icons.arrow_back_ios_rounded,
                            textColor: Colors.black,
                            elevation: 0.0,
                            width: getWidth(90, context),
                            height: getHeight(37, context),
                            function: (){
                              mcqExamPageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
                            },
                          ),
                          const SizedBox(),
                          if(cubit.mcqExamPageNumber!=screens.length-1)
                            customButton(
                            text: 'التالي',
                            color: Colors.white,
                            suffixIcon: Icons.arrow_forward_ios_rounded,
                            textColor: Colors.black,
                            elevation: 0.0,
                            width: getWidth(90, context),
                            height: getHeight(37, context),
                            function: (){
                              mcqExamPageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
                            },
                          ),
                        ],
                      );
                    },
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


                  const SizedBox(height: 20.0,),
                  customButton(
                    text: 'انهاء الامتحان',
                    color: Colors.white,
                    textColor: Colors.black,
                    withBorder: true,
                    width: getWidth(232, context),
                    function: (){
                      finishExamDialog(
                        context: context,
                        function: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          cubit.endTimer();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}







