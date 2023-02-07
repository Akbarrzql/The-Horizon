import 'package:get/get.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataController extends GetxController{
  OnThisDayModel? onThisDayModel;
  var isDataLoading = false.obs;
  //get mount
  String mount = DateTime.now().month.toString();
  //get day
  String day = DateTime.now().day.toString().padLeft(2, '0');

  @override
  Future<void> onInit() async {
    super.onInit();
    getApi(mount, day);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  getApi(mount, day) async {
    isDataLoading(true);
    final responseOtd = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${mount}/${day}'));
    print("Response status: ${responseOtd.statusCode}");
    onThisDayModel = OnThisDayModel.fromJson(jsonDecode(responseOtd.body.toString()));
    print("Response body: ${onThisDayModel?.events![0].text}");
    isDataLoading(false);
  }
}

