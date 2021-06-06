import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String category;
  final bool selected;
  final double offsetForm;

  CategoryTab(
      {Key key, @required this.category, this.selected, this.offsetForm})
      : super(key: key);

  CategoryTab copyWith(bool selected) => CategoryTab(
      category: category, selected: selected, offsetForm: offsetForm);

  @override
  Widget build(BuildContext context) {
    //var categoryText = category.toUpperCase().substring(10);
    return Container(
      width: 120,
      height: 60,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          category.toUpperCase(), //categoryText.replaceAll(RegExp('_'), ' '),
          style: TextStyle(shadows: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ], color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
