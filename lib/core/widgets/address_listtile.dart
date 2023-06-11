import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AddressListTile extends StatelessWidget {
  AddressListTile(
      {super.key,
      required this.alamat,
      required this.selection,
      required this.slider});
  Alamat? alamat;
  bool selection;
  bool slider;

  @override
  Widget build(BuildContext context) {
    final provAddress = Provider.of<AddressProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);
    return (alamat != null)
        ? Stack(children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
              child: (slider)
                  ? Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              provAddress.alamatDelete(
                                  provAccount.selectedAccount!.email, alamat!);
                              // TODO : Dialog warning delete
                              // TODO : ScaffoldMessenger
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: (selection)
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              spreadRadius: 2.0, // Spread radius
                              blurRadius: 5.0, // Blur radius
                              offset: Offset(
                                  0, 3), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(
                            (alamat!.alamatTitle == 'Home' ||
                                    alamat!.alamatTitle == 'Rumah')
                                ? Icons.home_rounded
                                : (alamat!.alamatTitle == 'Office' ||
                                        alamat!.alamatTitle == 'Kantor')
                                    ? Icons.business_outlined
                                    : Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  alamat!.alamatTitle,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  alamat!.alamatLengkap,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              alamat!.alamatDesk,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          trailing: Icon(
                            (selection)
                                ? Icons.check
                                : Icons.arrow_right_outlined,
                            size: 40,
                            color: (selection)
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: (selection)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          width: 1.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey, // Shadow color
                            spreadRadius: 2.0, // Spread radius
                            blurRadius: 5.0, // Blur radius
                            offset:
                                Offset(0, 3), // Offset in the x and y direction
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(
                          (alamat!.alamatTitle == 'Home' ||
                                  alamat!.alamatTitle == 'Rumah')
                              ? Icons.home_rounded
                              : (alamat!.alamatTitle == 'Office' ||
                                      alamat!.alamatTitle == 'Kantor')
                                  ? Icons.business_outlined
                                  : Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                alamat!.alamatTitle,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                alamat!.alamatLengkap,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            alamat!.alamatDesk,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        trailing: Icon(
                          (selection)
                              ? Icons.check
                              : Icons.arrow_right_outlined,
                          size: 40,
                          color: (selection)
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                    ),
            ),
          ])
        : Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    spreadRadius: 2.0, // Spread radius
                    blurRadius: 5.0, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.location_off,
                  color: Colors.red,
                  size: 40,
                ),
                title: Text(
                  'No Location set',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("No details.."),
                ),
                trailing: const Icon(
                  Icons.arrow_right_outlined,
                  size: 40,
                ),
              ),
            ),
          );
  }
}
