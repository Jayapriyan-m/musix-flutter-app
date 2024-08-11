class Country {
  // Defining the name of the country
  final String name;
  // Defining the country code for the country
  final String code;

  Country({required this.name, required this.code});

  // creating a Country object from JSON data
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      // Parsing the name from the JSON map
      name: json['name'] as String,
      // Parsing the code from the JSON map
      code: json['code'] as String,
    );
  }
}
