import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final List<FlSpot> realTimeData = [];
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
        tpm = 60 + _random.nextInt(100);
        temperature = 20 + _random.nextInt(80); // Temperature in range 20-100
        rpm = 500 + _random.nextInt(3500); // RPM in range 500-4000

        // Update graph data
        _graphData.add(FlSpot(_timeCounter.toDouble(), tpm.toDouble()));
        realTimeData.add(FlSpot(_timeCounter.toDouble(), tpm.toDouble()));
        _timeCounter++;

        // Keep only the latest 20 points
        if (_graphData.length > 20) {
          _graphData.removeAt(0); // Remove the oldest value
        }
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
            SizedBox(
              height: 400.h,
              child: LineChart(
                LineChartData(
                  // Define the chart's line data
                  lineBarsData: [
                    LineChartBarData(
                      spots: _graphData,
                      isCurved: true,
                      color: Colors.white, // White line color
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  // Define the Y and X axis ranges, labels, and appearance
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          'TPM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 50, // Show labels every 50 units
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Seconds',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2, // Show labels every 2 seconds
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                  // Define the chart's visual appearance
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.white, width: 2),
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval:
                        50, // Gridlines every 50 units on Y-axis
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color:
                            Colors.white.withOpacity(0.5), // White grid lines
                        strokeWidth: 1,
                      );
                    },
                  ),
                  minY: 0, // Minimum value for Y-axis
                  maxY: 200, // Maximum value for Y-axis
                  backgroundColor: Colors.red, // Red background
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
