import 'package:blog/bloc/list_video_bloc/list_video_state.dart';
import 'package:blog/bloc/search_video_by_tags_bloc/search_video_by_tags_state.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:blog/resource/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVideoByTagsBloc extends Cubit<ListVideoTagsState>{
  SearchVideoByTagsBloc():super(ListVideoTagsUnitializedState());

  void searchVideo(String tags)async{
    try{
      emit(ListVideoTagsUnitializedState());
      List<VideoTags>list=await VideoRepository().searchTagsVideo(tags, 1);
      if(list.isEmpty){
        emit(ListVideoTagsEmptyState());
      }else {
        if (list.length < 10) {
          emit(ListVideoTagsLoadedState(
              video: list, isReachedEnd: true, page: 2));
        } else {
          emit(ListVideoTagsLoadedState(
              video: list, isReachedEnd: false, page: 2));
        }
      }
    }catch(e,track){
      print("kesalhan pada search result "+e.toString());
      emit(ListVideoTagsFailedState());
    }
  }

  void searchMoreVideo(String tags)async{
    ListVideoTagsLoadedState currentState = state as ListVideoTagsLoadedState;
    List<VideoTags>list=await VideoRepository().searchTagsVideo(tags,currentState.page);
    emit(list.isEmpty?currentState.copyWith(isReachedEnd: true):
    currentState.copyWith(
        page: currentState.page+1,
        video: currentState.video+list,
        isReachedEnd: false
    )
    );
  }

}