import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:rondera/widgets/texts.dart';

class DnsData {
  final String record;
  final String value;

  DnsData({required this.record, required this.value});
}

class DnsSearch extends StatefulWidget {
  static const routeName = "DnsSearch";
  const DnsSearch({Key? key}) : super(key: key);

  @override
  State<DnsSearch> createState() => _DnsSearchState();
}

class _DnsSearchState extends State<DnsSearch> {
  TextEditingController _controller = TextEditingController();
  List<DnsData> _fetchDnsDataList = [];

  Future<List<DnsData>> fetchDnsData(String record) async {
    final apiKey = '2MO9GcFTUfQTPX8EaJm8RNqMY2JquGIBT21tHJX3';
    final apiUrl = 'https://api.api-ninjas.com/v1/dnslookup?domain=$record';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<DnsData> dnsDataList = [];

      for (final data in responseData) {
        final dnsData = DnsData(
          record: data["record_type"],
          value: data.containsKey("value") ? data["value"] : data["mname"],
        );
        dnsDataList.add(dnsData);
      }

      return dnsDataList;
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
            child: Column(
              children: [
                SearcField(
                  text: "Search",
                  countryController: _controller,
                  onPressed: () async {
                    final recordName = _controller.text;
                    _controller.clear();
                    final fetchedData = await fetchDnsData(recordName);
                    setState(() {
                      _fetchDnsDataList = fetchedData;
                    });
                  },
                ),
              ],
            ),
          ),
          _fetchDnsDataList.isNotEmpty
              ? Expanded(
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
                    child: ListView.builder(
                      itemCount: _fetchDnsDataList.length,
                      itemBuilder: (context, index) {
                        final dnsData = _fetchDnsDataList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 5),
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: scaffoldColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const BoldText(
                                    text: "Record Type:",
                                    size: 15,
                                    color: whiteColor,
                                  ),
                                  Spacer(),
                                  SimpleText(
                                    text: dnsData.record,
                                    size: 15,
                                    color: whiteColor,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              Row(
                                children: [
                                  const BoldText(
                                    text: "Value:",
                                    size: 15,
                                    color: whiteColor,
                                  ),
                                  Spacer(),
                                  // SimpleText(
                                  //   text: dnsData.value,
                                  //   size: 15,
                                  //   color: whiteColor,
                                  // ),
                                  Text("${dnsData.value}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    "Please Make a research",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
        ],
      ),
    );
  }
}
