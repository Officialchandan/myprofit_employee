import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee/model/drivers_day_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DriversDay extends StatefulWidget {
  const DriversDay({Key? key}) : super(key: key);

  @override
  _DriversDayState createState() => _DriversDayState();
}

class _DriversDayState extends State<DriversDay> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDailyDriver();
    //_chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  DriverDailyResponse? result;
  Future<DriverDailyResponseData> getDailyDriver() async {
    result = await ApiProvider().getDailyDrivers();
    return result!.data!;
    // log('${result!.data}');
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPrimary,
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
        title: Text('Drivers Day', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<DriverDailyResponseData>(
        future: getDailyDriver(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: ColorPrimary,
            ));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Data Not Found"),
            );
          }

          return Container(
              padding: EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Checkbox(
                //     value: checked,
                //     onChanged: (check) => saleAmountBloc
                //         .add(CheckBoxEvent(checked: check!))),
                Text(
                  "Drivers Day Report",
                  style: GoogleFonts.openSans(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: ColorPrimary,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Table(
                  defaultColumnWidth: FixedColumnWidth(deviceWidth * 0.44),
                  border: TableBorder.all(color: Colors.black12, style: BorderStyle.solid, width: 1),
                  children: [
                    TableRow(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            height: 50,
                            width: deviceWidth * 0.44,
                            color: ColorPrimary,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("  Day", style: GoogleFonts.openSans(fontSize: 20.0, color: Colors.white)),
                            ))
                      ]),
                      Container(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                              height: 50,
                              width: deviceWidth * 0.44,
                              color: ColorPrimary,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText("  No of Drivers",
                                    style: GoogleFonts.openSans(fontSize: 18.0, color: Colors.white)),
                              ))
                        ]),
                      ),
                    ]),
                    TableRow(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            height: 50,
                            width: deviceWidth * 0.44,
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('  ${snapshot.data!.today}',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.black)),
                            ))
                      ]),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            height: 50,
                            width: deviceWidth * 0.44,
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('  ${snapshot.data!.dailyDriver}',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600, fontSize: 15.0, color: Colors.black)),
                            ))
                      ]),
                    ]),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 2,
                    plotAreaBorderColor: Colors.transparent,
                    //palette: <Color>[ColorPrimary],
                    borderColor: Colors.grey.shade500,

                    title: ChartTitle(
                        text: "Daily Drivers Count ", textStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                    // legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    enableMultiSelection: true,

                    series: <ChartSeries>[
                      BarSeries<GDPData, String>(
                          color: ColorPrimary,

                          // name: '',
                          dataSource: getChartData(snapshot.data),
                          xValueMapper: (GDPData gdp, _) => gdp.continent,
                          yValueMapper: (GDPData gdp, _) => gdp.sale,
                          //  dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: false)
                    ],
                    primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        desiredIntervals: 1),
                    primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      // desiredIntervals: 6,
                      // interval: 2000,

                      //numberFormat: NumberFormat.currency(),
                      title: AxisTitle(
                          alignment: ChartAlignment.center,
                          text: "Daily Drivers Count",
                          textStyle: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                    ),
                  ),
                ),
              ]));
        },
      )),
    );
    backPress() {
      Navigator.pop(context);
    }
  }

  List<GDPData> getChartData(DriverDailyResponseData? data) {
    final List<GDPData> chartData = [
      GDPData(
        "Today",
        double.parse(data!.dailyDriver.toString()),
      ),
      GDPData(' ', 0),
      GDPData(
        "",
        0,
      ),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.sale);
  final String continent;
  final double sale;
}
