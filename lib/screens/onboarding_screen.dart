import 'package:flutter/material.dart';
import 'package:recipe_app/constants/images_path.dart';
import 'package:recipe_app/screens/home.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: h * .79,
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesPath.onBoarding),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: h * .274,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: h * .032),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Resep Makanan",
                          style: TextStyle(
                            fontSize: w * .06,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: h * .01),
                        const Text(
                          "Ciptakan masakanmu menjadi lebih berasa..!",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(height: h * .032),
                        SizedBox(
                          width: w * .8,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color.fromARGB(112, 219, 125, 63),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              "Mulai",
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 151, 56),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
