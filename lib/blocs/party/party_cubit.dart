import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'party_state.dart';

class PartyCubit extends Cubit<PartyState> {
  PartyCubit() : super(PartyInitial());
}
