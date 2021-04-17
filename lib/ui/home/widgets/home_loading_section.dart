import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Video",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          _buildListVideoEmpty(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Latest Article",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 18),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Text(
                  "More",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          _buildListArticleEmpty()
        ],
      ),
    );
  }

  Widget _buildListVideoEmpty() {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(5),
                height: 150,
                width: 280,
              ),
            );
          }),
    );
  }

  Widget _buildListArticleEmpty() {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(5),
              height: 200,
            ),
          );
        });
  }
}
