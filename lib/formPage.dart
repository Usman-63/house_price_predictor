import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/basement/basement.dart';
import 'package:house_price_predictor/formFeatures/buildingStyle/build_style.dart';
import 'package:house_price_predictor/formFeatures/garage/garage.dart';
import 'package:house_price_predictor/formFeatures/generalinfo/general.dart';
import 'package:house_price_predictor/formFeatures/interorRooms/interior_rooms.dart';
import 'package:house_price_predictor/formFeatures/locationAndNeighborhood/locationAndNeighbhor.dart';
import 'package:house_price_predictor/formFeatures/outdoors/outdoor.dart';
import 'package:house_price_predictor/formFeatures/roofAndExterior/roof_exterior.dart';
import 'package:house_price_predictor/formFeatures/saleAndUtility/sale_utility.dart';
import 'package:house_price_predictor/result_page.dart';
import 'package:house_price_predictor/template.dart';

class FormHandler extends StatefulWidget {
  const FormHandler({super.key});

  @override
  State<FormHandler> createState() => _FormHandlerState();
}

class _FormHandlerState extends State<FormHandler> {
  final _generalInfoformKey = GlobalKey<FormState>();
  final _locationNeighborFormKey = GlobalKey<FormState>();
  final _buildStyleFormKey = GlobalKey<FormState>();
  final _roofInfoFormKey = GlobalKey<FormState>();
  final _basementFormKey = GlobalKey<FormState>();
  final _interiorFormKey = GlobalKey<FormState>();
  final _garageFormKey = GlobalKey<FormState>();
  final _outdoorFormKey = GlobalKey<FormState>();
  final _saleUtilityFormKey = GlobalKey<FormState>();
  final List<bool> _stepValid = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  int _currentStep = 0;

  static const int _totalSteps = 9;
  int _previousStep = 0;

  void _onValidationChanged(int step, bool valid) {
    setState(() {
      _stepValid[step] = valid;
    });
  }

  void _goToStep(int step) {
    if (step >= 0 && step < _totalSteps) {
      setState(() {
        _previousStep = _currentStep;
        _currentStep = step;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> steps = [
      Generalinfo(
        key: const ValueKey('generalinfo'),
        formKey: _generalInfoformKey,
        onValidationChanged: (valid) => _onValidationChanged(0, valid),
      ),
      LocationAndNeighborCard(
        key: const ValueKey('locationneighbor'),
        formKey: _locationNeighborFormKey,
        onValidationChanged: (valid) => _onValidationChanged(1, valid),
      ),
      BuildStyle(
        key: const ValueKey('buildstyle'),
        formKey: _buildStyleFormKey,
        onValidationChanged: (valid) => _onValidationChanged(2, valid),
      ),
      RoofExterior(
        key: const ValueKey("roofExteriro"),
        formKey: _roofInfoFormKey,
        onValidationChanged: (valid) => _onValidationChanged(3, valid),
      ),
      Basement(
        formKey: _basementFormKey,
        onValidationChanged: (valid) => _onValidationChanged(4, valid),
      ),
      InteriorRooms(
        formKey: _interiorFormKey,
        onValidationChanged: (valid) => _onValidationChanged(5, valid),
      ),
      Garage(
        formKey: _garageFormKey,
        onValidationChanged: (valid) => _onValidationChanged(6, valid),
      ),
      Outdoor(
        formKey: _outdoorFormKey,
        onValidationChanged: (valid) => _onValidationChanged(7, valid),
      ),
      SaleUtility(
        formKey: _saleUtilityFormKey,
        onValidationChanged: (valid) => _onValidationChanged(8, valid),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.indigo[500],
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      final isForward = _currentStep >= _previousStep;
                      final beginOffset =
                          isForward ? const Offset(1, 0) : const Offset(-1, 0);
                      final endOffset = Offset.zero;

                      final curved = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutCubic, // Smoother curve
                      );

                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: beginOffset,
                          end: endOffset,
                        ).animate(curved),
                        child: FadeTransition(opacity: curved, child: child),
                      );
                    },
                    child: steps[_currentStep],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed:
                            _currentStep > 0
                                ? () => _goToStep(_currentStep - 1)
                                : null,
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 30,
                        color:
                            _currentStep > 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                      ),
                      if (_currentStep < _totalSteps - 1)
                        IconButton(
                          onPressed:
                              _stepValid[_currentStep]
                                  ? () => _goToStep(_currentStep + 1)
                                  : null,
                          icon: const Icon(Icons.arrow_forward_ios),
                          iconSize: 30,
                          color:
                              _stepValid[_currentStep]
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                        )
                      else
                        ElevatedButton(
                          onPressed:
                              _stepValid[_currentStep]
                                  ? () {
                                    final cleanInput =
                                        convertNumericFieldsToInt(
                                          modelInputTemplate,
                                        );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ResultPage(
                                              inputData: cleanInput,
                                            ),
                                      ),
                                    );
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "comfortaa",
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Add this function anywhere accessible before you pass modelInputTemplate to ResultPage or the API
  Map<String, dynamic> convertNumericFieldsToInt(Map<String, dynamic> input) {
    const numericCols = [
      'Lot Frontage',
      'Lot Area',
      'Mas Vnr Area',
      'BsmtFin SF 1',
      'BsmtFin SF 2',
      'Bsmt Unf SF',
      'Total Bsmt SF',
      '1st Flr SF',
      '2nd Flr SF',
      'Low Qual Fin SF',
      'Gr Liv Area',
      'Bsmt Full Bath',
      'Bsmt Half Bath',
      'Full Bath',
      'Half Bath',
      'Bedroom AbvGr',
      'Kitchen AbvGr',
      'TotRms AbvGrd',
      'Fireplaces',
      'Garage Yr Blt',
      'Garage Cars',
      'Garage Area',
      'Wood Deck SF',
      'Open Porch SF',
      'Enclosed Porch',
      '3Ssn Porch',
      'Screen Porch',
      'Pool Area',
    ];

    final result = Map<String, dynamic>.from(input);
    for (final col in numericCols) {
      final val = result[col];
      if (val != null && val.toString().isNotEmpty) {
        final parsed = int.tryParse(val.toString());
        if (parsed != null) {
          result[col] = parsed;
        }
      }
    }
    return result;
  }
}
