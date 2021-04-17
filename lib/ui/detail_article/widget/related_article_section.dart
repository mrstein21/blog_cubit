import 'package:blog/mixins/server.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:blog/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelatedArticleSection extends StatelessWidget {
  List<ArticleTags>list;
  BuildContext context;
  RelatedArticleSection({
    this.list,
    this.context
   });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildListRelated(list),
    );
  }

  Widget _buildListRelated(List<ArticleTags>list){
    return list.isNotEmpty?Column(
      mainAxisAlignment:MainAxisAlignment.start ,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Artikel terkait",style: TextStyle(fontFamily: "Roboto",fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 15,),
        Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing:20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.8,
                crossAxisCount: 2),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
               itemCount: list.length,
              itemBuilder:(ctx,index){
                 return _buildRow(list[index].article);
              }),
        ),
      ],
    ):Container();
  }

  Widget _buildRow(Article article){
    return GestureDetector(
     onTap: (){
       Navigator.pushNamed(context, RouterGenerator.routeDetailArticle,arguments: {
         "id":article.id
       });
     },
      child: Container(
        width: 170,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Server.url+article.image,)
                  )
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title,style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Oleh",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        article.author.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(article.short_description,style: TextStyle(fontFamily: "Roboto",fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }


}
