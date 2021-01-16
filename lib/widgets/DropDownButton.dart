import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}
class Levels {
  int id;
  int level;

  Levels(this.id, this.level);

  static List<Levels> getLevels() {
    return <Levels>[
      Levels(1, 1),
      Levels(2, 2),
      Levels(3, 3),
      Levels(4, 4),
      Levels(5, 5),
    ];
  }
}

class _DropDownState extends State<DropDown> {

  List<Levels> _levels = Levels.getLevels();
  List<DropdownMenuItem<Levels>> _dropdownMenuItems;
  Levels _selectedLevel;

  @override
  void initState() {
    // TODO: implement initState
    _dropdownMenuItems = buildDropDownMenuItems(_levels);
    _selectedLevel = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Levels>> buildDropDownMenuItems(List levels){

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


