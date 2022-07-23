import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopSelectButton extends StatelessWidget {
  const TopSelectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: const [

        DropdownMenuItem<String>(
          child: Text('Living Room'),
          value: 'Living Room',
        ),
        DropdownMenuItem<String>(
          child: Text('Bedroom'),
          value: 'BedRoom',
        ),
        DropdownMenuItem<String>(
          child:
          Text('Garage'),
          value: 'Garage',
        ),
      ],
      hint: const Text(
        'All Rooms ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
      icon: const Padding(padding: EdgeInsets.only(left: 5), child: Icon(CupertinoIcons.chevron_down)),
      iconSize: 20,
      iconEnabledColor: Colors.black,
      underline: const SizedBox.shrink(),
      onChanged: (value) {

      },
    );
  }
}