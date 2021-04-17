import 'package:blog/bloc/home_bloc/home_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/video.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:blog/resource/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState>{
  HomeBloc():super(HomeUnitializedState());
  void getAPI()async{
    try{
      emit(HomeUnitializedState());
      List<Article>list=await BlogRepository().getAllArticle(1);
      List<Video>video=await VideoRepository().getAllVideo(1);
      emit(HomeLoadedState(article: list,video: video));
    }catch(e,track){
      print("Terjadi kesalahan pada menu home bloc "+e.toString());
      print("Terjadi kesalahan pada menu home bloc "+track.toString());
      emit(HomeFailedState(message: e.toString()));
    }
  }
}