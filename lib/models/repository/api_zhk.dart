
class ApiZhk {
  final double latitude;
  final double longtitude;

  ApiZhk.fromApi(Map<String, dynamic> map)
      : latitude = map['location'],
        longtitude = map['location'];
}