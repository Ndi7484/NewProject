import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/carousel_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    final provCarousel = Provider.of<CarouselProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${provAccount.currentHour}, ${provAccount.selectedAccount!.firstName}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Welcome to Randumu Cafe',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/etc/Profile.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(),
        CarouselSlider(
            items: List.generate(
                provCarousel.listCarousel.length,
                (index) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        provCarousel.listCarousel[index].carouselImage,
                        fit: BoxFit.fill,
                      ),
                    ))),
            options: CarouselOptions(
              height: 180,
              aspectRatio: 17 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.1,
              scrollDirection: Axis.horizontal,
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text(
              "Let's Order",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // warning alert yellow sign
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 12 + 15 + 15 + 12,
          decoration: BoxDecoration(
              color: Colors.amber[100], borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.campaign_rounded,
                      size: 13,
                      color: Color.fromARGB(255, 160, 157, 0),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text:
                            "This message is made a warning for all Randumu customers This message is made a warning for all Randumu customers",
                        style: TextStyle(
                          color: Color.fromARGB(255, 160, 157, 0),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
