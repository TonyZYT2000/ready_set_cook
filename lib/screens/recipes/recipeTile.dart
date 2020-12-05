import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/viewRecipe.dart';

// ignore: must_be_immutable
class RecipeTile extends StatelessWidget {
  final String name;
  final double rating;
  final String recipeId;
  List<String> lst = ['Name: ', 'Rating:  '];
  RecipeTile({this.name, this.rating, this.recipeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewRecipe(recipeId)));
        },
        child: Container(
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.all(20),
          child: Wrap(children: [
            Column(children: <Widget>[
              new Container(
                  height: 140,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/apple.png"),
                      ),
                      borderRadius: new BorderRadius.circular(8)))
            ]),

            SizedBox(height: 10),

            //Center(

            //child:

            Text(name + '\n' + "Rate: " + rating.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.blueGrey)),

            _buildRatingStar(rating),
          ]),
          width: 150,
          height: 260,
          decoration: BoxDecoration(
              color: Colors.blue[100], borderRadius: BorderRadius.circular(10)),
        ));
  }
}

Widget _buildRatingStar(rating) {
  List<Widget> icons = [];
  double i = 0;
  while (i < rating - 0.5) {
    icons.add(new Icon(Icons.star, color: Colors.blue));

    i = i + 1;
  }
  if (rating - i >= 0.5) {
    icons.add(new Icon(Icons.star_half, color: Colors.blue));
  }

  while (icons.length != 5) {
    icons.add(new Icon(Icons.star_border, color: Colors.grey));
  }

  return new Padding(
    padding: EdgeInsets.fromLTRB(70, 0, 0, 10),
    child: new Row(children: icons),
  );
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
