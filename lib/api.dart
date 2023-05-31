import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class getCategories {
  static Future<List<dynamic>> fetchcategories() async {
    List<dynamic> categories = [];
    try {
        final url = "https://www.themealdb.com/api/json/v1/1/categories.php";
        final file = await DefaultCacheManager().getSingleFile(url);
        final response = await file.readAsString().then((jsonString) => jsonDecode(jsonString));
        final data = response['categories'] as List<dynamic>;
        categories.addAll(data);
    } catch (error) {
      print(error);
    }

    return categories;
  }
}

class getFood {
  static Future<List<dynamic>> fetchFood(String temp) async {
    List<dynamic> food = [];
    try {
      final url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$temp";
      final file = await DefaultCacheManager().getSingleFile(url);
      final response = await file.readAsString().then((jsonString) => jsonDecode(jsonString));

      final data = response['meals'] as List<dynamic>;
      food.addAll(data);

    } catch (error) {
      print(error);
    }

    return food;
  }
}

class getDetail {
  static Future<List<dynamic>> fetchDetail(String temp) async {
    List<dynamic> detail = [];
    try {
      final url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$temp";
      final file = await DefaultCacheManager().getSingleFile(url);
      final response = await file.readAsString().then((jsonString) => jsonDecode(jsonString));

      final data = response['meals']as List<dynamic>;
      detail.addAll(data);

    } catch (error) {
      print(error);
    }
print(detail);
    return detail;
  }
}