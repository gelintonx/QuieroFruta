import '../device/save_branch.dart';
import '../models/Branch.dart';
import '../utils/icon_color.dart';
import '../widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: iconColor,
      ),
      drawer: ArasaDrawer(),
      body: _ChoosePageBody(),
    );
  }
}

List<Branch> list = [
  Branch(name: 'Lambaré', id: 1),
  Branch(name: 'Ciudad del Este', id: 2),
  Branch(name: 'Luque', id: 3),
  Branch(name: 'Encarnación', id: 4),
  Branch(name: 'Fernando de la Mora', id: 5),
  Branch(name: 'San Lorenzo', id: 6),
  Branch(name: 'Asunción', id: 7),
  Branch(name: 'Villarrica', id: 8),
  Branch(name: 'Pedro Juan Caballero', id: 9),
  Branch(name: 'Villa Elisa', id: 10)
];

class _ChoosePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String choose = '';

    return Center(
      child: Column(
        children: [
          Text('Elija su sucursal', style: TextStyle(fontSize: 30.0)),
          const SizedBox(height: 80),
          Container(
            height: 220,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: 0),
              itemExtent: 40,
              magnification: 1.5,
              looping: true,
              children: List.generate(
                  list.length, (index) => Text('${list[index].name}')),
              onSelectedItemChanged: (int index) {
                final branchSelected = list[index];
                choose = branchSelected.name;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final save = SaveBranch();
              if (choose.isEmpty) {
                choose = 'Lambaré';
                await save.saveBranch(choose);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              } else {
                await save.saveBranch(choose);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
            },
            child: Text('Seleccionar'),
          )
        ],
      ),
    );
  }
}
