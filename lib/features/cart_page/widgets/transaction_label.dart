import 'package:flutter/material.dart';

class TransactionLabel extends StatefulWidget {
  TransactionLabel({super.key, required this.label, required this.price});
  String label;
  String price;

  @override
  State<TransactionLabel> createState() => _TransactionLabelState();
}

class _TransactionLabelState extends State<TransactionLabel> {
  @override
  Widget build(BuildContext context) {
    return (widget.label == 'Sub-total')
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.label,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const Text(
                        "Rp",
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Text(
                        widget.price,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.label,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text(
                        "Rp",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Text(
                        widget.price,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
