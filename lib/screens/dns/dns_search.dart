import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/dns/widgets/dns_data.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:rondera/widgets/texts.dart';

class DnsSearch extends StatefulWidget {
  static const routeName = "DnsSearch";
  const DnsSearch({Key? key}) : super(key: key);

  @override
  State<DnsSearch> createState() => _DnsSearchState();
}

class _DnsSearchState extends State<DnsSearch> {
  TextEditingController _controller = TextEditingController();
  List<DnsData> _fetchDnsDataList = [];
  bool _isLoading = false;
  String _errorMessage = '';
  bool _hasSearched = false;

  Future<void> fetchDnsData(String record) async {
    setState(() {
      _isLoading = true;
    });

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
        );
        dnsDataList.add(dnsData);
      }

      setState(() {
        _fetchDnsDataList = dnsDataList;
        _isLoading = false;
        _errorMessage = '';
        _hasSearched = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data';
        _hasSearched = true;
      });
    }
  }

  String _siteSearch = "";

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
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                SearcField(
                  text: "Search",
                  countryController: _controller,
                  onPressed: () async {
                    _siteSearch = _controller.text;
                    _controller.clear();
                    await fetchDnsData(_siteSearch);
                  },
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : !_hasSearched
                  ? const Text(
                      "Make a research please",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    )
                  : _errorMessage.isNotEmpty
                      ? Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 430,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                decoration: const BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const BoldText(
                                        text: "Site:",
                                        size: 15,
                                        color: blackColor),
                                    BoldText(
                                        text: _siteSearch,
                                        size: 15,
                                        color: blackColor),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: defaultPadding * 2,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: defaultPadding,
                                      ),
                                      const Center(
                                          child: BoldText(
                                              text: "DNS List",
                                              size: 17,
                                              color: blackColor)),
                                      const SizedBox(
                                        height: defaultPadding,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: greyColor,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: ListView.builder(
                                            itemCount: _fetchDnsDataList.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    child: Text(
                                                        _fetchDnsDataList[index]
                                                            .record),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
        ],
      ),
    );
  }
}
