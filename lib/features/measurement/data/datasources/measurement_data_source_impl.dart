import 'dart:async';
import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/measurement/data/datasources/measurement_data_source.dart';
import 'package:pulse_max/features/measurement/data/models/measurement_model.dart';
import 'package:firebase_database/firebase_database.dart';

@Injectable(as: MeasurementDataSource)
class MeasurementDataSourceImpl implements MeasurementDataSource {
  final _controller = StreamController<
      MeasurementModel>();
        StreamSubscription<DatabaseEvent>? _subscription;
          final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("sensors");


  Timer? _timer;
  final Random _random = Random();
  bool _isGenerating = false;

  @override
  Stream<MeasurementModel> getMeasurements() {
    if (!_isGenerating) {
      _startListeningToFirebase();
      _isGenerating = true; // Ensure the generator starts only once
    }
    return _controller.stream;
  }
    void _startListeningToFirebase() {
          int _counter = 0;

    _subscription ??= _dbRef.onValue.listen((event) {
      if (event.snapshot.exists) {
          _counter++; // Increment counter every second

      int pulse;
      if (_counter % 10 == 0) {
        // Every 10 seconds, spike the heart rate
        pulse = 101 + _random.nextInt(30); // Random pulse between 101 and 130
      } else {
        // Normal heart rate range
        pulse = 80 + _random.nextInt(11);
      }
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        final measurement = MeasurementModel(
          pulse: pulse,
          temperature: data["temperature"] ?? 0.0,
          voltage: data["ecgVoltage"] ?? 0.0,
        );
        _controller.add(measurement);
      }
    });
  }
  // void _startGeneratingData() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     _counter++; // Increment counter every second

  //     int pulse;
  //     if (_counter % 10 == 0) {
  //       // Every 10 seconds, spike the heart rate
  //       pulse = 101 + _random.nextInt(30); // Random pulse between 101 and 130
  //     } else {
  //       // Normal heart rate range
  //       pulse = 80 + _random.nextInt(11);
  //     }

  //     final temperature =
  //         34 + _random.nextInt(7); // Random temperature between 34 and 40

  //     final measurement = MeasurementModel(
  //       pulse: pulse,
  //       temperature: temperature,
  //       timestamp: DateTime.now(),
  //     );

  //     _controller.add(measurement);
  //   });
  // }

  @override
  void dispose() {
    _timer?.cancel();
  }
}
