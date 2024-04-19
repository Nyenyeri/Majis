import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/dns/widgets/dns_data.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:rondera/widgets/texts.dart';

class DnsSearch extends StatefulWidget {
  static const routeName = "DnsSearch";
  const DnsSearch({super.key});

  @override
  State<DnsSearch> createState() => _DnsSearchState();
}

class _DnsSearchState extends State<DnsSearch> {
  TextEditingController _controller = TextEditingController();
  int countData = 0;

  Future<DnsData> fetchPhoneData(String record) async {
    //print(record);
    final apiKey = '2MO9GcFTUfQTPX8EaJm8RNqMY2JquGIBT21tHJX3';
    final apiUrl = 'https://api.api-ninjas.com/v1/dnslookup?domain=$record';
    //print("API: ${apiUrl}");

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //countData = data.length;
      // print(response.body);
      // print("data: ${data}");
      return DnsData(
        record: record,
        value: data["value"],
      );
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        title: const Text(
          "DNS - CHECK",
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomePage.routeName);
          },
          icon: Icon(
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
                  countryController: _controller,
                  onPressed: () async {
                    final country = _controller.text;
                    await fetchPhoneData(country);
                  },
                ),
              ],
            ),
          ),
          FutureBuilder<DnsData>(
            future: fetchPhoneData(_controller.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                final dnsPointer = snapshot.data!;
                return Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: ListView.builder(
                        itemCount: countData,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              padding: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: scaffoldColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      BoldText(
                                        text: "Record",
                                        size: 15,
                                        color: whiteColor,
                                      ),
                                      Spacer(),
                                      SimpleText(
                                        text: dnsPointer.record,
                                        size: 15,
                                        color: whiteColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BoldText(
                                        text: "Value",
                                        size: 15,
                                        color: whiteColor,
                                      ),
                                      Spacer(),
                                      SimpleText(
                                        text: dnsPointer.value,
                                        size: 15,
                                        color: whiteColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
