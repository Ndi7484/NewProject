import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselPromo {
  CarouselPromo({
    required this.carouselID,
    required this.carouselImage,
  });
  String carouselID;
  String carouselImage;

  Map<String, dynamic> toJson() => {
        'carousel_code': carouselID,
        'image': carouselImage,
      };

  static CarouselPromo fromJson(Map<String, dynamic> json) => CarouselPromo(
        carouselID: json['carousel_code'],
        carouselImage: json['image'],
      );
}

class CarouselProvider extends ChangeNotifier {
  final Stream<List<CarouselPromo>> listCarousel = FirebaseFirestore.instance
      .collection('carousel')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CarouselPromo.fromJson(doc.data()))
          .toList());
  // List<CarouselPromo> get listCarousel => _listCarousel;
  
}
