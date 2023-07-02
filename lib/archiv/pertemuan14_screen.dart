// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class Pertemuan14Screen extends StatefulWidget {
//   const Pertemuan14Screen({super.key});

//   @override
//   State<Pertemuan14Screen> createState() => _Pertemuan14ScreenState();
// }

// class _Pertemuan14ScreenState extends State<Pertemuan14Screen> {
//   DateTime _date = DateTime.now();
//   TextEditingController? _time;
//   // dot make final so the range is still selectable not shrinking range
//   // ignore: prefer_final_fields
//   DateTimeRange _dateRange = DateTimeRange(
//     start: DateTime(2023, 1, 1),
//     end: DateTime.now(),
//   );
//   List<DateTime> _multiDate = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pertemuan 14'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: ListView(
//           children: [
//             // DatePicker
//             Row(
//               children: [
//                 const Text('Tanggal :'),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: InputDatePickerFormField(
//                   initialDate: _date,
//                   firstDate: DateTime(1990),
//                   lastDate: DateTime(2024),
//                   onDateSubmitted: (date) {
//                     setState(() {
//                       _date = date;
//                     });
//                   },
//                 )),
//                 IconButton(
//                     onPressed: () async {
//                       var res = await showDatePicker(
//                           context: context,
//                           initialDate: _date,
//                           firstDate: DateTime(1990),
//                           lastDate: DateTime(2024));
//                       if (res != null) {
//                         setState(() {
//                           _date = res;
//                         });
//                       }
//                     },
//                     icon: const Icon(Icons.date_range)),
//               ],
//             ),
//             ListTile(
//               title: const Text('Tanggal terpilih'),
//               subtitle: Text(DateFormat.yMMMMEEEEd().format(_date)),
//             ),
//             const Divider(),
//             Row(
//               children: [
//                 const Text('Jam :'),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     enabled: false,
//                     controller: _time,
//                     decoration: const InputDecoration(labelText: 'Jam'),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () async {
//                       var res = await showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay.now(),
//                       );
//                       if (res != null) {
//                         setState(() {
//                           _time =
//                               TextEditingController(text: res.format(context));
//                           // final formattedTime = DateFormat.Hm().format(
//                           //   DateTime(2023, 1, 1, res.hour, res.minute),
//                           // );
//                           // _time = TextEditingController(text: formattedTime);
//                         });
//                       }
//                     },
//                     icon: const Icon(Icons.timer))
//               ],
//             ),
//             ListTile(
//               title: const Text('Jam terpilih'),
//               subtitle: Text(_time?.text ?? 'None'),
//             ),
//             const Divider(),
//             Row(
//               children: [
//                 const Text('Date Range start/end:'),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                     child: InputDatePickerFormField(
//                   initialDate: _dateRange.start,
//                   firstDate: DateTime(1990),
//                   lastDate: DateTime(2050),
//                   onDateSubmitted: (date) {
//                     setState(() {
//                       _dateRange.start = date;
//                     });
//                   },
//                 )),
//                 Expanded(
//                     child: InputDatePickerFormField(
//                   initialDate: _dateRange.end,
//                   firstDate: DateTime(1990),
//                   lastDate: DateTime(2050),
//                   onDateSubmitted: (date) {
//                     setState(() {
//                       _dateRange.end = date;
//                     });
//                   },
//                 )),
//                 IconButton(
//                     onPressed: () async {
//                       var res = await showDateRangePicker(
//                         context: context,
//                         firstDate: DateTime(2023),
//                         lastDate: DateTime(2024),
//                         initialDateRange: _dateRange,
//                       );
//                       if (res != null) {
//                         setState(() {
//                           _dateRange.start = res.start;
//                           _dateRange.end = res.end;
//                         });
//                       }
//                     },
//                     icon: const Icon(Icons.date_range)),
//               ],
//             ),
//             ListTile(
//               title: const Text('Tanggal mulai'),
//               subtitle: Text(DateFormat.yMMMMEEEEd().format(_dateRange.start)),
//             ),
//             ListTile(
//               title: const Text('Tanggal selesai'),
//               subtitle: Text(DateFormat.yMMMMEEEEd().format(_dateRange.end)),
//             ),
//             const Divider(),
//             SfDateRangePicker(
//                 onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
//                   setState(() {
//                     _multiDate = dateRangePickerSelectionChangedArgs.value;
//                   });
//                 },
//                 selectionMode: DateRangePickerSelectionMode.multiple),
//             ...List.generate(
//               _multiDate.length,
//               (index) => ListTile(
//                 title: Text('Tanggal ${index + 1}:'),
//                 subtitle:
//                     Text(DateFormat.yMMMMEEEEd().format(_multiDate[index])),
//               ),
//             ),
//             const Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }
