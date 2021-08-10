import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Scripts extends StatefulWidget {
  @override
  _ScriptsState createState() => _ScriptsState();
}

class _ScriptsState extends State<Scripts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: SafeArea(
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: Color.fromRGBO(102, 87, 244, 1),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 20,
                  onPressed: () {Navigator.pop(context);},
                );
              },
            ),
            title: Text('Scripts', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(55),
              child: Container(
                height: 55,
                color: Color.fromRGBO(226, 226, 226, 1),
                child: TabBar(
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  unselectedLabelColor: Color.fromRGBO(48, 48, 48, 1),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 55, color: Color.fromRGBO(102, 87, 244, 1)),
                  ),
                  tabs: [
                    Text('First'),
                    Text('Second'),
                    Text('Third'),
                  ],
                ),
              ),
            ),
          ),

          body: TabBarView(
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                children: [Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry printing and typesetting industry lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry printing and typesetting industry lorem Ipsum.', style: TextStyle(height: 1.5, color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500))],
              ),
              ListView(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                children: [Text('Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry printing and typesetting industry lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry printing and typesetting industry lorem Ipsum.', style: TextStyle(height: 1.5, color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500))],
              ),
              ListView(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                children: [Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry printing and typesetting industry lorem Ipsum.', style: TextStyle(height: 1.5, color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500))],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
