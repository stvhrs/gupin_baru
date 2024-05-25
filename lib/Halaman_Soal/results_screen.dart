
import 'package:Bupin/Halaman_Soal/results_card.dart';
import 'package:Bupin/styles/capital.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key,
      required this.score,required this.color,
      required this.totalQuestions,
      required this.whichTopic});
      final Color color;
  final int score;
  final int totalQuestions;
  final String whichTopic;

  @override
  Widget build(BuildContext context) {
    
    print(score);
    print(totalQuestions);
    final double percentageScore = (score / totalQuestions) * 100;
    final int roundedPercentageScore = percentageScore.round();
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: color,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(textAlign: TextAlign.center,
                           whichTopic.toTitleCase(),
                          style:
                              Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                        
                                          
                                          
                                        
                                      ),
                      ),
              ResultsCard(
                  roundedPercentageScore: roundedPercentageScore,
                  bgColor3: color),
              const SizedBox(
                height: 25,
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(cardColor),
              //     fixedSize: MaterialStateProperty.all(
              //       Size(MediaQuery.sizeOf(context).width * 0.80, 40),
              //     ),
              //     elevation: MaterialStateProperty.all(4),
              //   ),
              //   onPressed: () {
              //     Navigator.popUntil(context, (route) => route.isFirst);
              //   },
              //   child: const Text(
              //     "Take another test",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
