import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:gestion_escom/core/config/router.dart';
import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';
import 'package:gestion_escom/ui/home/widgets/dots_indicator.dart';

class InfoCarousel extends StatefulWidget {
  const InfoCarousel({super.key});

  @override
  State<InfoCarousel> createState() => _InfoCarouselState();
}

class _InfoCarouselState extends State<InfoCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: escomNewsWithImages.map((item) {
            return InkWell(
              onTap: () {
                context.push(
                  '${Routes.home}/${Routes.carouselDetails}',
                  extra: item,
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item.imgUrl,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.category,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.author,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          // Pass the corrected controller type
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        InfoCarouselDotsIndicator(
          itemCount: escomNewsWithImages.length,
          currentIndex: _current,
          controller: _controller,
        ),
      ],
    );
  }
}
