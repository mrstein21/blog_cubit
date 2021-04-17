import 'package:blog/bloc/detail_video_bloc/detail_video_bloc.dart';
import 'package:blog/bloc/detail_video_bloc/detail_video_state.dart';
import 'package:blog/mixins/server.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/routes.dart';
import 'package:blog/ui/detail_video/detail_video_page_state.dart';
import 'package:blog/ui/detail_video/widget/related_video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailVideoPage extends StatefulWidget {
  int id;
  DetailVideoPage({
    this.id
  });
  @override
  _DetailVideoPageState createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends DetailVideoPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: BlocBuilder<DetailVideoBloc,DetailVideoState>(
          builder: (context,state){
            if(state is DetailVideoFailedState){
              return _buildMessage();
            }else if(state is DetailVideoUnitializedState){
              return _buildLoading();
            }else if(state is DetailVideoLoadedState){
              return _buildUI(state.video, state.related);
            }
          },
        )
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 6,
          ),
          Text(
            "Loading..",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_cellular_connected_no_internet_4_bar,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              "Can't Connect to Server",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildYoutubeVideo(String url){
    controller= YoutubePlayerController(
        initialVideoId: url,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        )
    );
    return YoutubePlayer(
      controller: controller,
      bottomActions: [
        const SizedBox(width: 14.0),
        CurrentPosition(),
        const SizedBox(width: 8.0),
        ProgressBar(
          isExpanded: true,
        ),
        RemainingDuration(),
        InkWell(
          onTap: (){
            controller.pause();
            Navigator.pushNamed(context,RouterGenerator.routeFullYoutube,arguments: {
              "url": url
            });
          },
          child: Icon(Icons.fullscreen,color: Colors.white,size: 20,),
        ),

      ],
    );
  }

  Widget _buildUI(Video video,List<VideoTags>related){
    return ListView(
      children: [
        _buildYoutubeVideo(video.youtube_key),
        SizedBox(height: 4,),
        _buildDescription(video),
        SizedBox(height: 5,),
        RelatedVideo(list: related,context: context,)
      ],
    );

  }

  Widget _buildDescription(Video video){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.title,style: TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
          SizedBox(height: 7,),
          Text(video.created_at,style: TextStyle(fontSize:13,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
          SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 25,
                child: CircleAvatar(
                  backgroundImage:
                  NetworkImage(Server.url + video.author.avatar),
                  radius: 50,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                video.author.name,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 8,),
          _buildTags(video.list),
          SizedBox(height: 5,),
          Text(
            video.description,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 13),
          ),
        ],
      ),
    );
  }


  Widget _buildTags(List<VideoTags> tags){
    return Wrap(
      children: tags.map<Widget>((e){
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, RouterGenerator.routeSearchByTags,
            arguments: {
              "tags":e.topic_id.toString(),
              "tags_name":e.topic.topic_name
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 4),
            padding: EdgeInsets.all(3),
            child: Text(e.topic.topic_name,style: TextStyle(fontSize: 12,fontFamily: "Roboto",color: Colors.white,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.black)
            ),
          ),
        );
      }).toList(),
    );
  }


}
