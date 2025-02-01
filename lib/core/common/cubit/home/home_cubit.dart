import 'package:bloc/bloc.dart';
import 'package:pulse_max/core/common/cubit/home/home_state.dart';


class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeScreenState(status: HomeScreenStatus.initial));
  
}
