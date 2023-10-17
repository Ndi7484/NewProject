import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/ads_provider.dart';
import 'package:flutter_application_1/core/logic/carousel_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_application_1/core/logic/warning_provider.dart';
import 'package:flutter_application_1/core/state/ads_state.dart';
import 'package:flutter_application_1/core/widgets/button_categories.dart';
import 'package:flutter_application_1/features/profile_page/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/best_pick_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Ad? AD;
  bool alreadyAd = false;

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    final provCarousel = Provider.of<CarouselProvider>(context);
    final provWarning = Provider.of<WarningProvider>(context);
    final provPromo = Provider.of<PromoProvider>(context);
    final provPage = Provider.of<PageProvider>(context);
    final provAds = Provider.of<AdsProvider>(context);

    return ListView(
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
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
        StreamBuilder(
          stream: provCarousel.listCarousel,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error to Load Carousel : ${snapshot.hasError} ');
            } else if (snapshot.data == null) {
              return const Text('There is No Promo Today :)');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return CarouselSlider(
                  items: List.generate(
                      snapshot.data!.length,
                      (index) => Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data![index].carouselImage,
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
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.1,
                    scrollDirection: Axis.horizontal,
                  ));
            }
          },
        ),
        // green special padding
        (provPromo.validPromo.isEmpty)
            ? Container()
            : const SizedBox(
                height: 16,
              ),
        // green special voucher anouncement
        (provPromo.validPromo.isEmpty)
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.discount_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'You have ${provPromo.validPromo.length} special voucher${(provPromo.validPromo.length > 1) ? 's' : ''}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          provPage.selectedIndex = 3;
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'View',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

        const SizedBox(
          height: 16,
        ),

        // choose type orders
        ButtonCategoriesMain(),

        // warning padding
        (provWarning.getWarning != null)
            ? const SizedBox(
                height: 16,
              )
            : Container(),
        // warning alert yellow sign
        (provWarning.getWarning != null)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 11 +
                      14 * ((provWarning.getWarning!.desc.length / 47).ceil()) +
                      11,
                  decoration: BoxDecoration(
                      color: Colors.amber[100],
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 160, 157, 0)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: Icon(
                              Icons.campaign_rounded,
                              size: ((provWarning.getWarning!.desc.length / 47)
                                          .ceil() >=
                                      2)
                                  ? 25
                                  : 15,
                              color: const Color.fromARGB(255, 160, 157, 0),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: provWarning.getWarning!.desc.toString(),
                                style: const TextStyle(
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
              )
            : Container(),

        const SizedBox(
          height: 16,
        ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
        // other promotion and news of in the app
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Our best pick\'s',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,
              0, MediaQuery.of(context).size.width * 0.2, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary)),
          ),
        ),
        // best pick card
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: BestPickCard(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,
              0, MediaQuery.of(context).size.width * 0.2, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Card(
              child: FutureBuilder<AdsState>(
            future: provAds.loadApiAds(),
            builder: (context, snapshot) {
              if (snapshot.hasData && !alreadyAd) {
                alreadyAd = !alreadyAd;
                AD = snapshot.data?.ad;
              }
              // the ads is looping callback with connection waiting
              // use this to call once if nothing circular() but try build Container first
              try {
                // return the same
                return GestureDetector(
                  onTap: () async {
                    var url = AD!.redirectToUrl;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      print('Could not launch $url');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Color(
                            int.parse(
                              AD!.accent.replaceAll('#', '0xff'),
                            ),
                          )),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(9.5),
                              topRight: Radius.circular(9.5),
                            ),
                            child: Stack(
                              children: [
                                Image.network(AD!.imageUrl),
                                Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[300]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Text(
                                        'Ads Content',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 11),
                                      ),
                                    )),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                          child: Text(
                            AD!.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (AD!.content)
                                .replaceAll('<div>', '')
                                .replaceAll('</div>', '')
                                .replaceAll('<br>', '\n'),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } catch (e) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.4,
                      16,
                      MediaQuery.of(context).size.width * 0.4,
                      16),
                  child: const CircularProgressIndicator(),
                );
              }
            },
          )),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Served with ',
              style: TextStyle(color: Colors.grey),
            ),
            Icon(
              Icons.favorite,
              color: Colors.red.shade200,
              size: 18,
            ),
            const Text(
              ' by ',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              'Randumu Teams',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
        // bottom padding for floating action button
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }
}
