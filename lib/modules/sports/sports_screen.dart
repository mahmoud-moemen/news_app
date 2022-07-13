import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  SportsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        List<dynamic> list=NewsCubit.get(context).sports;

        return articleBuilder(list,context);
      },
    );
  }
}
