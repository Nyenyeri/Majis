import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/covid_search/covid_search.dart';
import 'package:rondera/screens/dns/dns_search.dart';
import 'package:rondera/screens/phone_check/phone_check.dart';
import 'package:rondera/widgets/main_icon.dart';
import 'package:rondera/widgets/texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> topics = ["DNS", "COVID-19", "Phone Nb"];
  List<Widget> pages = const [DnsSearch(), CovidSearch(), PhoneCheck()];

  int selected_index = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MainIcon(
                imagePath: "assets/rondera.png",
                width: 100,
                color: whiteColor,
              ),
              SizedBox(
                height: defaultPadding * 2,
              ),
              BoldText(text: "Select a topic: ", size: 18, color: whiteColor),
              Container(
                margin: EdgeInsets.only(left: 20, top: 30),
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_index = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => pages[index],
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: 90,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 10, top: 5),
                        decoration: BoxDecoration(
                          color: selected_index == index
                              ? Colors.green
                              : whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            topics[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
