import 'package:myprofit_employee/model/drivers_monthly_response.dart';
import 'package:myprofit_employee/model/drivers_week_response.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/widget/app_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DriversWeekly extends StatefulWidget {
  const DriversWeekly({Key? key}) : super(key: key);

  @override
  _DriversWeeklyState createState() => _DriversWeeklyState();
}

class _DriversWeeklyState extends State<DriversWeekly> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  DriverWeeklyResponse? result;
  Future<DriverWeeklyResponseData> getWeeklyDriver() async {
    result = await ApiProvider().getWeeklyDrivers();
    return result!.data!;
    // log('${result!.data}');
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
        title: Text('Drivers Weekly',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<DriverWeeklyResponseData>(
              future: getWeeklyDriver(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Data Not Found"),
                  );
                }
                return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Checkbox(
                          //     value: checked,
                          //     onChanged: (check) => saleAmountBloc
                          //         .add(CheckBoxEvent(checked: check!))),
                          Text(
                            "Drivers Weekly report",
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
                            defaultColumnWidth:
                                FixedColumnWidth(deviceWidth * 0.44),
                            border: TableBorder.all(
                                color: Colors.black12,
                                style: BorderStyle.solid,
                                width: 1),
                            children: [
                              TableRow(children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: deviceWidth * 0.44,
                                          color: ColorPrimary,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("  Weekly",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 20.0,
                                                    color: Colors.white)),
                                          ))
                                    ]),
                                Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: deviceWidth * 0.44,
                                            color: ColorPrimary,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: AutoSizeText(
                                                  "  No of Drivers",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 18.0,
                                                      color: Colors.white)),
                                            ))
                                      ]),
                                ),
                              ]),
                              TableRow(children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: deviceWidth * 0.44,
                                          color: Colors.white,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: AutoSizeText(
                                              '  ${snapshot.data!.startWeek}to${snapshot.data!.endWeek}',
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  color: Colors.black),
                                              maxFontSize: 14,
                                              minFontSize: 12,
                                              maxLines: 1,
                                            ),
                                          ))
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: deviceWidth * 0.44,
                                          color: Colors.white,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                '  ${snapshot.data!.weeklyDriver}',
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0,
                                                    color: Colors.black)),
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
                                  text: "Weekly Drivers Count ",
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600)),
                              // legend: Legend(isVisible: true),
                              tooltipBehavior: _tooltipBehavior,
                              enableMultiSelection: true,

                              series: <ChartSeries>[
                                BarSeries<GDPData, String>(
                                    color: ColorPrimary,

                                    // name: '',
                                    dataSource: getChartData(snapshot.data),
                                    xValueMapper: (GDPData gdp, _) =>
                                        gdp.continent,
                                    yValueMapper: (GDPData gdp, _) => gdp.sale,
                                    //  dataLabelSettings: DataLabelSettings(isVisible: true),
                                    enableTooltip: false)
                              ],
                              primaryXAxis: CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                  labelStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                  desiredIntervals: 1),
                              primaryYAxis: NumericAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                // desiredIntervals: 6,
                                // interval: 2000,

                                //numberFormat: NumberFormat.currency(),
                                title: AxisTitle(
                                    alignment: ChartAlignment.center,
                                    text: "Weekly Drivers Count",
                                    textStyle: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade600)),
                              ),
                            ),
                          )
                        ]));
              })),
    );
    backPress() {
      Navigator.pop(context);
    }
  }

  List<GDPData> getChartData(DriverWeeklyResponseData? data) {
    final List<GDPData> chartData = [
      GDPData(
        'Weekly driver',
        double.parse(data!.weeklyDriver.toString()),
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
