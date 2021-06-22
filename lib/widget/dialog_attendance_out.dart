import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'loading_button.dart';

class DialogAttendanceOut extends StatelessWidget {
  final String dtmOut;
  final Function onButtonClicked;

  const DialogAttendanceOut({this.dtmOut, this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Apa yang kamu kerjakan hari ini?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            LoadingButton(
              icon: Icons.fingerprint,
              title: 'Absen Pulang',
              onButtonPressed: (context, state) {
                var dailyReport = _controller.text;
                if (dailyReport.isEmpty) {
                  Toast.show(
                    'Silakan isi dahulu laporan kerja kamu hari ini!',
                    context,
                    duration: 2,
                  );
                  return;
                }
                onButtonClicked.call(context, state, dailyReport);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
