import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/screens/phone_check/widgets/phoneData.dart';
import 'package:rondera/screens/phone_check/widgets/phoneInfo.dart';
import 'package:rondera/widgets/search_field.dart';
import 'package:rondera/widgets/texts.dart';

class PhoneCheck extends StatefulWidget {
  const PhoneCheck({Key? key}) : super(key: key);
  static const routeName = "PhoneCheck";

  @override
  State<PhoneCheck> createState() => _PhoneCheckState();
}

class _PhoneCheckState extends State<PhoneCheck> {
  TextEditingController _phoneController = TextEditingController();
  late PhoneData _fetchedData;

  _PhoneCheckState() {
    _fetchedData = PhoneData(
      country: "",
      location: "",
      validate: false,
      code: 0,
    );
  }

  Future<PhoneData> fetchPhoneData(String phone) async {
    final apiKey = '2MO9GcFTUfQTPX8EaJm8RNqMY2JquGIBT21tHJX3';
    final apiUrl = 'https://api.api-ninjas.com/v1/validatephone?number=$phone';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PhoneData(
        country: data["country"],
        location: data["location"],
        validate: data["is_valid"],
        code: data["country_code"],
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
          "Check Phone",
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
            child: Column(
              children: [
                SearcField(
                  text: "Enter number",
                  countryController: _phoneController,
                  onPressed: () async {
                    final phone = _phoneController.text;
                    _phoneController.clear();
                    final fetchedData = await fetchPhoneData(phone);
                    setState(() {
                      _fetchedData = fetchedData;
                    });
                  },
                ),
                SizedBox(height: 20),
                _fetchedData.country.isNotEmpty
                    ? Container(
                        height: 550,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: defaultPadding * 2),
                            const BoldText(
                              text: "Phone Info",
                              size: 25,
                              color: blackColor,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PhoneInfo(
                                  textAPI: "Is Valid:",
                                  textPhone: _fetchedData.validate.toString(),
                                  color: Colors.blue,
                                  width: 150,
                                  height: 100,
                                ),
                                PhoneInfo(
                                  textAPI: "Location:",
                                  textPhone: _fetchedData.location,
                                  color: Colors.blue,
                                  width: 150,
                                  height: 100,
                                ),
                              ],
                            ),
                            PhoneInfo(
                              textAPI: "Country Code:",
                              textPhone: _fetchedData.code.toString(),
                              color: Colors.green,
                              width: 250,
                              height: 100,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PhoneInfo(
                                  textAPI: "Country:",
                                  textPhone: _fetchedData.country,
                                  color: Colors.blue,
                                  width: 150,
                                  height: 100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Please, Make a search",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
