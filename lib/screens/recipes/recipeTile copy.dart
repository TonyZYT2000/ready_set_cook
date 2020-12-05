import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';

class RecipeTile extends StatelessWidget {
  final String name;

  final int rating;
  final String recipeId;
  List<String> lst = ['Name: '];
  RecipeTile({this.name, this.rating, this.recipeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewRecipe(recipeId)));
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: SingleChildScrollView(
                child: Column(
                    //spacing: 8.0, runSpacing: 4.0,
                    children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/apple.png"),
                    height: 100,
                    alignment: Alignment.topLeft,
                  ),
                  //SizedBox(height: 10),
                  //Center(
                  //child:
                  Text(lst[0] + name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.blueGrey)),

                  _buildRatingStar(rating),
                  //Icon(icons)
                  //))
                ]))));
  }
}

Widget _buildRatingStar(rating) {
  List<Widget> icons = [];
  int i = 0;
  while (i < rating) {
    icons.add(new Icon(Icons.star, color: Colors.yellow));

    i++;
  }

  while (icons.length != 5) {
    icons.add(new Icon(Icons.star_border));
  }

  return new Row(children: icons);
}

// padding: EdgeInsets.all(10.0),
// width: 120,
// height: 120,
// decoration: BoxDecoration(
//   border: Border.all(color: Colors.blue[100], width: 10),
//   borderRadius: BorderRadius.circular(20),
//   image:
//       DecorationImage(image: AssetImage("assets/images/apple.png")),
// ),
// child: Center(
//     child: Text(
//         lst[0] +
//             name +
//             '   ' +
//             lst[1] +
//             cooked +
//             '   ' +
//             lst[2] +
//             rating.toString(),
//         textAlign: TextAlign.left,
//         style: TextStyle(fontSize: 18))),
// image: DecorationImage(
//     colorFilter: ColorFilter.mode(
//         Colors.blue.withOpacity(1.0), BlendMode.softLight),
//     fit: BoxFit.cover,
//     image: AssetImage("assets/images/apple.png"))),
// }
//}
/**********
 * class RecipeTile extends StatefulWidget {
  @override
  createState() => new RecipeTileState();
}
  class RecipeTileState extends State<RecipeTile>{
  @override 
  Widget build (BuildContext context){
      
  }
  }
  String icons = "";
  if (rating == 5) {
  icons += "\uE000" * 5;
  }
  if (4 <= rating && rating < 5) {
   icons += "\uE914" * 4;
  }
   if (3 <= rating && rating < 4) {
   icons += "\uE914" * 3;
   }
   if (2 <= rating && rating < 3) {
  icons += "\uE914" * 2;
 }
 if (1 <= rating && rating < 2) {
  icons += "\uE914";
 }
if (rating < 1) {
  icons += "\uE000";
}

 ************/
/******
  *   int f = 0;
  if (rating == 5) {
  while (f < 5) {
  icons.add(Icon(Icons.star, color: Colors.yellow));
  f++;
  }
}

 if (4 <= rating && rating < 5) {
while (f < 4) {    
  icons.add(Icon(Icons.star, color: Colors.yellow));
   f++;
 }
  icons.add(Icon(Icons.star_border));  }
 if (3 <= rating && rating < 4) {
   while (f < 3) {     icons.add(Icon(Icons.star, color: Colors.yellow));
   f++;
  }
 while (f < 5) {
  icons.add(Icon(Icons.star_border));
   f++;
 }
}
if (2 <= rating && rating < 3) {
   while (f < 2) {
   icons.add(Icon(Icons.star, color: Colors.yellow));
   f++;
   }
while (f < 5) {
  icons.add(Icon(Icons.star_border));
f++;
  }
}
if (1 <= rating && rating < 2) {
  icons.add(Icon(Icons.star, color: Colors.yellow));
  while (f < 5) {
  icons.add(Icon(Icons.star_border));
  f++;
   }
  }
if (rating < 1) {
  while (f < 5) {
   icons.add(Icon(Icons.star_border));
  f++;
  }
}

  */
