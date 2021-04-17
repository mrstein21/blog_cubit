import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:equatable/equatable.dart';

abstract class DetailVideoState extends Equatable{}

class DetailVideoUnitializedState extends DetailVideoState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class DetailVideoFailedState extends DetailVideoState{
  String message;
  DetailVideoFailedState({
    this.message
  });
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class DetailVideoLoadedState extends DetailVideoState{
  Video video;
  List<VideoTags>related;
  DetailVideoLoadedState({
    this.video,
    this.related,
  });

  @override
  // TODO: implement props
  List<Object> get props => [video,related];

}