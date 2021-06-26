import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Item {
  Item(
      {this.index,
      this.expandedValue,
      this.headerValue,
      this.isExpanded = false});

  int index;
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class ExpansionSample extends StatelessWidget {
  const ExpansionSample({Key key}) : super(key: key);

  static const String _title = 'Expansion Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const ExpansionWidget(),
      ),
    );
  }
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      index: index,
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({Key key}) : super(key: key);

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  final List<Item> _data = generateItems(8);

  void _switchExpansion(int index, bool isExpanded) {
    setState(() {
      _data.forEach((el) {
        el.isExpanded = false;
      });
      _data[index].isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) =>
          _switchExpansion(index, isExpanded),
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(children: [
                Radio(
                    value: isExpanded ? item.headerValue : "",
                    groupValue: item.headerValue,
                    onChanged: (value) =>
                        _switchExpansion(item.index, isExpanded)),
                Text(item.headerValue)
              ]),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Panel ${item.index} comes here"),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
