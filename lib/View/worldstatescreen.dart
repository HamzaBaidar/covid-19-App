import 'package:covid/Services/States_Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/World_States_Model.dart';
import 'Contrieslistscreen.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorlist =<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateservice = StateServices();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *.01,),
            FutureBuilder(
                future: stateservice.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                    );
                  }
                  else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap:{
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths" :double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/ 2.7,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: const Duration(milliseconds: 1200 ) ,
                          chartType: ChartType.ring,
                          colorList: colorlist,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06,horizontal: 13),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),


                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));

                  },
                          child: Container(
                            // padding: EdgeInsets.only(left: 10,right: 20),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff1aa260)
                            ),
                            child: const Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                }),

          ],
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,),
              Text(value,),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          const Divider(
          height: 13,
          ),
        ],
      ),
    );
  }
}

