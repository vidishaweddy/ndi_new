import 'package:flutter/material.dart';
import 'package:ndi_new/models/user.dart';
import 'package:ndi_new/pages/drawer_page.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class ServicePage extends StatefulWidget {
  final User? user;

  ServicePage({Key? key, this.user}) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState(user: user);
}

class _ServiceState extends State<ServicePage> {
  final User? user;
  final _advancedDrawerController = AdvancedDrawerController();

  _ServiceState({this.user});

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
          title: const Text('Services'),
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
        body: serviceBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
        ),
      ),
      drawer: DrawerPage(user: user),
    );
  }

  Widget serviceBody() {
    return ListView(
        children: [
          Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                          children: <Widget>[
                            Icon(Icons.supervised_user_circle, size: 25,),
                            SizedBox(width: 5),
                            Text("Service 1", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
                          ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                          children: <Widget>[
                            Icon(Icons.car_rental_outlined, size: 25, ),
                            SizedBox(width: 5),
                            Text("Service 2", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
                          ]
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ]
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}