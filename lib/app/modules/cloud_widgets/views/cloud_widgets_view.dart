import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cloud_widgets_controller.dart';

class CloudWidgetsView extends GetView<CloudWidgetsController> {
  const CloudWidgetsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CloudWidgetsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CloudWidgetsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
