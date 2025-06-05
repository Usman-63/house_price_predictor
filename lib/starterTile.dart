import 'package:flutter/material.dart';

class StarterCard extends StatefulWidget {
  final Function? function;
  const StarterCard({Key? key, required this.function}) : super(key: key);
  @override
  _StarterCardState createState() => _StarterCardState();
}

class _StarterCardState extends State<StarterCard> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delay to allow widget to render first
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 600),
        opacity: _opacity,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Card(
            color: Colors.indigo,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'House Price Predictor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Predict the price of a house based on various features.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 2),
                    child: IconButton(
                      onPressed: () {
                        widget.function!();
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
