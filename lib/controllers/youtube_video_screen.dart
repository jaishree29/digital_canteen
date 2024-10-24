// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YouTubeVideoScreen extends StatefulWidget {
//   const YouTubeVideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _YouTubeVideoScreenState createState() => _YouTubeVideoScreenState();
// }
//
// class _YouTubeVideoScreenState extends State<YouTubeVideoScreen> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the YouTube player with a YouTube video ID
//     _controller = YoutubePlayerController(
//       initialVideoId: 'xBTGln828Ps', // Example: replace with your YouTube video ID
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('YouTube Video'),
//       ),
//       body: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.red,
//         onReady: () {
//           print('Player is ready.');
//         },
//       ),
//     );
//   }
// }
