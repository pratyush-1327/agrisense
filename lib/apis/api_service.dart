import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // static String apiKey = 'AIzaSyCeHXjCe9NHubTsk7o50QjyOcXnNORI0Cs';
  static String apiKey = dotenv.env['API_KEY'] ?? 'API_KEY not found';
}
