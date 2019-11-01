import 'package:flutter/material.dart';
import 'customIcons.dart';
import 'data.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

var current_page = images.length - 1.0;



class _HomePageState extends State<HomePage> {



  var current_text="";

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage:images.length,);

    controller.addListener(() {

      setState(() {

        current_page = controller.page;


      });
    });



    setState(() {

      current_text=name[current_page.round()];

    });

    return  SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF1b1e44),
                  Color(0xFF2d3447),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child:  Column(
                  children: <Widget>[

                    SizedBox(height: 30,),


                    Row(

                      children: <Widget>[
                        SizedBox(width: 15,),
                       Text("Hi",style: TextStyle(fontSize: 105,color: Colors.white,fontFamily: "Calibre-Semibold"),),
                       SizedBox(width: 30,),

                       Padding(
                         padding: const EdgeInsets.only(top:60.0),
                         child: AnimatedOpacity(opacity: 0.5, duration:
                         Duration(milliseconds: 1000),
                           curve: Curves.bounceOut,

                           child: Text(current_text,style: TextStyle(

                             color: Colors.white,
                             fontSize: 40,

                           ),),

                         ),
                       )

                      ],
                    ),


                    SizedBox(height: 50),

                    Stack(

                      children: <Widget>[
                        CardScrollWidget(current_page),
                        Positioned.fill(
                          child: PageView.builder(
                            scrollDirection: Axis.values[1],

                            pageSnapping: true,
                            itemCount: images.length,
                            controller: controller,
                            reverse: true,

                            itemBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),


            ),

        ),
      ),
    );
  }
  }


class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;
        print("width ${width}");
        print("height ${height}");

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        print("SafeWidth ${safeWidth}");
        print("SafeHeight ${safeHeight}");

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft /2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;


          print("primaryCardLeft  ${primaryCardLeft}");
          print("horizontalInset   ${horizontalInset}");
          print("i  ${i}");
          print("Current page  ${currentPage}");
          bool isOnRight = delta > 0;

          print("delta   ${delta}");

          var start = padding +  primaryCardLeft -
              horizontalInset * -delta * (isOnRight ? 25   : 0.4);
              /*max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 25   : 0.4),
                  0.0);*/


          print("Start  ${start}");

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.ltr,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.black, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(name[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(designation[current_page.round()],
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      Text("SSBD Members")
                    ],
                    
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}