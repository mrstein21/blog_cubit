import 'dart:convert';
import 'package:blog/bloc/detail_video_bloc/detail_video_state.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:blog/resource/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_video_state.dart';

class DetailVideoBloc extends Cubit<DetailVideoState>{
  DetailVideoBloc():super(DetailVideoUnitializedState());
  void getDetail(int id)async{
    try{
      emit(DetailVideoUnitializedState());
      Video video=await VideoRepository().getDetailVideo(id);
      List<String>topics_id=new List<String>();
      for(int i=0;i<video.list.length;i++){
        topics_id.add(video.list[i].topic_id.toString());
      }
      var body=json.encode({
        "video_id":id.toString(),
        "topic_id":topics_id
      });
      List<VideoTags>related=await VideoRepository().getRelatedVideo(body);

      emit(DetailVideoLoadedState(video: video,related: related));
    }catch(e,track){
      print("terjadi kesalahan pada detail bloc "+e.toString());
      print("terjadi kesalahan pada detail bloc "+track.toString());
      emit(DetailVideoFailedState(message: e.toString()));
    }
  }
}