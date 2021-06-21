import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function(BuildContext context, LoadingState state) onButtonPressed;

  LoadingButton({this.icon, this.title, this.onButtonPressed});

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> implements LoadingState {
  bool _isLoading = false;

  @override
  void setLoadingState(bool isLoading) => setState(() {
    _isLoading = isLoading;
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onButtonPressed(context, this);
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
      child: _isLoading
          ? Center(
              child: SpinKitDualRing(
                color: Colors.white,
                size: 20.0,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
    );
  }
}

class LoadingState {
  void setLoadingState(bool isLoading) {}
}
