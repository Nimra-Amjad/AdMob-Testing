import 'package:admob_flutter/adScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? bannerAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/9214589741"; //testing ad id

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnit,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error);
          },
        ),
        request: const AdRequest());

    bannerAd!.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner Ads"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InterstitialAdPage()));
      }),
      body: const Center(
        child: Text("Nimra Amjad"),
      ),
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd!.size.height.toDouble(),
              width: bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : SizedBox(),
    );
  }
}
