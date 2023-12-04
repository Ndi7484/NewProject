import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';

class Promo {
  Promo({
    required this.promoID,
    required this.promoName,
    required this.promoShortDesc,
    required this.promoLongDesc,
    required this.maxDisc,
    required this.minTrans,
    required this.typeOrder,
    required this.menuExc,
    required this.typeExc,
    required this.freeDelivery,
    required this.maxDelivery,
    required this.typeTrans,
    required this.dateExp,
    required this.monthExp,
    required this.yearExp,
    required this.percentage,
  });
  String? promoID;
  String? promoName;
  String? promoShortDesc;
  String? promoLongDesc;
  int? maxDisc;
  int? minTrans;
  String? typeOrder;
  List<String>? menuExc;
  List<String>? typeExc;
  bool? freeDelivery;
  int? maxDelivery;
  String? typeTrans;
  int? dateExp;
  int? monthExp;
  int? yearExp;
  double? percentage;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        promoID: json['promo_id'],
        promoName: json['promo_name'],
        promoShortDesc: json['short_desc'],
        promoLongDesc: json['long_desc'],
        maxDisc: json['max_disc'],
        minTrans: json['min_trans'],
        typeOrder: json['type_order'],
        menuExc: (json['menu_except'] == 'All-Menu') ? [] : [],
        typeExc: (json['type_menu_except'] == 'All-Types') ? [] : [],
        freeDelivery: json['free_delivery'],
        maxDelivery: json['max_ongkir'],
        typeTrans: (json['transaction_type'] == 'Gopay') ? "Gopay" : '',
        dateExp: json['date_exp'],
        monthExp: json['month_exp'],
        yearExp: json['year_exp'],
        percentage: json['percentage'],
      );

  Map<String, dynamic> toJson() => {
        'promo_id': promoID,
        'promo_name': promoName,
        'short_desc': promoShortDesc,
        'long_desc': promoLongDesc,
        'max_disc': maxDisc,
        'min_trans': minTrans,
        'type_order': typeOrder,
        'menu_except': (menuExc == []) ? 'All-Menu' : menuExc,
        'type_menu_except': (typeExc == []) ? 'All-Types' : typeExc,
        'free_delivery': freeDelivery,
        'max_ongkir': maxDelivery,
        'transaction_type': typeTrans,
        'date_exp': dateExp,
        'month_exp': monthExp,
        'year_exp': yearExp,
        'percentage': percentage,
      };
}

class PromoProvider extends ChangeNotifier {
  List<Promo> _listPromo = [];
  List<Promo> get listPromo => _listPromo;
  final List<Promo> _validPromo = [];
  List<Promo> get validPromo => _validPromo;
  // load data from excel
  void readPromo() async {
    ByteData data = await rootBundle.load('assets/data/promo.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];
    _listPromo = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        // print('voucher obj');
        // print(row[9]!.value.toString());
        return Promo(
          promoID: row[0]!.value.toString(),
          promoName: row[1]!.value.toString(),
          promoShortDesc: row[2]!.value.toString(),
          promoLongDesc: row[3]!.value.toString(),
          maxDisc: int.parse(row[4]!.value.toString()),
          minTrans: int.parse(row[5]!.value.toString()),
          typeOrder: row[6]!.value.toString(),
          menuExc: row[7]!.value.toString().split(','),
          typeExc: row[8]!.value.toString().split(','),
          freeDelivery:
              (row[9]!.value.toString().toUpperCase() == 'TRUE') ? true : false,
          maxDelivery: int.parse(row[10]!.value.toString()),
          typeTrans: row[11]!.value.toString(),
          dateExp: int.parse(row[12]!.value.toString()),
          monthExp: int.parse(row[13]!.value.toString()),
          yearExp: int.parse(row[14]!.value.toString()),
          percentage: double.parse(row[15]!.value.toString()),
        );
      },
    );
    for (var el in _listPromo) {
      if (DateTime(el.yearExp!, el.monthExp!, el.dateExp!)
          .isAfter(DateTime.now())) {
        _validPromo.add(el);
      }
    }
    notifyListeners();
  }

  bool validatePromo(Promo namePromo, int cartTotals, TypeOrder? typeOrders) {
    // print('${namePromo.minTrans}--${cartTotals}');
    List<TypeOrder> tmp = [];
    if (namePromo.typeOrder == 'Delivery' || namePromo.typeOrder == 'All') {
      tmp.add(TypeOrder.delivery);
    }
    if (namePromo.typeOrder == 'Takeaway' || namePromo.typeOrder == 'All') {
      tmp.add(TypeOrder.takeaway);
    }
    if (namePromo.typeOrder == 'Dine-In' || namePromo.typeOrder == 'All') {
      tmp.add(TypeOrder.dinein);
    }
    if (namePromo.minTrans! < cartTotals &&
        tmp.contains(typeOrders ?? TypeOrder.fail)) {
      return true;
    }
    return false;
  }
}
