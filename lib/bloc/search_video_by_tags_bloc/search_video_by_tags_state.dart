import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/model/video_tags.dart';
import 'package:equatable/equatable.dart';

abstract class ListVideoTagsState extends Equatable{

}


class ListVideoTagsLoadedState extends ListVideoTagsState{
  bool isReachedEnd=false;
  int page;
  List<VideoTags>video;

  ListVideoTagsLoadedState({
    this.isReachedEnd,
    this.page,
    this.video
  });

  ListVideoTagsLoadedState copyWith({int page,bool isReachedEnd,List<VideoTags>video})=>ListVideoTagsLoadedState(
      video: video ?? this.video,
      isReachedEnd:isReachedEnd?? this.isReachedEnd,
      page: page ?? this.page
  );

  @override
  // TODO: implement props
  List<Object> get props => [page,isReachedEnd,video];
}

class ListVideoTagsFailedState extends ListVideoTagsState{
  String Message;
  ListVideoTagsFailedState({
    this.Message
  });

  @override
  // TODO: implement props
  List<Object> get props => [Message];
}

class ListVideoTagsUnitializedState extends ListVideoTagsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ListVideoTagsEmptyState extends ListVideoTagsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
