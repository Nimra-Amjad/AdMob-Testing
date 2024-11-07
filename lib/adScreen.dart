import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({super.key});

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/1033173712";

  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: ((error) {
          interstitialAd!.dispose();
          print(error);
        }),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interstitial Ad"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (isAdLoaded) {
              interstitialAd!.show();
            }
          },
          child: const Text("Task Completed"),
        ),
      ),
    );
  }
}
