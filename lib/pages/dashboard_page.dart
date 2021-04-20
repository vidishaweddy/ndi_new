import 'package:flutter/material.dart';
import 'package:ndi_new/models/user.dart';
import 'package:ndi_new/pages/drawer_page.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class DashBoardPage extends StatefulWidget {
  final User? user;

  DashBoardPage({Key? key, this.user}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState(user: user);
}

class _DashBoardState extends State<DashBoardPage> {
  final User? user;
  final _advancedDrawerController = AdvancedDrawerController();

  _DashBoardState({this.user});

  @override
  Widget build(BuildContext context) {
    AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: SizedBox(),
      drawer: SizedBox(),
    );

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text('Dashboard'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible != null && value.visible!
                      ? Icons.clear
                      : Icons.menu,
                );
              },
            ),
          ),
        ),
        body: dashboardBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
        ),
      ),
      drawer: DrawerPage(user: user),
    );
  }

  Widget dashboardBody() {
    return ListView(children: [
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: <Widget>[
              Icon(
                Icons.supervised_user_circle,
                size: 100,
              ),
              SizedBox(width: 15),
              Text("ID Card",
                  style: TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold))
            ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: <Widget>[
              Icon(
                Icons.car_rental_outlined,
                size: 100,
              ),
              SizedBox(width: 15),
              Text("Driving License",
                  style: TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold))
            ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: <Widget>[
              Icon(
                Icons.school_outlined,
                size: 100,
              ),
              SizedBox(width: 15),
              Text("University ID",
                  style: TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold))
            ]),
          ),
        ],
      ),
    ]);
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
