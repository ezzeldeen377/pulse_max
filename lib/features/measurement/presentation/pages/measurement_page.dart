import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';

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

  final List<FlSpot> _graphData = [];
  int _timeCounter = 0;

  // Define the primary color
  final Color primaryColor = const Color(0xFF1A998E);

  @override
  void initState() {
    super.initState();
    _graphData.add(const FlSpot(0, 0)); // Ensure it's never empty
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
        tpm = 60 + _random.nextInt(61); // Random TPM between 60 and 120
        temperature = 34 + _random.nextInt(7); // Random temperature between 34 and 40

        // Update graph data
        _graphData.add(FlSpot(_timeCounter.toDouble(), tpm.toDouble()));
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
      backgroundColor:  Colors.grey[100],
      appBar: AppBar(
        title: const Text('Real-Time Data and Graph',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor:  Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-time data display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDataCard('Pulse', tpm.toString(), Icons.favorite, 'bpm'),
                _buildDataCard('Temperature', '$temperature °C', Icons.thermostat, '°c'),
              ],
            ),
            const SizedBox(height: 24),

            // Graph section
            Container(
              height: 400.h,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.teal,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: LineChart(
                  LineChartData(
                    // Define the chart's line data
                    lineBarsData: [
                      LineChartBarData(
                        spots: _graphData.isNotEmpty ? _graphData : [const FlSpot(0, 0)],
                        color: Colors.white, // White line color
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        preventCurveOverShooting: true,
                      ),
                    ],
                    // Define the Y and X axis ranges, labels, and appearance
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        axisNameSize: 30, // Allocate space for the axis name
                        axisNameWidget: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            'bpm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameSize: 30, // Allocate space for the axis name
                        axisNameWidget: const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'seconds',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                      drawVerticalLine: true,
                      verticalInterval: 10,
                      horizontalInterval: 20,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.white.withOpacity(0.3), // White grid lines
                          strokeWidth: 1,
                        );
                      },
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white.withOpacity(0.3), // White grid lines
                          strokeWidth: 1,
                        );
                      },
                    ),
                    minY: 40, // Minimum value for Y-axis
                    maxY: 140, // Maximum value for Y-axis
                    backgroundColor: primaryColor, // Chart background color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(String label, String value, IconData icon, String unit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}