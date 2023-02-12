import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _catorylabel = [
      'food',
      'vegetable',
      'egg',
      'tea',
      'test',
      'test',
      'test',
      'test',
      'test',
      'test',
      'test',
      'test',
    ];

    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _catorylabel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: Colors.cyanAccent,
                            onPressed: () {},
                            label: Text(
                              _catorylabel[index],
                            ),
                          ),
                        );
                      }),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
