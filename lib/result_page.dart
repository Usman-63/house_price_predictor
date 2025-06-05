import 'package:flutter/material.dart';
import 'api/http_handler.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  final Map<String, dynamic> inputData;
  const ResultPage({super.key, required this.inputData});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> _futureResult;
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    _futureResult = HttpHandler.predict(widget.inputData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 24),
                  Text(
                    "Predicting house price...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "Failed to get prediction.",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Try Again"),
                    onPressed: () {
                      setState(() {
                        _futureResult = HttpHandler.predict(widget.inputData);
                        showDetails = false;
                      });
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final prediction = snapshot.data?['prediction'] ?? "N/A";
            final List<dynamic> topFeatures =
                snapshot.data?['top_features'] ?? [];

            return Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: min(MediaQuery.of(context).size.width * 0.95, 500),
                child: Card(
                  elevation: 12,
                  color: theme.colorScheme.surface,
                  shadowColor: theme.colorScheme.primary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState:
                          showDetails
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                      firstChild: SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_rounded,
                                size: 70,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Estimated House Price",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                  color: theme.colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _formatCurrency(prediction),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.secondary,
                                  fontSize: 34,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 28),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.bar_chart,
                                  color: Colors.white,
                                ),
                                label: const Text("Show Details"),
                                onPressed: () {
                                  setState(() {
                                    showDetails = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextButton.icon(
                                icon: const Icon(Icons.arrow_back),
                                label: const Text("Back"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      secondChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bar_chart_rounded,
                            size: 60,
                            color: theme.colorScheme.secondary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Estimated House Price",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatCurrency(prediction),
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                              fontSize: 28,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "Top Feature Importances",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _FeatureImportanceChart(features: topFeatures),
                          const SizedBox(height: 28),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.expand_less,
                              color: Colors.white,
                            ),
                            label: const Text("Hide Details"),
                            onPressed: () {
                              setState(() {
                                showDetails = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.secondary,
                              foregroundColor: theme.colorScheme.onSecondary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Back"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data received."));
          }
        },
      ),
    );
  }

  String _formatCurrency(dynamic value) {
    if (value == null) return "N/A";
    try {
      final numVal = value is num ? value : num.tryParse(value.toString());
      if (numVal == null) return value.toString();
      return "\$${numVal.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
    } catch (_) {
      return value.toString();
    }
  }
}

class _FeatureImportanceChart extends StatelessWidget {
  final List<dynamic> features;
  const _FeatureImportanceChart({required this.features});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (features.isEmpty) {
      return const Text("No feature importance data.");
    }

    // Find the max importance for scaling
    final maxImportance = features
        .map((f) => (f['importance'] as num?) ?? 0)
        .fold<num>(0, max);

    return Column(
      children:
          features.map((feature) {
            final name = feature['name']?.toString() ?? '';
            final importance = (feature['importance'] as num?) ?? 0;
            final barWidth =
                (importance / (maxImportance == 0 ? 1 : maxImportance)) * 200;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 22,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: barWidth,
                        height: 22,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
