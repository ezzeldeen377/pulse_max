import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/env/env.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Map<String, dynamic>>?> getDoctorList(String? category);
  Future<Unit> createDoctor(DoctorModel doctor);
  Future<Unit> updateDoctor(DoctorModel doctor);
  Future<Unit> deleteDoctor(DoctorModel doctor);
  Future<Unit> createAppointment(AppointmentModel app);
  
}
@Injectable(as:DoctorRemoteDataSource)
class DoctorRemoteDataSourceImpl extends DoctorRemoteDataSource {
  final firestore=FirebaseFirestore.instance;

   CollectionReference get doctorCollection => firestore.collection(Env.doctorsTable);
   CollectionReference get appointmentCollection => firestore.collection('appointments');
  
  @override
  Future<Unit> createDoctor(DoctorModel doctor) async {
     await doctorCollection.doc(doctor.uid).set(doctor.toMap());
     return Future.value(unit);
    
  }
  
  @override
  Future<Unit> deleteDoctor(DoctorModel doctor) async {
    var docRef =  doctorCollection.doc(doctor.uid);
    await docRef.delete();
    return Future.value(unit);

  }
  
  @override
  Future<List<Map<String, dynamic>>?> getDoctorList(String? category) async {
    if(category!=null){
         var querySnapshot  =await doctorCollection.where('specialization',isEqualTo: category).get();
   return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    }
   var querySnapshot  =await doctorCollection.get();

   return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  

  
  @override
  Future<Unit> updateDoctor(DoctorModel doctor) async {
    var docRef =  doctorCollection.doc(doctor.uid);
    await  docRef.update(doctor.toMap());
    return Future.value(unit);
  
}

  @override
  Future<Unit> createAppointment(AppointmentModel app) async {
    var docRef =  appointmentCollection.doc();
     app.appointmentId=docRef.id;
     await docRef.set(app.toMap());
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
