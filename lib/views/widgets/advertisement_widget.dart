import 'package:flutter/material.dart';

class Advertisement extends StatelessWidget {
  final Color? backgroundCard;
  final Color? buttomColor;
  final Color? buttomTextColor;
  const Advertisement(
      {this.backgroundCard, this.buttomColor, this.buttomTextColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: backgroundCard ?? const Color(0xfffaebd7)),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "asses/images/bags.png",
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 22, top: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text("20% OFF DURING THE WEEKEND",
                                style: TextStyle(
                                    color: buttomTextColor ?? Color(0xffcd9575),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700))),
                        const SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttomColor ?? Color(0xfffbceb1)),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Get Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: buttomTextColor ?? const Color(0xffcd9575)),
                          ),
                        ))
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
