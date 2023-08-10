import 'package:covid/View/worldstatescreen.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalrecovered,  active, critical, todayrecovered, test;

   DetailScreen({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalrecovered,
     required this.active,
     required this.critical,
     required this.todayrecovered,
     required this.test,
     Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height *.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *.06,
                      ),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString() ),
                      ReusableRow(title: 'Recovered', value: widget.totalrecovered.toString() ),
                      ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString() ),
                      ReusableRow(title: 'Critical', value: widget.critical.toString() ),
                      ReusableRow(title: 'Active', value: widget.active.toString() ),
                      ReusableRow(title: 'Today recovered', value: widget.todayrecovered.toString() ),
                      ReusableRow(title: 'Cases', value: widget.test.toString() ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }

}
