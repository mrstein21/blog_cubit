import 'package:blog/bloc/list_video_bloc/list_video_bloc.dart';
import 'package:blog/ui/list_video/list_video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListVideoPageState extends State<ListVideoPage>{
  ScrollController controller = new ScrollController();
  ListVideoBloc listVideoBloc;
  @override
  void initState() {
    listVideoBloc=BlocProvider.of<ListVideoBloc>(context);
    listVideoBloc.getListVideo();
    // TODO: implement initState
    super.initState();
  }

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      listVideoBloc.getListVideo();
    }
  }

}