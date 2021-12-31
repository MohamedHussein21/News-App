import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/component/component.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/statas.dart';
class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return  BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state)  {
          var list = NewsCubit.get(context).science;
          return articleBuilder(list,context);
        });
  }
}
