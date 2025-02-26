import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/helpers/notification_service.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/features/measurement/presentation/cubit/measurement_cubit.dart';

class MeasurementPage extends StatelessWidget {
   MeasurementPage({super.key});

  final Color primaryColor = const Color(0xFF1A998E);

  final List<FlSpot> _graphData = [];

  int _timeCounter = 0;

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
      body: BlocBuilder<MeasurementCubit, MeasurementState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isError) {
            return Center(child: Text(state.errorMessage ?? 'An error occurred'));
          }

          if (state.status.isSuccess && state.measurement != null) {
            final measurement = state.measurement!;
            
            // Update graph data
            _graphData.add(FlSpot(_timeCounter.toDouble(), measurement.voltage?.toDouble()??0));
            _timeCounter++;

            // Keep only the latest 20 points
            if (_graphData.length > 20) {
              _graphData.removeAt(0);
            }

            // Show notification if pulse is 100 or higher
            if (measurement.pulse! >= 100) {
              NotificationService.dangerAlert(measurement.pulse?.toInt()??100);
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-time data display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDataCard('Pulse', measurement.pulse.toString(), Icons.favorite, 'bpm'),
                      _buildDataCard('Temperature', measurement.temperature!.toStringAsFixed(1), Icons.thermostat, '°C'),
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
                            'voltage',
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
                      verticalInterval: 1,
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
                    minY: 0, // Minimum value for Y-axis
                    maxY: 10, // Maximum value for Y-axis
                    backgroundColor: primaryColor, // Chart background color
                  ),
                ),
              ),
            ),
                ],
              ),
            );
          }

          return const Center(child: Text('Start measuring...'));
        },
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