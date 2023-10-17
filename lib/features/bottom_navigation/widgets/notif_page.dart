import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/notification_provider.dart';

class NotifPage extends StatelessWidget {
  NotifPage({super.key, required this.notif});
  List<Notif> notif;

  @override
  Widget build(BuildContext context) {
    print(notif);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.chevron_left,
                size: 30,
              )),
          title: const Text(
            'Notifications',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: (notif.isNotEmpty)
                ? ListView(children: [
                    ...ListTile.divideTiles(
                      context: context,
                      tiles: List.generate(
                        notif.length,
                        (index) {
                          return Stack(children: [
                            ListTile(
                              leading: Icon(
                                Icons.notifications_active_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text(notif[index].title),
                              subtitle: Text(
                                notif[index].text,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Text(
                                  '${(notif[index].date.day.toString().length == 1) ? '0${notif[index].date.day}' : notif[index].date.day}-${(notif[index].date.month.toString().length == 1) ? '0${notif[index].date.month}' : notif[index].date.month}-${notif[index].date.year}',style: const TextStyle(color: Colors.grey, fontSize: 12),),
                            )
                          ]);
                        },
                      ),
                    ),
                    const Divider(),
                  ])
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off,
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'There is no notifications..',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )));
  }
}
