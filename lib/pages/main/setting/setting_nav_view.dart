import 'package:flutter/material.dart';

class SettingNavView extends StatelessWidget {
  new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Text('Setting View')],
    );
  }

  final _ipTextPrint = TextEditingController(text: '192.168.0.111');

  Widget _buildTextPrintView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Test Print',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Divider(),
        TextField(
          controller: _ipTextPrint,
          decoration: InputDecoration(
            label: Text('IP Address'),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 6),
        FilledButton(onPressed: () {}, child: Text('Test Print')),
      ],
    );
  }
}
