import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 300,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: FlareActor(
            "assets/no-network.flr",
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            animation: "no_netwrok",
            //controller: _teddyController,
          ),
        ),
      ),
    );
  }
}
