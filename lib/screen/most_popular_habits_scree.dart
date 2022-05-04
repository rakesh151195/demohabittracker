import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:demohabittracker/screen/details_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  // final GlobalKey<ScaffoldState> scaffoldKey;
  final User user;

  const ProfilePage({
    required this.user,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool changecolor = false;
  final DatePickerController _controller = DatePickerController();

  final List namelitems = [
    {
      "Name": "YP",
      "subName": "Yoga Practice",
      500: const Color.fromRGBO(39, 170, 245, 0.8)
    },
    {
      "Name": "GE",
      "subName": "Get Up Early",
      500: const Color.fromRGBO(235, 64, 91, 0.8)
    },
    {
      "Name": "NS",
      "subName": "No suggestion",
      500: const Color.fromRGBO(64, 187, 169, 0.8)
    },
  ];
  List yourhabit = [
    {
      "Name": "Learn 5 new words",
      "subName": "5 from 7 this week",
      500: const Color.fromRGBO(39, 170, 245, 0.8),
      "percentage": 0.8
    },
    {
      "Name": "Get up early",
      "subName": "5 from 7 this week",
      500: const Color.fromRGBO(235, 64, 91, 0.8),
      "percentage": 0.4
    },
    {
      "Name": "Create an App a day",
      "subName": "6 from 7 this week",
      500: const Color.fromRGBO(64, 187, 169, 0.8),
      "percentage": 0.5
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          title: const Text('Most Popular Habits'),
          backgroundColor: Colors.black,
          actions: <Widget>[
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(138, 10, 250, 1.0),

                //border: Border.all(color: Color.fromRGBO(138, 10, 250, 1.0)),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
            ),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // childAspectRatio: (1 / .4),
                  ),
                  itemCount: namelitems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _habitcard(index, namelitems);
                  }),
            ),
            _datepicker(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Your habits",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "5",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: yourhabit.length,
                  itemBuilder: (context, index) {
                    return _yourhabitlistview(index, yourhabit);
                  }),
            )
            // Text(
            //   'NAME: ${_currentUser.displayName}',
            //   style: Theme.of(context).textTheme.bodyText1,
            // ),
          ],
        ),
      ),
    );
  }

  _habitcard(int index, namelitems) {
    return Card(
      color: namelitems[index][500],
      elevation: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            // margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          // widget.selectedAppointment.organizer?.name ?? "",
                          namelitems[index]['Name'].toString(),
                          // "YP",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          //widget.selectedAppointment.organizer?.address ?? "",
                          namelitems[index]['subName'].toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _datepicker() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      //padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(),
          color: const Color.fromRGBO(67, 63, 65, 0.8),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      //margin: const EdgeInsets.all(10),
      // color: Colors.blueGrey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color.fromRGBO(138, 10, 250, 1.0),
              selectedTextColor: Colors.white,
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                // New date selected
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _yourhabitlistview(int index, yourhabit) {
    return GestureDetector(
      onTap: () {
        print("index selected ");
        // changecolor = ;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Graphscreen(
              // scaffoldKey: widget.scaffoldKey,
              selectedUserData: yourhabit[index],
            ),
          ),
        );
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          // changecolor  ?
                          const Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                          // : Icon(
                          //     Icons.check_circle,
                          //     color: Colors.green,
                          //     size: 30.0,
                          //   ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  // widget.selectedAppointment.organizer?.name ?? "",
                                  yourhabit[index]['Name'].toString(),
                                  // "YP",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(yourhabit[index]['subName'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 40,
                      animation: true,
                      lineHeight: 6.0,

                      animationDuration: 2500,
                      percent: yourhabit[index]['percentage'],

                      //center: Text("80.0%"),percentage
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: yourhabit[index][500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
