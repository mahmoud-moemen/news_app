import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());


  // ba5od object mn al cubit amskoo f eydy
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  // 3 screens 34an a toggle bynhom fl body
 List<Widget> screens=[
   BusinessScreen(),
   SportsScreen(),
   ScienceScreen(),
   SettingsScreen(),
 ];



  List<BottomNavigationBarItem> bottomItems=[
     BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
     BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
     BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
     BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];



  //ha create method h3mlha call fl onTap fl bottomNavBar f kol screena
  void ChangeBottomNavBar(int index)
  {
    currentIndex=index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavBarChangeState());
  }


   List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'4eaf33cc8aaa439997cbe8f4add7e49f',
      },
    ).then((value)
    {
       business= value.data['articles'];
       print(business[0]['title']);
       emit(NewsGetBusinessSuccessState());

    }).catchError((error){
      print('el errrrrrrrror aho:${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));

    });
  }



  List<dynamic> sports=[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'4eaf33cc8aaa439997cbe8f4add7e49f',
        },
      ).then((value)
      {
        sports= value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());

      }).catchError((error){
        print('el errrrrrrrror aho:${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));

      });
    }else
    {
      emit(NewsGetSportsSuccessState());
    }


  }



  List<dynamic> science=[];
  void getScience()
  {
    if (science.length == 0)
    {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'4eaf33cc8aaa439997cbe8f4add7e49f',
        },
      ).then((value)
      {
        science= value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());

      }).catchError((error){
        print('el errrrrrrrror aho:${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));

      });
    }else
      {
        emit(NewsGetScienceSuccessState());
      }

  }



  List<dynamic> search=[];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    //search=[];


    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'4eaf33cc8aaa439997cbe8f4add7e49f',
      },
    ).then((value)
    {
      search= value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());

    }).catchError((error){
      print('el errrrrrrrror aho:${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));

    });
  }

}

