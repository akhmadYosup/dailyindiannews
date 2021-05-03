import 'package:dailyindiannews/helper/news.dart';
import 'package:dailyindiannews/models/article_model.dart';
import 'package:dailyindiannews/views/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();

  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      /// APPBAR

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[

            Text("Daily", style: TextStyle(
                color: Colors.white54
            ),),
            Text("Indian", style: TextStyle(
                color: Colors.cyan
            ),),
            Text("News", style: TextStyle(
                color: Colors.amber
            ),)
          ],

        ),
        elevation: 0.0,
      ),

      ///END OF APPBAR


     body: _loading ?Center(
       child: Container(
         child: CircularProgressIndicator(),
       ),
     ): SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.symmetric(horizontal: 4),
         child: Column(
           children: <Widget>[


             ///BLOGS
             Container(
               padding: EdgeInsets.only(top: 16),
               child: ListView.builder(
                 shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                   itemCount: articles.length,
                   itemBuilder: (context, index){
                     return BlogTile(
                         imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                       desc:  articles[index].description,
                       url: articles[index].url,
                     );
                   }),
             )
           ],
         ),
       ),
     ),
    );
  }
}


class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl, this.title, this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (contex) => ArticleView(
              blogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            Image.network(imageUrl),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}



