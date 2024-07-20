// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsapplication/app/data/models/Datamodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final dataModel = DataModel().obs;
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=bitcoin&from=2024-06-25&sortBy=publishedAt&apiKey=bd9934c750314feeb1fe65d556c9888c'));
      if (response.statusCode == 200) {
        final val = json.decode(response.body);
        dataModel.value = DataModel.fromJson(val);
        writedata();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  final RxString title = "r8yfiehrheigherg".obs;
  final RxString desc = "hjvbhjbjbdv".obs;
  final RxString img = "assets/images/ai-generated-8248880_1280.png".obs;

  Future<void> writedata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'title', dataModel.value.articles![5].title.toString());
    await prefs.setString(
        'discription', dataModel.value.articles![5].description.toString());
    await prefs.setString(
        'image', dataModel.value.articles![5].urlToImage.toString());
    await readdata();
  }

  Future<void> readdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    title.value = prefs.getString('title')!;
    desc.value = prefs.getString('discription')!;
    img.value = prefs.getString('image')!;
  }

  RxBool isConnectedToInternet = false.obs;
  StreamSubscription? internetconnectionstreamsubscription;

  @override
  void onInit() {
    super.onInit();
    internetconnectionstreamsubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          isConnectedToInternet.value = true;

          break;
        case InternetStatus.disconnected:
          isConnectedToInternet.value = false;
          break;

        default:
          isConnectedToInternet.value = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    internetconnectionstreamsubscription?.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }
}
