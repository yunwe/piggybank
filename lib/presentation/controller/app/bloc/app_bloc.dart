import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/channels/user_channel.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/logout_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
      {required UserChannel userChannel, required LogoutUseCase logoutUseCase})
      : _userChannel = userChannel,
        _logoutUsecase = logoutUseCase,
        super(
          const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _userChannel.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final UserChannel _userChannel;
  late final StreamSubscription<User> _userSubscription;

  final LogoutUseCase _logoutUsecase;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(
      _logoutUsecase.execute(
        LogoutUseCaseInput(),
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
