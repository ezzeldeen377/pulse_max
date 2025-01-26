import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/env/env.dart';
import 'package:pulse_max/features/doctor/data/models/doctor_model.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Map<String, dynamic>>?> getDoctorList();
  Future<Unit> createDoctor(DoctorModel doctor);
  Future<Unit> updateDoctor(DoctorModel doctor);
  Future<Unit> deleteDoctor(DoctorModel doctor);
  void listen(Function(List<DoctorModel>) callback);
}
@Injectable(as:DoctorRemoteDataSource)
class DoctorRemoteDataSourceImpl extends DoctorRemoteDataSource {
  final firestore=FirebaseFirestore.instance;

   CollectionReference get doctorCollection => firestore.collection(Env.doctorsTable);
  
  @override
  Future<Unit> createDoctor(DoctorModel doctor) async {
     var docRef =  doctorCollection.doc();
     doctor.id=docRef.id;
     await docRef.set(doctor.toJson());
     return Future.value(unit);
    
  }
  
  @override
  Future<Unit> deleteDoctor(DoctorModel doctor) async {
    var docRef =  doctorCollection.doc(doctor.id);
    await docRef.delete();
    return Future.value(unit);

  }
  
  @override
  Future<List<Map<String, dynamic>>?> getDoctorList() async {
   var querySnapshot  =await doctorCollection.get();

   return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  
@override
void listen(Function(List<DoctorModel>) callback) {
  FirebaseFirestore.instance
      .collection(Env.doctorsTable) // Replace Env.doctorsTable with your collection name
      .snapshots()
      .listen((QuerySnapshot snapshot) {
        List<DoctorModel> doctors = [];

        try {
          // Parse each document in the snapshot into a DoctorModel
          for (var doc in snapshot.docs) {
            doctors.add(DoctorModel.fromJson(doc.data() as Map<String, dynamic>));
          }

          // Pass the parsed list to the callback
          callback(doctors);
        } catch (e) {
          // Handle errors in parsing
          print('Error parsing doctor data: $e');
        }
      });
}

  
  @override
  Future<Unit> updateDoctor(DoctorModel doctor) async {
    var docRef =  doctorCollection.doc(doctor.id);
    await  docRef.update(doctor.toJson());
    return Future.value(unit);
  
}

  
}
// class DoctorRemoteDataSourceImpll
//     implements DoctorRemoteDataSource<DoctorModel> {
//   final SupabaseClient supabase;

//   const DoctorRemoteDataSourceImpll({required this.supabase});

//   @override
//   Future<Unit> createDoctor(DoctorModel doctor) async {
//     await supabase.from(Env.doctorsTable).insert(doctor.toJson(),);
//     return Future.value(unit);
//   }

//   @override
//   Future<Unit> deleteDoctor(DoctorModel doctor) async {
//     await supabase.from(Env.doctorsTable).delete().eq('id', doctor.id as Object);
//     return Future.value(unit);
//   }

//   @override
//   Future<List<Doctor>> getDoctorList() async {
//     final data = await supabase.from(Env.doctorsTable).select();

//     return data.map((doctor) => DoctorModel.fromJson(doctor)).toList();
//   }

//   @override
//   Future<Unit> updateDoctor(DoctorModel doctor) async {
//     await supabase
//         .from(Env.doctorsTable)
//         .update(doctor.toJson())
//         .eq('id', doctor.id as Object);
//     return Future.value(unit);
//   }

//   @override
//   RealtimeChannel listen(Function(List<DoctorModel>) callback) {
//     return supabase
//         .channel('public:${Env.doctorsTable}')
//         .onPostgresChanges(
//           event: PostgresChangeEvent.all,
//           schema: 'public',
//           table: Env.doctorsTable,
//           callback: (PostgresChangePayload payload) {
//             List<DoctorModel> doctors = [];
//             // FIXME: cannot parse payload correctly
//             for (var load in payload.newRecord.values) {
//               doctors.add(DoctorModel.fromJson(load));
//             }

//             callback(doctors);
//           },
//         )
//         .subscribe();
//   }
// }
