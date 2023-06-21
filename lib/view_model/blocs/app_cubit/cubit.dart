import 'dart:io';
import 'dart:async';
import 'package:artech/core/resources/app_timer.dart';
import 'package:artech/view/pages/profile/profile_screen.dart';
import 'package:artech/view_model/blocs/app_cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/resources/constants.dart';
import '../../../model/college_model.dart';
import '../../../model/question_model.dart';
import '../../../view/components/exams/finish_exam_dialog.dart';
import '../../../view/pages/exams/drawing_area_screen.dart';
import '../../../view/pages/home/home_screen.dart';
import '../../../view/pages/notifications_screen.dart';



class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavBarItems=[
    BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.email_rounded),label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: ''),

  ];

  List<Widget> screens=[
    ProfileScreen(),
    NotificationsScreen(),
    HomeScreen(),
  ];

  int currentIndex=2;
  void changeBottomNavBarIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarIndexState());
  }




  List<CollegeModel> departments=[
    CollegeModel(image: '$imagePath/images/nnn.png', name: 'قسم النحت'),
    CollegeModel(image: '$imagePath/images/offer3.jpg', name: 'قسم الديكور'),
    CollegeModel(image: '$imagePath/images/offer.png', name: 'قسم التصوير'),
    CollegeModel(image: '$imagePath/images/mmm.png', name: 'قسم العمارة'),
    CollegeModel(image: '$imagePath/images/ff.png', name: 'قسم الجرافيك'),


  ];


  List<CollegeModel> homeMenu=[
    CollegeModel( image: '$imagePath/icons/home1.svg', name: 'البيانات الشخصية'),
    CollegeModel( image: '$imagePath/icons/home2.svg', name: 'تسجيل اختبار القدرات'),
    CollegeModel( image: '$imagePath/icons/home3.svg', name: 'بدأ اختبار القدرات'),
    CollegeModel( image: '$imagePath/icons/home4.svg', name: 'نتائج الاختبار'),
    CollegeModel( image: '$imagePath/icons/home5.svg', name: 'حجز الكورسات'),
    CollegeModel( image: '$imagePath/icons/home6.svg', name: 'الامتحان التجريبي'),
  ];


  int mcqRegistrationPageNumber=0;
  void changeMCQRegistrationPageNumber(int index){
    mcqRegistrationPageNumber= index;
    emit(AppChangeMCQRegistrationPageNumberState());
  }


  /// this method to toggle between courses pages in courses registration.
  bool isAllCourses=true;
  void toggleCoursesPage(bool value){
    isAllCourses=value;
    emit(AppToggleCoursesPageState());
  }


  /// this method to toggle between payment methods.
  bool isFawry=true;
  void togglePaymentMethods(bool value){
    isFawry=value;
    emit(AppTogglePaymentMethodsState());
  }


  /// if the user enter the exam the value will be true
  /// then he will not enter again.
  bool isMCQExamDone=false;
  void exitMCQExam(){
    isMCQExamDone=true;
  }

  bool isArtisticExamDone=false;
  void exitArtisticExam(){
    isArtisticExamDone=true;
  }

  bool isDrawingExamExamDone=false;
  void exitDrawingExam(){
    isDrawingExamExamDone=true;
  }

  List<QuestionModel> mcqQuestions=[
    QuestionModel(
      question: 'من اقسام الفنون التطبيقية اقسام التصميم الداخلي والخزف والغزل والنسيجوالتريكو والنحت',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'اعتقد المصريون القدماء بفكرة',
      answers: [
        'التجنيد',
        'البعث والخلود',
        'الحياه لابديه',
        'التكيف',
      ],
    ),
    QuestionModel(
      question: 'ولد الفنان سيد درويش بحي',
      answers: [
        'الفيوم',
        'الاقصر',
        'كوم الدكه',

      ],
    ),
    QuestionModel(
      question: 'مخترع الهاتف',
      answers: [
        'جرام بل',
        'توماس ايدسون',
      ],
    ),
    QuestionModel(
      question: 'فن الارابيسك هو فن خراطة',
      answers: [
        'الاخشاب',
        'الرخام',
      ],
    ),
    QuestionModel(
      question: 'من اشكال الفن التشكيلي',
      answers: [
        'النحت',
        'التشكيل',
        'التصميم',
        'الابداع',
      ],
    ),
    QuestionModel(
      question: 'يرتبط التزوق الفني بمعني ',
      answers: [
        'الادراك البصرى',
        'الادراك الحسي',
        'الادراك الذوقي',

      ],
    ),
    QuestionModel(
      question: 'حياة الانسان والعلاقات بين الافراد',
      answers: [
        'الوطن',
        'المجتمع',
        'البلد',
      ],
    ),
    QuestionModel(
      question: 'هفي عصر الدولة الحديثة عصر لايوجد فيه',
      answers: [
        'بناء الاهرامات',
        'بناء الكباري',
      ],
    ),
    QuestionModel(
      question: 'من الالوان الثانوية',
      answers: [
        'البرتقالي',
        'ابيض',
        "وردي",
      ],
    ), QuestionModel(
      question: 'هو قيمة الاضاءة والعتامة وهو المميز الواضح للشكل بالنسبة لم يحيط به',
      answers: [
        'اللون',
        'الحجم',
        'القيمه',
        'الطول',
      ],
    ),
    QuestionModel(
      question: 'ينتج اللون الاسود من اكسيد',
      answers: [
        'الصوديوم',
        'المنجنيز',
        'البوتاسيوم',
      ],
    ),
    QuestionModel(
      question: 'الكوفي والديواني والفارسي والثلث انواع من',
      answers: [
        'الخطوط الايراني',
        'الخطوط الفارسي',
        'الخطوط العربية',
        'الخطوط الانجليزي',
      ],
    ),
    QuestionModel(
      question: 'المدرسة التائثيرية هي المدرسي من الانطباعية',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'من المعادن المرنة في التشكيل بالطرق :الالومنيوم',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'هي مدرسة تعتمد علي العاطفة والاحساس ',
      answers: [
        ' المدرسة الحديثه',
        ' المدرسة الرومانسية',
        ' المدرسة القديمه',

      ],
    ),
    QuestionModel(
      question: 'استخدمت الكتابات الهيروغليفية علي جدران المعابد والمقابر في مصر القديمة ',
      answers: [
        'لتسجيل الظرف',
        'لتسجيل الاحداث',
        'لتسجيل الاماكن',
      ],
    ),
    QuestionModel(
      question: 'للمحافظة علي التمثال المصري من الكسر تكون الايدي',
      answers: [
        'ملتصقة برأس ',
        'ملتصقة بالجسم',

      ],
    ),
    QuestionModel(
      question: 'فنان تلقائي لم يتلقي تعليميا اكاديميا في الفن :فطرى',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'يعد الرمل المكون الاساسي في صناعة الزجاج',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'من انواع الجلود الطبيعية السميكة جلد',
      answers: [
        'الاسماك',
        'البقر',
        'الماعز',
        'الخيل',
      ],
    ),
    QuestionModel(
      question: 'اللون البرتقالي من الالوان الثانوية',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'بني الجامع الازهر الشريف في عهد الايوبين',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'تعتبر البيوت النوبية من اشكال الفن الشعبي',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'يعتبر الفن الاسلامي فن نفعي لانه مرتبط باحتياجات الانسان',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'اتسمت التماثيل في العصر الحجري بتناسق النسب الجثمانية',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'فن صناعة الحشوات والتطعيم والارابيسك من اهم الصناعات الخشبية الاسلامية',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'التكعيبة هي مدرسة تعتمد علي العاطفة والاحاسيس',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'الرقص من اشكال الفن التشكيلي',
      answers: [
        'صح',
        'خطأ',
      ],
    ),
    QuestionModel(
      question: 'تكون اللون الاخضر من خلط الالوان الاصفر مع اللون الازرق',
      answers: [
        'صح',
        'خطأ',
      ],
    ),

  ];

  /// list of answers of the MCQ exam
  List<int> answerNumbers=[0,1,0,1,0,1,0,1,1,0,1,0,0,1,0,0,1,1,1,0,1,0,1,2,0,1,0,1,1,0,];

  /// when the user select an answer this method is called and update the answer.
  void changeAnswer(int index, int answerNumber){
    answerNumbers[index]= answerNumber;
    emit(AppChangeAnswerNumberState());
  }

  int mcqExamPageNumber=0;
  void changeMCQExamPageNumber(int index){
    mcqExamPageNumber=index;
    emit(AppChangeMCQExamPageNumberState());
  }




  /// method to upload the user image when he register to the exam.
  File? artisticExamImage;
  var picker = ImagePicker();
  void pickArtisticExamImage(context) async {
    final pickedFile = await picker.pickImage(
      //source: ImageSource.gallery,
      source: ImageSource.camera,

    );

    if (pickedFile != null) {
      artisticExamImage = File(pickedFile.path);
      emit(ArtisticExamImagePickedSuccess());
    } else {
      emit(ArtisticExamImagePickedError());
    }
  }

  void deleteArtisticExamImage(){
    artisticExamImage=null;
    emit(DeleteArtisticExamImageState());
  }


  File? userImage;
  void pickUserImage(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      emit(UserImagePickedSuccess());
    } else {
      emit(UserImagePickedError());
    }
  }



  late Timer timer ;
  String remainingTime= '90:${DateTime.now().minute}';
  void startTimer({
    context,
    required int time,
  }){
    timer= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (DateTime.now().minute == 0) {
        if(time==0){
          timer.cancel();
          finishExamDialog(
            context: context,
            function: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
        time--;
      }
      remainingTime= '$time:${60-DateTime.now().second}';

      emit(AppChangeTimeState());
    });
  }

  void endTimer(){
    timer.cancel();
  }


  /// pagination page
   int cIndex=0;
  void changePagination(int i){
    cIndex=i;
    emit(AppChangeAnswerNumberState());
  }

  bool isInformationPage= true;
  void changeUserInformationPage(){
    isInformationPage=!isInformationPage;
    emit(ChangeUserInformationPageState());
  }



/*
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;

  // @override
  // void initState() {
  //   startCamera(direction);
  //   super.initState();
  // }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  */

}

