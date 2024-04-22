import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/covid_search/class_data.dart';
import 'package:rondera/widgets/texts.dart';

class CovidRegionResult extends StatelessWidget {
  final String regionName;
  final CovidData covidData;
  static String routeName = "CovidRegionResult";
  const CovidRegionResult(
      {Key? key, required this.regionName, required this.covidData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: Text(
          regionName,
          style: const TextStyle(
            color: whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10),
        decoration:const  BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: ListView.builder(
          itemCount: covidData.cases.length,
          itemBuilder: (context, index) {
            final date = covidData.cases.keys.toList()[index];
            final totalCases = covidData.cases[date]!['total'];
            final newCases = covidData.cases[date]!['new'];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SimpleText(text: "Date:", size: 15, color: whiteColor),
                      SimpleText(text: date, size: 15, color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SimpleText(text: "Total:", size: 15, color: whiteColor),
                      SimpleText(
                          text: totalCases.toString(),
                          size: 15,
                          color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SimpleText(text: "New:", size: 15, color: whiteColor),
                      SimpleText(
                          text: newCases.toString(),
                          size: 15,
                          color: Colors.red),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
