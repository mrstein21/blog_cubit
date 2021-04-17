import 'package:blog/bloc/home_bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

abstract class HomePageState extends State<HomePage>{
  HomeBloc homeBloc;
  var scaffoldState=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    homeBloc=BlocProvider.of<HomeBloc>(context);
    homeBloc.getAPI();
  }
}