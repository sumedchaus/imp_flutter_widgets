import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imp_flutter_widgets/controller/main_controller.dart';


class HomePage extends StatelessWidget {
  final MainController controller = Get.put(MainController());
  final focusNode = FocusNode();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Scaffold(
      appBar: AppBar(
        title: controller.isSearchButton.value
            ? controller.appBarTitle.value
            : TextField(
          focusNode: focusNode,
          controller: controller.searchText,
          onSubmitted: (String value) {
            controller.searchText.text = value;
            controller.isSuccess.value = false;
          },
          cursorColor: Colors.white,
          textInputAction: TextInputAction.go,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),

              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(
            icon: controller.actionIcon.value,
            onPressed: () {
              focusNode.requestFocus();
              if (controller.isSearchButton.value) {
                controller.actionIcon.value = const Icon(Icons.close);
                controller.isSearchButton.value =
                !controller.isSearchButton.value;
              } else {

                controller.actionIcon.value = const Icon(Icons.search);
                if (controller.searchText.text.isNotEmpty) {
                  controller.searchText.text = "";
                }
                controller.isSearchButton.value =
                !controller.isSearchButton.value;
              }
            },
          ),
          controller.isSearchButton.value
              ? PopupMenuButton(
            elevation: 5.0,
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                child: Obx(() =>
                      CheckboxListTile(
                        value: controller.isCheckBox.value,
                        onChanged: (value) {
                          controller.isCheckBox.value = value!;
                          Get.back();
                        },
                        title: const Text("Active Clients Only"),
                      ),
                ),
              ),
            ],
          )
              : const SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return  Obx(() => CustomButtons(
            index: index,
            isSelected: controller.selectedIndex.value == index,
            onSelect: () {
              controller.selectedIndex.value = index;
            },
          ),
          );
        },
      ),
    ),
    );
  }
}


class CustomButtons extends StatelessWidget {

  const CustomButtons({
    required this.index,
    required this.isSelected,
    required this.onSelect,
    Key? key}) : super(key: key);
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: isSelected? Colors.grey : Colors.red
      ),
      onPressed: onSelect,
      child: Text(index.toString()),
    );
  }
}
