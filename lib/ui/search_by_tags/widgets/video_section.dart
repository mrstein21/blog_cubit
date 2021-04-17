import 'package:blog/bloc/list_video_bloc/list_video_state.dart';
import 'package:blog/bloc/search_video_by_tags_bloc/search_video_by_tags_bloc.dart';
import 'package:blog/bloc/search_video_by_tags_bloc/search_video_by_tags_state.dart';
import 'package:blog/bloc/video_bloc/search_video_bloc.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoSection extends StatelessWidget {
  String keyword;
  VideoSection({
    this.keyword
  });
  SearchVideoByTagsBloc searchVideoBloc;
  ScrollController controller = new ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      searchVideoBloc.searchMoreVideo(keyword);
    }
  }


  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    searchVideoBloc=BlocProvider.of<SearchVideoByTagsBloc>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<SearchVideoByTagsBloc,ListVideoTagsState>(
        builder: (context,state){
          if(state is ListVideoTagsUnitializedState){
            return _buildLoading();
          }else if(state is ListVideoTagsFailedState){
            return _buildMessage();
          }else if(state is ListVideoTagsLoadedState){
            return _buildListVideoTags(state.isReachedEnd, state.video,context);
          }else{
            return _buildMessageEmpty();
          }
        },
      ),
    );
  }

  Widget _buildListVideoTags(bool isReachEnd,List<VideoTags>list,var context){
    return ListView.builder(
        controller: controller,
        itemCount: isReachEnd?list.length:list.length+1,
        itemBuilder: (ctx,index){
          if(index<list.length){
            return _buildRowVideo(list[index].video,context);
          }else{
            return _buildLoading();
          }
        });
  }

  Widget _buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
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


  Widget _buildMessageEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              "Pencarian tidak ditemukan",
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

  Widget _buildRowVideo(Video video,var context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouterGenerator.routeDetailVideo,arguments: {
          "id":video.id
        });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.play_arrow,color: Colors.black,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage("https://img.youtube.com/vi/"+video.youtube_key+"/mqdefault.jpg"),
                      fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(width: 4,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Oleh",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Roboto",fontSize: 12),),
                      SizedBox(width: 3,),
                      Text(
                        video.author.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: "Roboto",
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    video.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
