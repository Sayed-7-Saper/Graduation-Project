import 'package:artech/core/methods/get_width_and%20_height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/style/color_manger.dart';
import '../../../core/resources/constants.dart';
import '../../components/core/core_components.dart';
import '../../components/core/default_app_bar.dart';
import '../../components/profile_screen/setting_button.dart';
import '../../components/profile_screen/tff_header.dart';


class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nationalIdController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var departmentController = TextEditingController();
  var nameController = TextEditingController();
  var ensurePasswordController = TextEditingController();
  double verticalPaddingOfTFF = 8;
  double horizontalPaddingOfTFF = 8;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'تعديل ',
        withLeadingButton: true,
        leadingFunction: (){
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: getWidth(77, context).w,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: getWidth(75, context).w,
                          backgroundImage: AssetImage('assets/images/user.png',),
                        ),
                      ),
                      Positioned(
                        bottom: 9.h,
                        right: 9.h,
                        child: CircleAvatar(
                            radius: 13.w,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.add, color: Colors.white,size: 20.w,)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.h,),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'محمد ناصر',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 10.h,),
              TFFHeader(text: 'الاسم'),
              DefaultTextFormField(
                context: context,
                controller: nameController,
                hintColor: Colors.grey,
                withBorder: true,
                focusBorderColor: Colors.black,
                inputType: TextInputType.text,
                enabledBorderColor: Colors.black,
                verticalPadding: verticalPaddingOfTFF,
                horizontalPadding: horizontalPaddingOfTFF,
                color: Colors.transparent,
                validator: (value){
                  if(value!.isEmpty) return 'Enter your Name';
                  return null;
                },
                text: 'محمد ناصر',
              ),

              SizedBox(height: 10.h,),
              TFFHeader(text: 'البريد الالكتروني'),
              DefaultTextFormField(
                context: context,
                controller: emailController,
                hintColor: Colors.grey,
                withBorder: true,
                focusBorderColor: Colors.black,
                inputType: TextInputType.emailAddress,
                enabledBorderColor: Colors.black,
                verticalPadding: verticalPaddingOfTFF,
                horizontalPadding: horizontalPaddingOfTFF,
                color: Colors.transparent,
                validator: (value){
                  if(value!.isEmpty) return 'Enter your Email';
                  return null;

                },
                text: 'Mohamed@gmail.com',
              ),




              SizedBox(height: 26.h,),

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: customButton(
                  text: 'حفظ البيانات',
                  elevation: 0.0,
                  height: 38.h,
                  textColor: Colors.black.withOpacity(0.8),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width*0.4,
                  function: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 36.h,),

            ],
          ),
        ),
      ),
    );
  }
}

