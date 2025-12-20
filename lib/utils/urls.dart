class Urls {
  static String baseUrl = "http://localhost:3000";
  static String createUser = "$baseUrl/user/create";
  static String loginUser({required String idToken}) =>
      "$baseUrl/user/login?idToken=$idToken";
  static String getFeaturedCar(int limit) =>
      "$baseUrl/cars?limit=$limit&isFeatured=true&isHotDeal=false";
  static String carById(String id) => "$baseUrl/cars/$id";
  static String getHotDealCar = "$baseUrl/cars?isHotDeal=true&limit=10";
  static String getCarTypes = "$baseUrl/carType";
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
