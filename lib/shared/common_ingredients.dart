import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class CommonIngredient {
  Ingredient _apple;
  Ingredient _banana;
  Ingredient _blackberry;
  Ingredient _blueberry;
  Ingredient _cherry;
  Ingredient _grape;
  Ingredient _grapefruit;
  Ingredient _kiwi;
  Ingredient _orange;
  Ingredient _peach;
  Ingredient _pear;
  Ingredient _pineapple;
  List<Ingredient> commonIngredients;

  CommonIngredient() {
    _apple = new Ingredient(
        '',
        'Apple',
        1,
        '',
        new DateTime.now(),
        new Nutrition(116, 0, 32, 0, 23, 6),
        56,
        false,
        "https://pbs.twimg.com/media/EX6OH8QXgAMeBkB?format=png&name=small");

    _banana = new Ingredient(
        '',
        'Banana',
        1,
        '',
        new DateTime.now(),
        new Nutrition(105, 0, 27, 1, 9, 3),
        4,
        false,
        "https://cdn.mos.cms.futurecdn.net/42E9as7NaTaAi4A6JcuFwG-970-80.jpg.webp");

    _blackberry = new Ingredient(
        '',
        'Blackberry',
        1,
        '',
        new DateTime.now(),
        new Nutrition(62, 0, 14, 2, 7, 8),
        3,
        false,
        "https://backyardberryplants.com/wp-content/uploads/2018/09/TripleCrown.jpg");

    _blueberry = new Ingredient(
        '',
        'Blueberry',
        1,
        '',
        new DateTime.now(),
        new Nutrition(84, 0, 22, 0, 15, 4),
        5,
        false,
        "https://backyardberryplants.com/wp-content/uploads/2018/09/TripleCrown.jpg");

    _cherry = new Ingredient(
        '',
        'cherry',
        12,
        '',
        new DateTime.now(),
        new Nutrition(60, 0, 14, 1, 12, 2),
        5,
        false,
        "https://www.freshfruitportal.com/assets/uploads/2017/08/cerezas_53336629-1024x683.jpg");

    _grape = new Ingredient(
        '',
        'grape',
        1,
        '',
        new DateTime.now(),
        new Nutrition(104, 0, 27, 0, 23, 0),
        7,
        false,
        "https://images.ctfassets.net/cnu0m8re1exe/6uSVPiUx1FloQ23j38x2aM/0eafe5c0d6b3ce7e3aae6b389a997423/Grapes.jpg?w=650&h=433&fit=fill");

    _grapefruit = new Ingredient(
        '',
        'grapefruit',
        1,
        '',
        new DateTime.now(),
        new Nutrition(52, 0, 13, 1, 8, 2),
        42,
        false,
        "https://images.ctfassets.net/cnu0m8re1exe/6uSVPiUx1FloQ23j38x2aM/0eafe5c0d6b3ce7e3aae6b389a997423/Grapes.jpg?w=650&h=433&fit=fill");

    _kiwi = new Ingredient(
        '',
        'kiwi',
        1,
        '',
        new DateTime.now(),
        new Nutrition(56, 0, 13, 1, 7, 3),
        7,
        false,
        "https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Kiwi-fruits-582a07b.jpg?quality=90&resize=661%2C600");

    _orange = new Ingredient(
        '',
        'orange',
        1,
        '',
        new DateTime.now(),
        new Nutrition(62, 0, 18, 1, 12, 3),
        10,
        false,
        "https://i.pinimg.com/736x/05/79/5a/05795a16b647118ffb6629390e995adb.jpg");

    _peach = new Ingredient(
        '',
        'peach',
        1,
        '',
        new DateTime.now(),
        new Nutrition(58, 0, 14, 1, 13, 2),
        5,
        false,
        "https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f42b5182138dffac9bf05b7%2F0x0.jpg%3FcropX1%3D549%26cropX2%3D8140%26cropY1%3D0%26cropY2%3D5693");

    _pear = new Ingredient(
        '',
        'pear',
        1,
        '',
        new DateTime.now(),
        new Nutrition(101, 0, 27, 1, 17, 6),
        3,
        false,
        "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/27/0/HEW_Pears_s4x3.jpg.rend.hgtvcom.616.462.suffix/1371612039080.jpeg");

    _pineapple = new Ingredient(
        '',
        'pineapple',
        1,
        '',
        new DateTime.now(),
        new Nutrition(82, 0, 22, 0, 16, 2),
        5,
        false,
        "https://images-na.ssl-images-amazon.com/images/I/71bNsWlkyeL._AC_SX522_.jpg");

    commonIngredients.addAll([
      _apple,
      _banana,
      _blackberry,
      _blueberry,
      _cherry,
      _grape,
      _grapefruit,
      _kiwi,
      _orange,
      _peach,
      _pear,
      _pineapple
    ]);
  }
}
