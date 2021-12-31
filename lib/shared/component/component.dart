import 'package:flutter/material.dart';
import 'package:newsapp/modules/webView_screen.dart';
import 'package:newsapp/shared/cubit/cubit.dart';

Widget  buildArticleItem (article,context) => InkWell(
  onTap: (){
    Navigator.push(
        context,
        MaterialPageRoute
          (builder: (context)=> WebViewScreen(url: article['url'],)));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        Container(

          width: 110,

          height: 110,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15),

            image: DecorationImage(

              image: NetworkImage(

                  '${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 15,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text('${article['publishedAt']}',

                  style: TextStyle(

                      fontSize: 16,

                      color: Colors.grey

                  ),),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

 Widget articleBuilder (list,context, {isSearch = false})=> list.length> 0 ? ListView.separated(
     physics: BouncingScrollPhysics(),
     itemBuilder: (context, index) => buildArticleItem(list[index],context),
     separatorBuilder: (context, index) => myDivider(),
     itemCount: 15) : isSearch? Container() : Center(child: CircularProgressIndicator());