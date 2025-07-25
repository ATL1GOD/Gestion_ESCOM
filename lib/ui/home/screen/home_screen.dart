import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel_slide.dart';
//info_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InfoCarousel());
  }
}
