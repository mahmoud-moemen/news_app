
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/wb_view_sceen.dart';

Widget buildArticleItem(article,context)=>InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0),
  
            image:DecorationImage(
  
              image:NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ) ,
  
          ),
  
        ),
  
        SizedBox(width: 20.0),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    //text style theme ll app kolo
  
                    style:Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);


 Widget articleBuilder(list, context , {isSearch=false})=>ConditionalBuilder(
   //state is! NewsGetBusinessLoadingState momkn yb2a condition
   condition: list.length>0,
   builder: (context)=> ListView.separated(
     // physics de 34an a5ly al listView t scroll l t7t syka
     physics: BouncingScrollPhysics(),
     itemBuilder: (context,index)=> buildArticleItem(list[index],context),
     separatorBuilder: (context,index)=>Padding(
       padding: const EdgeInsetsDirectional.only(
         start: 20.0,
       ),
       child: Container(
         width: double.infinity,
         height: 1.0,
         color: Colors.grey[300],
       ),
     ),
     itemCount: 10,),
   fallback:(context)=>isSearch ? Container() :Center(child: CircularProgressIndicator()),
 );




void navigateTo(context , Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (Context)=>Widget,
  ),
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  Function(String)? onSubmitted,
  Function(String)? onChanged,
  VoidCallback? onTap,

  //required String Function(String?) validate ,
  required String? Function(String? val)? validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable=true,


}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmitted,
  onChanged:onChanged,
  onTap:onTap ,
  enabled:isClickable ,
  validator:validator,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ), //icon in the start
    suffixIcon:suffix !=null ? IconButton(
      onPressed:suffixPressed ,
      icon : Icon(
        suffix,
      ),
    ):null, //icon in the start
    border: OutlineInputBorder(),
  ),
);


