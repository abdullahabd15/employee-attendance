import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final IconData icon;
  final String field;
  final String value;

  const ProfileField({this.icon, this.field, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.blue[700],
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('$field :'),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
