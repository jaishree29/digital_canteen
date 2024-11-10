// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
//
// class UpiPaymentScreen extends StatelessWidget {
//   // Define UPI details
//   final String payeeUPI = 'amansingh3576@barodampay';
//   final String payeeName = 'Aman Singh';
//   final String amount = '5.00'; // Ensure amount is a proper decimal format
//   final String currency = 'INR';
//   final String transactionNote = 'Order Payment';
//
//   // UPI URL getter with unique transaction reference each time
//   String get upiUrl {
//     // Generate a unique transaction ID for each transaction
//     String transactionId = Uuid().v4();
//     String transactionRefId = '123456';
//
//     return 'upi://pay?pa=$payeeUPI&pn=${Uri.encodeComponent(payeeName)}'
//         '&am=$amount&cu=$currency'
//         '&tn=${Uri.encodeComponent(transactionNote)}'
//         '&tid=$transactionId&tr=$transactionRefId';
//   }
//
//   // Function to launch the UPI payment URL
//   Future<void> _launchUpiUrl(BuildContext context) async {
//     final Uri upiUri = Uri.parse(upiUrl);
//
//     try {
//       bool launched = await launchUrl(
//         upiUri,
//         mode: LaunchMode.externalApplication, // Forces the use of external apps
//       );
//       if (!launched) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Could not launch UPI app'))
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error launching UPI app: $e'))
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('UPI Payment')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _launchUpiUrl(context),
//           child: const Text('Pay with UPI'),
//         ),
//       ),
//     );
//   }
// }
