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
  void readCarousel() async {
    // ByteData data = await rootBundle.load('assets/data/carousel.xlsx');
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);

    // var table = excel.tables[excel.tables.keys.first];
    // _listCarousel = List.generate(
    //   table!.maxRows,
    //   (index) {
    //     var row = table.row(index);
    //     return CarouselPromo(
    //       carouselID: row[0]!.value.toString(),
    //       carouselImage: row[1]!.value.toString(),
    //     );
    //   },
    // );
    // notifyListeners();
  }
}
