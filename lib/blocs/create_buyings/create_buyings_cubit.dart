import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/buying.dart';

part 'create_buyings_state.dart';

class CreateBuyingsCubit extends Cubit<CreateBuyingsState> {
  CreateBuyingsCubit() : super(CreateBuyingsInitial());
}
