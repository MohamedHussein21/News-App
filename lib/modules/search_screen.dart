import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/component/component.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/statas.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(

                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);

                  },
                  decoration: InputDecoration(
                    labelText: "Search",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.search),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value){
                    if(value!.isEmpty )
                    {
                      return 'please write any thing';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),

            ],
          ),
        );
      },

    );
  }
}
