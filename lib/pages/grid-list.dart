import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridList extends StatelessWidget {
  const GridList({super.key});

  static const List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/12/30/05/22/bird-4728857_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/11/09/19/36/zoo-8378189_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/06/29/11/19/cornflower-6373897_1280.jpg',
    'https://cdn.pixabay.com/photo/2024/01/31/19/25/sunset-8544672_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/09/13/08/18/blue-flower-6620619_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/01/04/19/40/grass-7697505_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/12/21/08/29/owl-6884773_1280.jpg',
    'https://cdn.pixabay.com/photo/2024/03/02/13/05/orange-parrots-8608540_1280.jpg'
  ];

  // print(imageList)
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(10),
          // color: Colors.red,
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)
                ),
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(imageList[index]),
                      ),
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [ 
                            SizedBox(height: 5),
                            Text('T-Shirt',style: TextStyle(fontWeight: FontWeight.bold)),
                            // SizedBox(height: 1,),
                            Text('from',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200)),
                            ],
                      ),
                        Column(
                          children: [ 
                            SizedBox(height: 5),
                            Text('T-Shirt',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100)),
                            // SizedBox(height: 1),
                           Text('\$29.99',style: TextStyle(fontWeight: FontWeight.w400))
                            ],
                      ),
                      ],
                     )
                    ],
                  )),
              );
            },
          )
          //  MasonryGridView.builder(
          //   itemCount: imageList.length,
          //   gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,),
          //   itemBuilder: (context, index) =>   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child:  Material(
          //       borderRadius: BorderRadius.circular(12),
          //       child: Column(
          //         children: [
          //           Image.network(imageList[index], fit: BoxFit.cover, height: 140,),
          //           Text('Value', style: TextStyle(fontWeight: FontWeight.bold),)
          //         ],
          //       ),
          //     ),
          //     ) ,
          // ),
          ),
    );
  }
}
