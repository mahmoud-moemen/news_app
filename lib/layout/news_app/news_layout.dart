import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/appCubit/appCubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../../modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=NewsCubit.get(context);

        return Scaffold(
          appBar:AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton( icon: Icon(Icons.search),
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  }),
              IconButton( icon: Icon(Icons.brightness_4_outlined),
                  onPressed: ()
                  {
                    AppCubit.get(context).changeAppMode();
                  }),

            ],
          ) ,
          floatingActionButton: FloatingActionButton(
              onPressed:(){
                
              },
          child: Icon(Icons.add),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.ChangeBottomNavBar(index);
            },
            items:cubit.bottomItems,
          ),

        );
      },
    );
  }
}
