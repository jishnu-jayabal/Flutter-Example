import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:worldtimeApp/models/time.dart';
import 'package:worldtimeApp/models/time_param.dart';

class TimeService {
  Time time;

  Future<void> getTime(TimeParam timeParam) async {
    try {
      Response response =
          await get("http://worldtimeapi.org/api/timezone/${timeParam.url}");
      Map data = jsonDecode(response.body);

      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      print("-----" + datetime);

      time = Time();

      time.time = DateFormat.jm().format(now);
      time.location = timeParam.url;
    } catch (err) {
      print(err);
    }
  }
}
