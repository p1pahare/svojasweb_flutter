import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buying_state.dart';

class BuyingCubit extends Cubit<BuyingState> {
  BuyingCubit() : super(BuyingInitial());

  
}
