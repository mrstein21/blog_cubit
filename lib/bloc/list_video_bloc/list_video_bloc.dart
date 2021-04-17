import 'dart:math';
import 'package:blog/bloc/list_video_bloc/list_video_state.dart';
import 'package:blog/model/video.dart';
import 'package:blog/resource/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_video_state.dart';

class ListVideoBloc extends Cubit<ListVideoState>{
  ListVideoBloc():super(ListVideoUnitializedState());

  void getListVideo()async{
    if(state is ListVideoUnitializedState){
      try{
        List<Video>list=await VideoRepository().getAllVideo(1);
        if(list.length<10){
          emit(ListVideoLoadedState(video: list,isReachedEnd: true,page: 2));
        }else{
          emit(ListVideoLoadedState(video: list,isReachedEnd: false,page: 2));
        }

      }catch(e){
        print("terjadi kesalahan pada server "+e.toString());
        emit(ListVideoFailedState(Message: e.toString()));
      }
    }else{
      ListVideoLoadedState listVideoLoadedState=state as ListVideoLoadedState;
      List<Video>list=await VideoRepository().getAllVideo(listVideoLoadedState.page);
      emit(list.isEmpty?listVideoLoadedState.copyWith(isReachedEnd: true):
      listVideoLoadedState.copyWith(
          page: listVideoLoadedState.page+1,
          video: listVideoLoadedState.video+list,
          isReachedEnd: false
      )
      );
    }
  }

  bool isReachedMax(ListVideoState listVideoState){
    return listVideoState is ListVideoLoadedState && listVideoState.isReachedEnd;
  }

}