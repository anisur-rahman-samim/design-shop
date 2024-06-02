import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop/models/Search_model.dart';
import 'package:shop/services/api_services/api_services.dart';
import 'package:shop/utils/app_url/app_urls.dart';

class SearchScreenController extends GetxController{
  // RxList products = [
  //   {
  //     "name" : "earphone for phone",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/air_pods.png"
  //   },
  //   {
  //     "name" : "Monitor",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/monitor.png"
  //   },
  //   {
  //     "name" : "earphone",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/earphones.png"
  //   },
  //   {
  //     "name" : "Head Phone",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/air_pods.png"
  //   },
  //   {
  //     "name" : "earphone for phone",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/air_pods.png"
  //   },
  //   {
  //     "name" : "earphone for phone",
  //     "price" : r"$199.99",
  //     "image" : "assets/images/air_pods.png"
  //   },
  // ].obs;

  bool isLoading = false;
  Search_model ? search_model;

  RxList products = [].obs;

  Future<void> getSearchData({required String search}) async {
    products.value = [];
    if(search_model?.result != null){
      search_model?.result = [];
    }

    isLoading = true;
    update();
    String url = "${AppUrls.search}?searchTerm=$search";

    // Map<String, String> header = {
    //   'Authorization': "Bearer ${PrefsHelper.token}"
    // };

    var response = await ApiService.getApi(url,isHeader: false, {});

    if (response.statusCode == 200) {
      search_model = Search_model.fromJson(jsonDecode(response.responseJson));
      update();
      if(search_model?.result != null){
     //   print("Hello ------- ${search_model?.result?[0].productName}");
      //  print("Hello ------- ${search_model?.result?[0].productDescription}");
        products.addAll(search_model!.result!);
      }

      if (kDebugMode) {
        print("============data>sjdfhsd${response.responseJson.length}");
      }

      // for (var item in allShopsModel.data!) {
      //   allShopList.add(item);
      // }
      //
      // saveRecentSearch(search : search);
    }
    isLoading = false;
    update();
  }
}