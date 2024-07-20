// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapplication/app/data/modules/Detailspage/detilapage.dart';
import 'package:newsapplication/app/data/modules/Homemodule/Homecontroller.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final controller = Get.find<HomeController>();
    ever(controller.isConnectedToInternet, (bool isConnected) {
      Get.snackbar(
        'Internet',
        isConnected
            ? 'Connected to the Internet'
            : 'Disconnected from the Internet',
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "News",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ],
            )),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    CarouselSlider.builder(
                        itemCount:
                            controller.isConnectedToInternet.value ? 4 : 1,
                        itemBuilder: (context, index, realIndex) {
                          final item =
                              controller.dataModel.value.articles![index];

                          return Obx(() => Container(
                              width: Get.width / 1.3,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: item.urlToImage!.isNotEmpty
                                  ? controller.isConnectedToInternet.value
                                      ? Image.network(
                                          item.urlToImage.toString(),
                                          fit: BoxFit.fill,
                                        )
                                      : controller.img.startsWith("https:")
                                          ? Image.network(
                                              controller.img.value,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              controller.img.value,
                                              fit: BoxFit.fill,
                                            )
                                  : Image.network(
                                      "https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-1170x780.jpg")));
                        },
                        options: CarouselOptions(
                            autoPlay: controller.isConnectedToInternet.value,
                            scrollDirection: Axis.horizontal)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Popular News",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: Get.height / 2,
                      child: ListView.builder(
                        itemCount: controller.isConnectedToInternet.value
                            ? controller.dataModel.value.articles!.length
                            : 1,
                        itemBuilder: (context, index) {
                          final item =
                              controller.dataModel.value.articles![index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const DetailsPage(), arguments: index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 150,
                                        width: 100,
                                        child: controller
                                                .isConnectedToInternet.value
                                            ? Image.network(
                                                item.urlToImage.toString(),
                                                fit: BoxFit.fill,
                                              )
                                            : controller.img
                                                    .startsWith("https:")
                                                ? Image.network(
                                                    controller.img.value,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    controller.img.value,
                                                    fit: BoxFit.fill,
                                                  )),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            controller
                                                    .isConnectedToInternet.value
                                                ? item.title ?? "No title"
                                                : controller.title.value,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller
                                                    .isConnectedToInternet.value
                                                ? item.description ??
                                                    "No discription"
                                                : controller.desc.value,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ));
  }
}
