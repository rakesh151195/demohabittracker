import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphscreen extends StatefulWidget {
  //final GlobalKey<ScaffoldState> scaffoldKey;
  // ignore: prefer_typing_uninitialized_variables
  final selectedUserData;
  const Graphscreen({
    Key? key,
    required this.selectedUserData,
  }) : super(key: key);

  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  final List userdata = [];
  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 13),
    ChartData(2012, 34),
    ChartData(2013, 27),
    ChartData(2014, 40),
    ChartData(2015, 30),
    ChartData(2016, 20),
  ];
  double valueforprogressbar = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(widget.selectedUserData['Name'].toString()),
          //title: Text("Learn 5 New Words"),
          backgroundColor: Colors.black,
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                //color: Color.fromRGBO(138, 10, 250, 1.0),

                border:
                    Border.all(color: const Color.fromARGB(42, 175, 172, 177)),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
            ),
          ]),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(widget.selectedUserData['subName'].toString(),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 15)),
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 40,
              animation: true,
              lineHeight: 6.0,
              animationDuration: 2500,
              percent: widget.selectedUserData['percentage'],
              //center: Text("80.0%"),percentage
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.selectedUserData[500],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text("Strengt",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 15)),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  const Text("70 %",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 20)),
                  const Expanded(child: SizedBox()),
                  CircularPercentIndicator(
                    radius: 15.0,
                    lineWidth: 3.0,
                    animation: true,
                    percent: widget.selectedUserData['percentage'],
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: widget.selectedUserData[500],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            _drawgrap(),
          ],
        ),
      ),
    );
  }

  _drawgrap() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Repeat",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
            Expanded(child: SizedBox()),
            Text("Streak",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
            Expanded(child: SizedBox()),
            Text("Best",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Every Day",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            Expanded(child: SizedBox()),
            Text("8 days",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            Expanded(child: SizedBox()),
            Text("11 Days",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  isVisible: false, //Hide the gridlines of x-axis
                  majorGridLines: const MajorGridLines(width: 0),
                  //Hide the axis line of x-axis
                  axisLine: const AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    isVisible: false,
                    //Hide the gridlines of y-axis
                    majorGridLines: const MajorGridLines(width: 0),
                    //Hide the axis line of y-axis
                    axisLine: const AxisLine(width: 0)),
                plotAreaBorderWidth: 0,
                series: <ChartSeries>[
                  // Renders spline chart
                  SplineSeries<ChartData, int>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ])),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
