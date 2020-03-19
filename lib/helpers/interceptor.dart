import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    data.headers['Authorization'] =  'Bearer $token';
    print(data.headers);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }

}
