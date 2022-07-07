import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_quote_state.dart';

class CreateQuoteCubit extends Cubit<CreateQuoteState> {
  CreateQuoteCubit() : super(CreateQuoteInitial());
}
