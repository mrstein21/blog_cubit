import 'package:blog/mixins/server.dart';
import 'package:blog/model/video.dart';
import 'package:blog/model/video_tags.dart';
import 'package:blog/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelatedVideo extends StatelessWidget {
  List<VideoTags>list;
  BuildContext context;
  RelatedVideo({
    this.list,
    this.context
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: _buildListRelated(list),
    );
  }


  Widget _buildListRelated(List<VideoTags>list){
    return list.isNotEmpty?Column(
      mainAxisAlignment:MainAxisAlignment.start ,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Video terkait",style: TextStyle(fontFamily: "Roboto",fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 15,),
        Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder:(ctx,index){
                return _buildRowVideo(list[index].video);
              }),
        ),
      ],
    ):Container();
  }

  Widget _buildRowVideo(Video video) {
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
                    height: 5,
                  ),
                  Text(
                    video.created_at,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
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
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage(Server.url + video.author.avatar),
                          radius: 50,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        video.author.name,

                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 11),
                      ),
                    ],
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
