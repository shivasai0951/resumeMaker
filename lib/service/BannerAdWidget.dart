import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    bannerAd = BannerAd(
      adUnitId:'ca-app-pub-2574761528356984/5758778073', // ✅ test ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() => isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint("Banner failed: $error");
        },
      ),
    );

    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) return const SizedBox();

    return SizedBox(
      height: bannerAd!.size.height.toDouble(),
      width: bannerAd!.size.width.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}