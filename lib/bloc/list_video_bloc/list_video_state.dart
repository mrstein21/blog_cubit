import 'package:blog/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class ListVideoState extends Equatable{

}


class ListVideoLoadedState extends ListVideoState{
  bool isReachedEnd=false;
  int page;
  List<Video>video;

  ListVideoLoadedState({
    this.isReachedEnd,
    this.page,
    this.video
  });

  ListVideoLoadedState copyWith({int page,bool isReachedEnd,List<Video>video})=>ListVideoLoadedState(
      video: video ?? this.video,
      isReachedEnd:isReachedEnd?? this.isReachedEnd,
      page: page ?? this.page
  );

  @override
  // TODO: implement props
  List<Object> get props => [page,isReachedEnd,video];
}

class ListVideoFailedState extends ListVideoState{
  String Message;
  ListVideoFailedState({
    this.Message
  });

  @override
  // TODO: implement props
  List<Object> get props => [Message];
}

class ListVideoUnitializedState extends ListVideoState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ListVideoEmptyState extends ListVideoState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
