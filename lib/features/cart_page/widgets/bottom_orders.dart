import 'package:flutter/material.dart';

class BottomOrders extends StatefulWidget {
  const BottomOrders({super.key});

  @override
  State<BottomOrders> createState() => _BottomOrdersState();
}

class _BottomOrdersState extends State<BottomOrders> {
  bool switchPoints = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black, width: 1))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Use Points : ",
                  style: TextStyle(fontSize: 15),
                ),
                const Text(
                  "17.000",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Switch(
                  value: switchPoints,
                  onChanged: (bool value) {
                    setState(() {
                      switchPoints = !switchPoints;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Orders',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),

                // ElevatedButton(
                //     onPressed: () {},
                //     style: ButtonStyle(
                //         backgroundColor:
                //             MaterialStateProperty.resolveWith(
                //                 (states) => Colors.white)),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.add,
                //           color: Theme.of(context).colorScheme.primary,
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         Text(
                //           'Orders',
                //           style: TextStyle(
                //               color:
                //                   Theme.of(context).colorScheme.primary),
                //         ),
                //       ],
                //     )),
                // const Spacer(),
                // ElevatedButton(
                //     onPressed: () {}, child: Text("Choose Payment")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}