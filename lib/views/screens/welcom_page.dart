import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "asses/images/cover.png",
                ),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(0.9),
            Colors.black.withOpacity(0.4),
          ])),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 10,
                  animatedTexts: [
                    FlickerAnimatedText(
                      "Brand New Perspe",
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontFamily: "DancingScript",
                          shadows: [
                            Shadow(
                              blurRadius: 7.0,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedTextKit(totalRepeatCount: 10, animatedTexts: [
                  TypewriterAnimatedText(
                    "Let's Start With Our Summer Collection.",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ]),
                const SizedBox(
                  height: 150,
                ),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/homepage");
                      },
                      child: const Text("Get Start",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
