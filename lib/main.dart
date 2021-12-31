import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/statas.dart';
import 'package:newsapp/shared/network/remote/cash_Helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layout/news_layout.dart';
import 'shared/bloc_observer.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  Bloc.observer = MyBlocObserver();
   bool? isDark = CachHelper.getData(key: 'isDark');

   runApp(NewsApp(isDark!=null?isDark:false));
}

class NewsApp extends StatelessWidget {
    bool? isDark;

   NewsApp(this.isDark );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience()..changeAppMode(),),
    //     BlocProvider( create: (BuildContext context)=>NewsCubit()..changeAppMode(
    // fromshare: isDark!,
    // )),
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = NewsCubit.get(context) ;
        return  MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                  ),
                  backwardsCompatibility: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(

                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.black
                  )

              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,


              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
              ),

            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  backwardsCompatibility: false,
                  backgroundColor:HexColor('333739'),
                  elevation: 0,
                  titleTextStyle: TextStyle(

                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.white
                  )

              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
                backgroundColor: HexColor('333739'),


              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )
              ),
            ),

            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: NewsLayout() ,
          );
        },

      ),
    );
  }
}


