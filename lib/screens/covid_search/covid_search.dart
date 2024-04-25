import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondera/constants/constants.dart';
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
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> fetchCovidData(String country) async {
    setState(() {
      _isLoading = true;
    });

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
          _errorMessage = '';
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
            ),
            child: const Icon(Icons.notifications),
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
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _covidDataList.isEmpty
                  ? Center(
                      child: Text(
                        _errorMessage.isNotEmpty
                            ? _errorMessage
                            : 'No data available',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: greyColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: BoldText(
                                    text: _selectedCountry.toUpperCase(),
                                    size: 17,
                                    color: blackColor),
                              ),
                            ),
                            Container(
                              height: 55,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Color.fromRGBO(186, 186, 186, 1),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BoldText(
                                      text: "Region",
                                      size: 15,
                                      color: blackColor),
                                  BoldText(
                                      text: "Total",
                                      size: 15,
                                      color: blackColor),
                                ],
                              ),
                            ),
                            Container(
                              height: 520,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: Color.fromRGBO(186, 186, 186, 1),
                                border: Border(
                                  top:
                                      BorderSide(color: whiteColor, width: 0.5),
                                  left:
                                      BorderSide(color: whiteColor, width: 0.5),
                                  right:
                                      BorderSide(color: whiteColor, width: 0.5),
                                  bottom:
                                      BorderSide(color: whiteColor, width: 0.5),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: _covidDataList.length,
                                itemBuilder: (context, index) {
                                  // Calculate the sum of total cases for the current region
                                  int totalCases = _covidDataList[index]
                                      .cases
                                      .values
                                      .map((cases) => cases['total'] ?? 0)
                                      .fold(0, (a, b) => a + b);

                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 10),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SimpleText(
                                          text: _covidDataList[index].region,
                                          size: 15,
                                          color: blackColor,
                                        ),
                                        SimpleText(
                                          text: totalCases.toString(),
                                          size: 15,
                                          color: blackColor,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
