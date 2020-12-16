import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_route.dart';
import 'data.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Data args = ModalRoute.of(context).settings.arguments;

    final textStyle = TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
      color: Colors.black,
      backgroundColor: Colors.white,
    );

    Widget result = args == null? Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        child: Text(
            "Please, go next and choose something",
        style: textStyle,),
      ), 
    ) : Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        // padding: EdgeInsets.all(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  args.url != null? args.url : "https://carolelewis.hk/wp-content/uploads/2018/02/WAIT-Sign.jpg"
              )
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 32, right: 27),
          child: Text(
              args.title,
             style: textStyle,),
        ),
      ),
    );



    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome!"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    color: Colors.purple,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 7.0,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoute.second),
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: Text("Go next!"),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                result,
              ]),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Container(
          color: Colors.white,
          child: FutureBuilder<List<Widget>>(
              future: listTileWithData(context),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = snapshot.data;
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Center(
                  child: ListView(
                    children: children,
                  ),
                );
              })),
    );
  }
}

class NavigationErrorScreen extends StatelessWidget {
  final RouteSettings routeSettings;

  const NavigationErrorScreen({Key key, this.routeSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("We can`t find page ${routeSettings.name}"),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Center(
                child: Text("Ok"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<bool> showExitDialog(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you want to exit an app?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("No"),
            )
          ],
        ));
