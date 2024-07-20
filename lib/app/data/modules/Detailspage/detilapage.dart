import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapplication/app/data/modules/Homemodule/Homecontroller.dart';

class DetailsPage extends GetWidget {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final index = Get.arguments;
    Get.put(HomeController());
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 100,
                  ),
                  const Text(
                    "Discription",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              controller.isConnectedToInternet.value
                  ? controller.dataModel.value.articles![index].title.toString()
                  : controller.title.value,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 300,
                width: Get.width,
                child: controller.isConnectedToInternet.value
                    ? Image.network(
                        controller.dataModel.value.articles![index].urlToImage
                            .toString(),
                        fit: BoxFit.fill,
                      )
                    : controller.img.startsWith("https:")
                        ? Image.network(controller.img.value)
                        : Image.asset(controller.img.value)),
            const SizedBox(
              height: 30,
            ),
            Text(controller.isConnectedToInternet.value
                ? controller.dataModel.value.articles![index].description
                    .toString()
                : controller.desc.value)
          ],
        ),
      ),
    );
  }
}
