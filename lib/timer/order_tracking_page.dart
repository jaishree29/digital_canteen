import 'package:digital_canteen/views/Orders/seeorderdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'timer_controller.dart'; // Import the TimerController

class TrackingOrderPage extends StatelessWidget {
  final String globalOrderId;
  final Map<String, dynamic> order;
  final String orderId;

  TrackingOrderPage({
    super.key,
    required this.globalOrderId,
    required this.order,
    required this.orderId,
  });

  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking Order"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'assets/images/order_track.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  "Tracking Order",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Estimated Time",
                  style: TextStyle(color: Colors.blue),
                ),
                Obx(() => Text(
                  "Arriving in ${timerController.formattedDuration} min",
                  style: TextStyle(fontSize: 20),
                )),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeOrderDetails(
                        globalOrderId: globalOrderId,
                        order: order,
                        orderId: orderId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  "ORDER DETAILS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
