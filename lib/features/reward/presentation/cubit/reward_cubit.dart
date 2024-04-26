import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reward_state.dart';

class RewardCubit extends Cubit<RewardState> {
  RewardCubit() : super(RewardInitial());
}
