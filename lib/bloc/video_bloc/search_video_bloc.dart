import 'package:blog/bloc/list_video_bloc/list_video_state.dart';
import 'package:blog/model/video.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:blog/resource/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVideoBloc extends Cubit<ListVideoState>{
  SearchVideoBloc():super(ListVideoUnitializedState());

  void searchVideo(String keyword)async{
    try{
      emit(ListVideoUnitializedState());
      List<Video>list=await VideoRepository().searchVideo(keyword, 1);
      if(list.isEmpty){
         emit(ListVideoEmptyState());
      }else {
        if (list.length < 10) {
          emit(ListVideoLoadedState(video: list, isReachedEnd: true, page: 2));
        } else {
          emit(ListVideoLoadedState(video: list, isReachedEnd: false, page: 2));
        }
      }
    }catch(e){
      emit(ListVideoFailedState());
    }
  }

  void searchMoreVideo(String keyword)async{
    ListVideoLoadedState currentState = state as ListVideoLoadedState;
    List<Video>list=await VideoRepository().searchVideo(keyword, 1);
    emit(list.isEmpty?currentState.copyWith(isReachedEnd: true):
    currentState.copyWith(
        page: currentState.page+1,
        video: currentState.video+list,
        isReachedEnd: false
    )
    );
  }

}