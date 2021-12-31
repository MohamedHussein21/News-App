
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business_screen.dart';
import 'package:newsapp/modules/science_screen.dart';
import 'package:newsapp/modules/sports_screen.dart';
import 'package:newsapp/shared/cubit/statas.dart';
import 'package:newsapp/shared/network/remote/cash_Helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitiailState());

  static NewsCubit get(context) =>BlocProvider.of(context);

  int currentIndex =0;

  List<Widget> screens =[
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon:Icon(Icons.business) ,
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.sports_baseball) ,
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.science) ,
        label: 'Science'
    ),

  ];
  void changeBottomNavBar (int index){
     currentIndex =index;
    // if(index==0)
    //   getBusiness();
    // if(index==1)
    //   getSports();
    // if(index==2)
    //   getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];

  void getBusiness (){
    emit(NewsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'ae3a7c382f0e49cfabc37755a5602d76',
      },
    ).then((value) {
      emit(NewsGetBusinessSuccessState());
      business =value.data['articles'];
      print(business);
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));

      print(error.toString());
    });
  }

  List<dynamic> sports =[];

  void getSports (){
     emit(NewsLoadingState());
    if(sports.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'ae3a7c382f0e49cfabc37755a5602d76',
          },
        ).then((value) {
          emit(NewsGetSportsSuccessState());
          sports =value.data['articles'];

        }).catchError((error){
          emit(NewsGetSportsErrorState(error.toString()));

          print(error.toString());
        });
      }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science =[];

  void getScience (){
    emit(NewsLoadingState());
    if(science.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'ae3a7c382f0e49cfabc37755a5602d76',
          },
        ).then((value) {
          emit(NewsGetScienceSuccessState());
          science =value.data['articles'];
        }).catchError((error){
          emit(NewsGetScienceErrorState(error.toString()));

          print(error.toString());
        });
      }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search =[];

  void getSearch (String value){
    emit(NewsLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'${value}',
          'apiKey':'ae3a7c382f0e49cfabc37755a5602d76',
        },
      ).then((value) {
        emit(NewsGetSearchSuccessState());
        search =value.data['articles'];
      }).catchError((error){
        emit(NewsGetSearchErrorState(error.toString()));

        print(error.toString());
      });

  }

   bool isDark = false;
  void changeAppMode ({ bool? fromshare}){

    if(fromshare!= null){
      isDark =fromshare;
      emit(ChangeAppMode());
    }else {
      isDark = !isDark;
      CachHelper.putData(key: 'isDark', value: isDark).then((value){
        emit(ChangeAppMode());
      });
      emit(ChangeAppMode());
    }


  }


}