class Urls {
  static String baseUrl = "http://localhost:3000";
  static String createUser = "$baseUrl/user/create";
  static String loginUser({required String idToken}) =>
      "$baseUrl/user/login?idToken=$idToken";
  static String getFeaturedCar(int limit) =>
      "$baseUrl/cars?limit=$limit&isFeatured=true&isHotDeal=false";
  static String carById(String id) => "$baseUrl/cars/$id";
  static String getHotDealCar = "$baseUrl/cars?isHotDeal=true&limit=10";
  static String getCarsByFilter({
    String? model,
    String? brand,
    String? location,
    int? minPrice,
    int? maxPrice,
    int? maxYear,
    int? minYear,
    String? fuelType,
    String? title,
  }) {

    final Map<String, dynamic> queryParams = {
      if (model != null) 'model': model,
      if (brand != null) 'brand': brand,
      if (location != null) 'location': location,
      if (minPrice != null) 'minPrice': minPrice.toString(),
      if (maxPrice != null) 'maxPrice': maxPrice.toString(),
      if (minYear != null) 'minYear': minYear.toString(),
      if (maxYear != null) 'maxYear': maxYear.toString(),
      if (fuelType != null) 'fuelType': fuelType,
      if (title != null && title.isNotEmpty) 'title': title,
    };

    final uri = Uri.parse("$baseUrl/cars").replace(queryParameters: queryParams);

    return uri.toString();
  }
  static String getCarTypes = "$baseUrl/carType";
  static String getCarByTypeId(String carTypeId) => "$baseUrl/cars?carTypeId=$carTypeId";
  static String getAllCars = "$baseUrl/cars";
  static String getCarBrands = "$baseUrl/carBrands";
  static String getMinAdMaxPrice = "$baseUrl/carMinAndMaxPrice";
  static String getMinAndMaxYear = "$baseUrl/carMinAndMaxYear";
  static String getCarModels(String? brand) =>
      "$baseUrl/carModels?brand=$brand";
  static String getCarFuelTypes(String? brand, String? model) =>
      "$baseUrl/carFuelTypes?brand=$brand&model=$model";
  static String getCarLocations(
    String? brand,
    String? fuelType,
    String? model,
  ) => "$baseUrl/carLocations?brand=$brand&fuelType=$fuelType&model=$model";
  static String getCarByTitle(String title) => "$baseUrl/cars?title=$title";
}
