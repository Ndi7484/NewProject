import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/models/account_models.dart';
import 'package:flutter_application_1/core/models/others_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState());

  bool selectAccount(String email, String password) {
    emit(state.copyWith(status: RequestLoading.loading));
    emit(state.copyWith(status: RequestLoading.success));
    return state.checkAccount(email: email, password: password);
  }
}
