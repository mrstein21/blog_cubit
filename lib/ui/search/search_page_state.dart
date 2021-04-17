import 'package:blog/model/topic.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:blog/ui/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class SearchPageState extends State<SearchPage>{
  List<Topic>list=[];
  var scaffoldState=new GlobalKey<ScaffoldState>();
  TextEditingController searchQueryController = new TextEditingController();

  void initAPI()async{
    list=await BlogRepository().getTopic();
    setState(() {
      list=list;
    });
  }

  @override
  void initState() {
    this.initAPI();
    super.initState();
  }

}