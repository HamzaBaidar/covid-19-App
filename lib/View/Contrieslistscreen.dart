import 'package:covid/Services/States_Services.dart';
import 'package:covid/View/Detail_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices= StateServices();
    return Scaffold(
appBar: AppBar(
elevation: 0,
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  automaticallyImplyLeading: false,
  actions: [
   IconButton(onPressed: (){
     Navigator.pop(context);
   }, icon: const Icon(Icons.arrow_back_ios_new_sharp))
  ],
),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search With Country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future:  stateServices.CountriesListApi(),
                  builder: (context,snapshot){
                    if(!snapshot.hasData){
                       return ListView.builder(
                          itemCount: 9,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading:  Container(
                                       height: 50, width: 89, color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10, width: 89, color: Colors.white,
                                    ),
                                    subtitle:Container(
                                      height: 10, width: 89, color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );

                          });
                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            String name= snapshot.data![index]['country'];
                            if(searchcontroller.text.isEmpty) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths:snapshot.data![index]['deaths'],
                                      totalrecovered: snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['tests'],
                                      todayrecovered: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['critical'])));
                                },
                                child: SizedBox(
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                ),
                              );
                            }
                              else if (name.toLowerCase().contains(searchcontroller.text.toLowerCase())) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths:snapshot.data![index]['deaths'],
                                      totalrecovered: snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['tests'],
                                      todayrecovered: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['critical'])));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                ),
                              );
                            }
                            else{
                         return Container();
                              }
                            

                          });
                    }


              }),
            ),
          ],
        ),
      ),
    );
  }
}
