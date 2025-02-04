import 'dart:convert';
import 'package:http/http.dart' as http;

class WordPressApi {
  final String baseUrl;

  WordPressApi({required this.baseUrl});

  Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wp-json/wp/v2/categories'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load categories: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchPostsForCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/wp-json/wp/v2/posts?categories=$categoryId&_embed=true',
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load posts: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching posts for category $categoryId: $e');
      return [];
    }
  }
}
