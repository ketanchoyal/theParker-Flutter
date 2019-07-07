// import 'package:flutter/material.dart';
// import 'package:flutter_lottie/flutter_lottie.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   LottieController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SizedBox(
//             width: 150,
//             height: 150,
//             child: LottieView.fromURL(
//               url:
//                   "https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/Watermelon.json",
//               autoPlay: true,
//               loop: true,
//               reverse: true,
//               onViewCreated: onViewCreated,
//             )),
//       ),
//     );
//   }

//   void onViewCreated(LottieController controller) {
//     this.controller = controller;

//     // Listen for when the playback completes
//     this.controller.onPlayFinished.listen((bool animationFinished) {
//       print("Playback complete. Was Animation Finished? " +
//           animationFinished.toString());
//     });
//   }
// }
