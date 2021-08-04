import 'package:flutter/material.dart';
import 'package:myprofit_employee/src/ui/drawer/drawer.dart';
import 'package:myprofit_employee/src/ui/home/home.dart';
import 'package:myprofit_employee/src/ui/driver_list/driver_list.dart';
import 'package:myprofit_employee/src/ui/performance_tracker/performance_tracker.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  // var titleList = ['Home', 'Driver List', 'Performance Tracker'];

  late List<Widget> listScreens;
  late TabController _tabController;
  int selectedTab = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_onTab);
    super.initState();

  }

  _onTab() {
    setState(() {
      selectedTab = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldkey,

        // appBar: AppBar(
        //   backgroundColor: Color.fromRGBO(102, 87, 244, 1),
        //   leading: Builder(
        //     builder: (BuildContext context){
        //       return InkWell(
        //         child: Padding(
        //           padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
        //           child: Image.asset('images/w-menu.png'),
        //         ),
        //         onTap: (){
        //           Scaffold.of(context).openDrawer();
        //         },
        //       );
        //     },
        //   ),
        //   title: Text(titleList[_tabController.index], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        //   centerTitle: true,
        //   actions: [
        //     _tabController.index == 0 ? IconButton(
        //       icon: const Icon(Icons.search_outlined),
        //       iconSize: 25,
        //       onPressed: () {},
        //     ) : Container(),
        //
        //     _tabController.index == 1 ? GestureDetector(
        //       child: Stack(
        //         children: [
        //           Container(
        //             margin: EdgeInsets.fromLTRB(0, 14, 16, 0),
        //             padding: EdgeInsets.fromLTRB(14, 7, 25, 7),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(50),
        //             ),
        //             child: Text('Add Driver', style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 12, fontWeight: FontWeight.w600)),
        //           ),
        //           Positioned(
        //             top: 9,
        //             right: 4,
        //             child: Image.asset('images/w-plus.png', width: 40),
        //           ),
        //         ],
        //       ),
        //       onTap: (){
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => DriverForm()),
        //         );
        //       },
        //     ) : Container(),
        //   ],
        // ),

        drawer: AppDrawer(),

        body: TabBarView(controller: _tabController, physics: NeverScrollableScrollPhysics(), children:  [
          Home(onTab : (){
            _scaffoldkey.currentState!.openDrawer();
          }),
          DriverList(onTab : (){
            _scaffoldkey.currentState!.openDrawer();
          }),
          PerformanceTracker(onTab : (){
            _scaffoldkey.currentState!.openDrawer();
          }),
        ]),

        bottomNavigationBar: TabBar(
          controller: _tabController,
          // indicatorWeight: 10,
          // indicatorColor: Colors.black,
          // automaticIndicatorColorAdjustment: true,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: Color.fromRGBO(102, 87, 244, 1)),
            insets: EdgeInsets.fromLTRB(30, 0, 30, 70),
          ),
          labelColor: Color.fromRGBO(102, 87, 244, 1), labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1),
          tabs: [
            Tab(
              text: 'Categories',
              icon: selectedTab == 0
                  ? Image.asset(
                      "images/f1-a.png",
                      scale: 8,
                    )
                  : Image.asset(
                      "images/f1.png",
                      scale: 8,
                    ),
            ),
            Tab(
              text: 'Survey',
              icon: selectedTab == 1
                  ? Image.asset(
                      "images/f2-a.png",
                      scale: 8,
                    )
                  : Image.asset(
                      "images/f2.png",
                      scale: 8,
                    ),
            ),
            Tab(
              text: 'Performance',
              icon: selectedTab == 2
                  ? Image.asset(
                      "images/f3-a.png",
                      scale: 8,
                    )
                  : Image.asset(
                      "images/f3.png",
                      scale: 8,
                    ),
            ),
          ],

        ),
      ),
    );
  }
}