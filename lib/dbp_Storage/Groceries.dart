import 'package:ready_set_cook/models/pracIngredients.dart';

class GroceryList {
  static List<Grocery> getGroceries() {
    return [
      Grocery(name: 'Broccoli', quantity: '', expDate: '1 day', imageUrl: ''),
      Grocery(name: 'Kale', quantity: '', expDate: '1 day', imageUrl: ''),
      Grocery(
          name: 'Red Bell Peppers',
          quantity: '',
          expDate: '3 days',
          imageUrl: ''),
      Grocery(
          name: 'Strawberries', quantity: '', expDate: '7 days', imageUrl: '')
    ];
  }
}
