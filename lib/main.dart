import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/appCubit/appCubit.dart';
import 'package:news_app/shared/appCubit/appStates.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';

void main()async
{//بيتأكد ان كل حاجه في الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        ()async  {
      DioHelper.inti();
      await CacheHelper.init();

      bool? isDark =CacheHelper.getBoolean(key:'isDark');
      print(isDark);
      runApp(MyApp(isDark!));
    },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context)
  {
    return   MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) =>NewsCubit()..getBusiness() ),
        BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(fromCache:isDark )),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness:Brightness.dark,
                  ),//bt7km f style  status bar
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                floatingActionButtonTheme:FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange
                ) ,
                bottomNavigationBarTheme:BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor:Colors.grey ,
                  elevation: 20.0,
                  backgroundColor: Colors.white,

                ),
                textTheme:TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarBrightness:Brightness.light,
                ),//bt7km f style  status bar
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              floatingActionButtonTheme:FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange
              ) ,
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor:Colors.grey ,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme:TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ) ,

            ),
            themeMode:AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:Directionality(
                textDirection: TextDirection.ltr,
                child: NewsLayout()),
          );
        },
      ),
    );
  }
}
