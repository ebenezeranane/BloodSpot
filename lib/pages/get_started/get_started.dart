
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  List<String> images = ['assets/images/image-1.png',
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
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Container(
                      
                      height: 400,
                      child: Center(child: Image.asset(images[index])),
                    ),

                    const Center(
                      child: Text('Donate Blood , Save Lives',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                      ),

                      
                    ),
                    const SizedBox(height: 5,),
                     const Center(
                      child: Text('Simplify the process of blood donation and managing, helping people had never been such easy!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                      ),

                      

                      
                    ),
                    const SizedBox(height:28),
                    Center(
                      child: Container(
                       height: 44.0,
                      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 238, 241), Color.fromARGB(228, 255, 2, 2)])),
                      child: ElevatedButton(
                     onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(0, 231, 12, 12), shadowColor: Colors.transparent),
                     child: const Text('        LETS GO        '),
  ),
),
                      )
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
                padding: const EdgeInsets.all(12.0),
                child: Row(

                  children: const [
                   
                    Text('LET GET STARTED'),
                    SizedBox(width: 220),
                    Text('skip')


                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 555,
                child: PageView.builder(
                  controller: controller,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 12),
                
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
            ],
          ),
        ),
      ),
    );
  }
}


