import 'package:digital_canteen/views/Orders/seeorderdetails_page.dart';
import 'package:digital_canteen/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'timer_controller.dart'; // Import the TimerController

class TrackingOrderPage extends StatelessWidget {
  final String globalOrderId;
  final Map<String, dynamic> order;
  final String orderId;
  final String imageUrl;

  TrackingOrderPage({
    super.key,
    required this.globalOrderId,
    required this.order,
    required this.orderId,
    required this.imageUrl,
  });

  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Row(
            children: [
              Icon(Icons.arrow_back_ios_rounded, color: Colors.grey, size: 18,),
              SizedBox(width: 10,),
              Text("Go back", style: TextStyle(color: Colors.grey, fontSize: 18),),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                // const SizedBox(height: 20),
                Image.asset(
                  'assets/images/delivery.gif',
                  // height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tracking Order",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Estimated Time",
                  style: TextStyle(color: Colors.blue),
                ),
                Obx(() => Text(
                      "Arriving in ${timerController.formattedDuration} min",
                      style: const TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NElevatedButton(
              borderRadius: 15,
              text: 'ORDER DETAILS',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeOrderDetails(
                      globalOrderId: globalOrderId,
                      order: order,
                      orderId: orderId,
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
