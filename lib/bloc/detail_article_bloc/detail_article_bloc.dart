import 'dart:convert';

import 'package:blog/bloc/detail_article_bloc/detail_article_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailArticleBloc extends Cubit<DetailArticleState>{
  DetailArticleBloc():super(DetailArticleUnitializedState());
  void getDetail(int id)async{
    try{
      emit(DetailArticleUnitializedState());
      Article article=await BlogRepository().getDetailArticle(id);
      List<String>topics_id=new List<String>();
      for(int i=0;i<article.tags.length;i++){
        topics_id.add(article.tags[i].topic_id.toString());
      }
      var body=json.encode({
        "article_id":id.toString(),
        "topic_id":topics_id
      });
      List<ArticleTags>related=await BlogRepository().getRelatedArticle(body);

      emit(DetailArticleLoadedState(article: article,related: related));
    }catch(e,track){
      print("terjadi kesalahan pada detail bloc "+e.toString());
      print("terjadi kesalahan pada detail bloc "+track.toString());
      emit(DetailArticleFailedState(message: e.toString()));
    }
  }
}