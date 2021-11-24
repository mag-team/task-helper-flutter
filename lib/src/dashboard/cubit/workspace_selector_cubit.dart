import 'package:flutter_bloc/flutter_bloc.dart';

class WorkspaceSelectorCubit extends Cubit<String?> {
  WorkspaceSelectorCubit() : super(null);

  void setWorkspace(String? value) => emit(value);
}
