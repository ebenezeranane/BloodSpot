import 'package:bloodspot/pages/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  List<String> images = [
    'assets/images/image-1.png',
    'assets/images/image-2.png',
    'assets/images/image-3.png'
  ];

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        3,
        (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Center(child: Image.asset(images[index])),
                    ),

                    Center(
                      child: Column(
                        children: const [
                          Text(
                            'Donate Blood , Save Lives',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Simplify the process of blood donation and managing, helping people had never been such easy!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 87, 85, 85),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 3,
                    // ),
                  ],
                ),
              ),
            ));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Text('LET GET STARTED'),
                    SizedBox(width: 220),
                    Text('skip')
                  ],
                ),
              ),
              SizedBox(
                height: 510,
                child: PageView.builder(
                  controller: controller,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                  activeDotColor: Color.fromARGB(255, 243, 70, 58),
                  dotHeight: 12,
                  dotWidth: 12,
                  type: WormType.thin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Container(
                    height: 44.0,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 255, 238, 241),
                      Color.fromARGB(228, 255, 2, 2)
                    ])),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(0, 231, 12, 12),
                          shadowColor: Colors.transparent),
                      child: const Text('        LETS GO        '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
