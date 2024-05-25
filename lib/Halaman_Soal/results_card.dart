import 'package:Bupin/Halaman_Soal/dotted_lines.dart';
import 'package:flutter/material.dart';

class ResultsCard extends StatelessWidget {
  const ResultsCard({
    super.key,
    required this.roundedPercentageScore,
    required this.bgColor3,
  });

  final int roundedPercentageScore;
  final Color bgColor3;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.888,
      height: MediaQuery.of(context).size.height * 0.568,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Skor Anda",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                          ),

                          //m'adamfo(Twi) - my friend
                         
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                border: Border.all(
                                    color: roundedPercentageScore >= 75
                                        ? Colors.green
                                        : Colors.red.shade800,
                                    width: 5),
                               ),
                            child: Text(
                              "$roundedPercentageScore",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900,
                                      color: roundedPercentageScore >= 75
                                          ? Colors.green
                                          : Colors.red.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: DrawDottedhorizontalline(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: roundedPercentageScore >= 75
                            ? Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mantap !! Latihanmu membuahkan Hasil",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,color: Colors.grey.shade700,fontSize: 17
                                        ),
                                  ),
                                  Image.asset("asset/happy.png",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2),
                                ],
                              )
                            : Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sepertinya kamu harus berlatih lagi",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,color: Colors.grey.shade700,fontSize: 17
                                        ),
                                  ),
                                  Image.asset("asset/sad.png",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2),
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: -10,
            top: MediaQuery.of(context).size.height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
                   BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: -10,
            top: MediaQuery.of(context).size.height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
                   BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
