import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/covid_search/class_data.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:http/http.dart' as http;

class CovidSearch extends StatefulWidget {
  const CovidSearch({super.key});
  static const routeName = "CovidSearch";

  static String _covidData = '';

  @override
  State<CovidSearch> createState() => _CovidSearchState();
}

class _CovidSearchState extends State<CovidSearch> {
  TextEditingController _countryController = TextEditingController();
  Future<List<CovidData>> fetchCovidData(String country) async {
    final apiKey = '2MO9GcFTUfQTPX8EaJm8RNqMY2JquGIBT21tHJX3';
    final apiUrl = 'https://api.api-ninjas.com/v1/covid19?country=$country';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData.map((data) => CovidData.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCovidData("Canada");
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
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
            ),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            //color: Colors.green,
            child: Column(
              children: [
                SearcField(
                  text: "Search",
                  countryController: _countryController,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //height: 400,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(CovidSearch._covidData),
            ),
          ),
        ],
      ),
    );
  }
}
