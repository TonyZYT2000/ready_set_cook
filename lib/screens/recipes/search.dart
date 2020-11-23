import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes_/view_recipe.dart';

class Search extends StatefulWidget {
  final Function toggleView;
  Search({this.toggleView});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> recipes = [
    "chicken breast",
    "pizza",
    "Buffalo chicken",
    "salad",
    "chicken breast",
    "pizza",
    "Buffalo chicken",
    "salad"
  ];
  List<List<String>> ingredient = [
    ["ingredient for CB"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"],
    ["ingredient for CB"],
    ["ingredient for pizza"],
    ["ingredient for BC"],
    ["ingredient for salad"]
  ];
  List<List<String>> quantity = [
    ["quantity for CB"],
    ["quantity for pizza"],
    ["quantity for BC"],
    ["quantity for salad"],
    ["quantity for CB"],
    ["quantity for pizza"],
    ["quantity for BC"],
    ["quantity for salad"]
  ];
  // Recipes(this.recipes);
  List a = [
    "assets/images/chicken breast.jpg",
    "assets/images/pizza.jpg",
    "assets/images/Buffalo chicken.jpg",
    "assets/images/salad.jpg",
    "assets/images/chicken breast.jpg",
    "assets/images/pizza.jpg",
    "assets/images/Buffalo chicken.jpg",
    "assets/images/salad.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Padding(padding: const EdgeInsets.symmetric(horizontal: 20)),
        backgroundColor: Colors.blue[200],
        title: Text("Search Recipes"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: a.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewRecipe(a[i], ingredient[i], quantity[i])));
                  },
                  child: Container(
                    padding: EdgeInsets.all(50.0),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                        // backgroundBlendMode: BlendMode.softLight,
                        border: Border.all(color: Colors.blue[100], width: 10),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(1.0),
                                BlendMode.softLight),
                            fit: BoxFit.cover,
                            image: AssetImage(a[i]))),
                  ));
            }),
      ),
    );
  }
}

final recipes = [
  "Garlic Chicken",
  "Cup Cakes",
  "Buffalo Wings",
  "Piazza",
  "Burgers"
];
final recentRecipes = ["Garlic Chicken", "Burger"];

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty
        ? recentRecipes
        : recipes.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
