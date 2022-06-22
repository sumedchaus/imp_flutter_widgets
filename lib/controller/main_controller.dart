import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  var isSelected = false.obs;
  var selectedIndex = 0.obs;

  var actionIcon = Icon(Icons.search).obs;
  var appBarTitle = const Text("Flutter Imp Codes").obs;
  var isSearchButton = true.obs;
  var isCheckBox = true.obs;
  var isSuccess = true.obs;

  late TextEditingController searchText;


  @override
  void onInit() {
    searchText = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    searchText.dispose();
    super.onClose();
  }
}
