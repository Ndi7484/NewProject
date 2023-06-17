import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarouselPromo {
  CarouselPromo({
    required this.carouselID,
    required this.carouselImage,
  });
  String carouselID;
  String carouselImage;
}

class CarouselProvider extends ChangeNotifier {
  List<CarouselPromo> _listCarousel = [];
  List<CarouselPromo> get listCarousel => _listCarousel;
  void readCarousel() async {
    ByteData data = await rootBundle.load('assets/data/carousel.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];
    _listCarousel = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return CarouselPromo(
          carouselID: row[0]!.value.toString(),
          carouselImage: row[1]!.value.toString(),
        );
      },
    );
    notifyListeners();
  }
}
