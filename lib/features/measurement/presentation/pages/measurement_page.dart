import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({super.key});

  @override
  createState() => _MeasurementPage();
}

class _MeasurementPage extends State<MeasurementPage> {
  final Random _random = Random();
  late Timer _timer;

  int tpm = 0;
  int temperature = 0;
  int rpm = 0;

  final List<FlSpot> _graphData = [];
  int _timeCounter = 0;

  @override
  void initState() {
    super.initState();
    _startUpdatingData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startUpdatingData() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Generate random values
        tpm = _random.nextInt(100);
        temperature = 20 + _random.nextInt(80); // Temperature in range 20-100
        rpm = 500 + _random.nextInt(3500); // RPM in range 500-4000

        // Update graph data
        _graphData.add(FlSpot(_timeCounter.toDouble(), tpm.toDouble()));
        _timeCounter++;

        // Keep only the latest 10 points for the graph
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Data and Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-time data display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDataCard('TPM', tpm.toString()),
                _buildDataCard('Temperature', '$temperature °C'),
                _buildDataCard('RPM', rpm.toString()),
              ],
            ),
            const SizedBox(height: 24),

            // Graph section
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _graphData,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
