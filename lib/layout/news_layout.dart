import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/search_screen.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/statas.dart';
 class NewsLayout extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<NewsCubit,NewsStates>(
       listener: (context,state){},
       builder:(context,state){
         var cubit = NewsCubit.get(context) ;
         return Scaffold(
           body: cubit.screens[cubit.currentIndex],
           appBar: AppBar(
             title: Text('News App'),
             actions: [
               IconButton(onPressed: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute
                       (builder: (context)=>SearchScreen()));
               },
                   icon: Icon(Icons.search)),
               IconButton(
                   icon: Icon(Icons.brightness_4_outlined),
               onPressed: (){
                     cubit.changeAppMode();
               },
               )
             ],
           ),
           bottomNavigationBar: BottomNavigationBar(
             items: cubit.bottomItems,
             currentIndex: cubit.currentIndex,
             onTap: (index){
               cubit.changeBottomNavBar(index);

             },
           ),


         ) ;
       },

     );
   }
 }
 