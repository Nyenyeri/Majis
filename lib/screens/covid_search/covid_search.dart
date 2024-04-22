import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/covidRegion/region_covid_result.dart';
import 'package:rondera/screens/covid_search/class_data.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:rondera/widgets/texts.dart';

class CovidSearch extends StatefulWidget {
  const CovidSearch({Key? key}) : super(key: key);
  static String routeName = "CovidSearch";

  @override
  State<CovidSearch> createState() => _CovidSearchState();
}

class _CovidSearchState extends State<CovidSearch> {
  TextEditingController _countryController = TextEditingController();
  List<CovidData> _covidDataList = [];

  Future<void> fetchCovidData(String country) async {
    final apiKey = '2MO9GcFTUfQTPX8EaJm8RNqMY2JquGIBT21tHJX3';
    final apiUrl = 'https://api.api-ninjas.com/v1/covid19?country=$country';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        final covidDataList =
            jsonData.map((data) => CovidData.fromJson(data)).toList();
        setState(() {
          _covidDataList = covidDataList;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
String _selectedCountry = "";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        title: const Text(
          "COVID-19",
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomePage.routeName);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        actions: [
          Container(
            margin:const  EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
            ),
            child:const  Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Column(
              children: [
                SearcField(
                  text: "Search",
                  countryController: _countryController,
                  onPressed: () async {
                    _selectedCountry = _countryController.text;
                    _countryController.clear();
                    await fetchCovidData(_selectedCountry);
                  },
                ),
              ],
            ),
          ),
          
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 75),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BoldText(text: "Country:", size: 15, color: blackColor),
                SimpleText(
                  text: _selectedCountry.toUpperCase(),
                  size: 17,
                  color: blackColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: _covidDataList.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: _covidDataList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CovidRegionResult(
                                  regionName: _covidDataList[index].region,
                                  covidData: _covidDataList[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            decoration: BoxDecoration(
                              color: scaffoldColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SimpleText(
                                  text: _covidDataList[index].region,
                                  size: 16,
                                  color: whiteColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Text(
                    "Please, Make a research",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
