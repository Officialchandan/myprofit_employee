import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  // const AppBarWidget({ Key key }) : super(key: key);
  String title;
  final Size preferredSize;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState(this.title);

  @override
  AppBarWidget({Key? key, required this.title}) : preferredSize = Size.fromHeight(55.0);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  _AppBarWidgetState(String title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Image.asset(
          "images/back.png",
          scale: 8,
        ),
      ),
      title: Text(
        "${widget.title}",
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }
}
