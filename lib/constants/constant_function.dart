import 'dart:convert';
import 'package:http/http.dart' as http;

class ConstantFunction {
  static Future<List<Map<String, dynamic>>> getResponse(
    String findRecipe,
  ) async {
    final url =
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$findRecipe';
    final response = await http.get(Uri.parse(url));

    List<Map<String, dynamic>> recipe = [];

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['meals'] != null) {
        for (var item in data['meals']) {
          recipe.add({
            'label': item['strMeal'],
            'image': item['strMealThumb'],
            'calories': 600,
            'totalTime': 30,
          });
        }
      }
    }

    return recipe;
  }
}
