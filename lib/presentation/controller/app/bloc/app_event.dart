part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}
