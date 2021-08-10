import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myprofit_employee/src/ui/form1/form1.dart';
import 'package:myprofit_employee/utils/colors.dart';

class AddDhaba extends StatefulWidget {
  @override
  _AddDhabaState createState() => _AddDhabaState();
}

class _AddDhabaState extends State<AddDhaba> {
  var homeListText = [
    'Rosewood Hotels & Resorts',
    'Aman Resorts',
    'The Luxury Collection Hotels'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(102, 87, 244, 1),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text('Dhaba',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 35,
                        color: Colors.transparent,
                        child: FittedBox(
                          //height: 55,
                          // constraints: BoxConstraints(
                          //   minWidth: 150,
                          // ),
                          child: Container(
                            //width: 150,

                            height: 30,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.only(right: 35, left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add Dhaba',
                                style: TextStyle(
                                  color: ColorPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -5,
                        child: Image.asset('images/w-plus.png',
                            width: 40, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Form1()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          //add-dhaba-button
          child: GestureDetector(
            child: Center(
              child: Stack(
                children: [
                  Container(
                    height: 56,
                    child: FittedBox(
                      //height: 55,
                      // constraints: BoxConstraints(
                      //   minWidth: 150,
                      // ),
                      child: Container(
                        //width: 150,
                        height: 50,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(right: 65, left: 20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(102, 87, 244, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Add Dhaba ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: Image.asset('images/p-plus.png',
                        width: 80, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Form1()),
              );
            },
          ),
          //add-dhaba-button

          //dhaba-list
          // child: ListView(
          //   children: List.generate(3, (index){
          //     return GestureDetector(
          //       child: Container(
          //         padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
          //         decoration: BoxDecoration(
          //           border: Border(
          //             bottom: BorderSide(width: 1.0, color: Color(0xffcdcdcd)),
          //           ),
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             ClipRRect(
          //               borderRadius: BorderRadius.circular(5),
          //               child: Image.asset('images/recipe${index+1}.png', width: 70, height: 65, fit: BoxFit.fitHeight),
          //             ),
          //             SizedBox(width: 15),
          //
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(homeListText[index], style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
          //                 SizedBox(height: 6),
          //                 RichText(
          //                   text: TextSpan(
          //                     children: [
          //                       TextSpan(
          //                         text: 'Opening Time:\t', style: TextStyle(color: Color.fromRGBO(22, 185, 0, 1), fontSize: 13, fontWeight: FontWeight.w600),
          //                       ),
          //                       TextSpan(
          //                         text: '8:00 AM', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(height: 6),
          //                 RichText(
          //                   text: TextSpan(
          //                     children: [
          //                       TextSpan(
          //                         text: 'Closing Time:\t', style: TextStyle(color: Color.fromRGBO(232, 0, 0, 1), fontSize: 14, fontWeight: FontWeight.w600),
          //                       ),
          //                       TextSpan(
          //                         text: '9:30 PM', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w600),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       onTap: (){
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => Form1()),
          //         );
          //       },
          //     );
          //   }),
          // ),
          //dhaba-list
        ),
      ),
    );
  }
}
