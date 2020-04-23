//import 'package:flutter/material.dart';
//
//class AllBookCard extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _AllBookCardState();
//  }
//}
//
//class _AllBookCardState extends State<AllBookCard> {
//  static var we;
//
//  @override
//  Widget build(BuildContext context) {
//    var w = MediaQuery.of(context).size;
//    we = w * 5;
//
//    // TODO: implement build
//    return Card(
//      child:
////        ListTile(
////      leading:
////          ClipRect(child: Image(image: AssetImage("assets/images/img1.jpg"))),
////      title: Text("Hello"),
////    )
//          Stack(
//        children: <Widget>[cardimg, textcard],
//      ),
//    );
//  }
//
//  final cardimg = Container(
//      margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 250.0),
//      alignment: Alignment.centerLeft,
//      // color: Colors.red,
//      child: ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(20.0)),
//        child: Image(
//          //color: Colors.orange,
//          fit: BoxFit.fill,
//          image: AssetImage("assets/images/img1.jpg"),
//          height: 130.0,
//          //  width: 70.0,
//        ),
//      ));
//  final textcard = Container(
//    height: 120.0,
//    alignment: Alignment.topCenter,
//    margin: EdgeInsets.only(left: 00.0, top: 16.0),
//    child: Text(
//      "Mars",
//      //textAlign: TextAlign.center,
//      style: TextStyle(color: Colors.grey, fontSize: 25.0),
//    ),
//  );
//}
//
//
//Card(
////  margin: EdgeInsets.all(10.0),
//child: Padding(
//padding: EdgeInsets.symmetric(vertical: 3.0),
//child: ListTile(
//leading: ClipRRect(
//borderRadius: BorderRadius.all(Radius.circular(5)),
//child: Image(
//image: AssetImage("assets/images/img1.jpg"),
//fit: BoxFit.fill,
//),
//),
//title: Text("name"),
//subtitle: Text("sub"),
//onTap: () {},
//),
//),
//)
