import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piggybank/data/firebase/repository/repository_impl.dart';
import 'package:piggybank/domain/channels/user_channel.dart';
import 'package:piggybank/domain/repository/repository.dart';
import 'package:piggybank/domain/usecase/login_usecase.dart';
import 'package:piggybank/domain/usecase/logout_usecase.dart';
import 'package:piggybank/domain/usecase/signup_usercase.dart';

final injector = GetIt.instance;

Future<void> initAppModule() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  injector.registerLazySingleton<Repository>(
    () => FirebaseAuthRepository(),
  );

  injector.registerLazySingleton<UserChannel>(
    () => UserChannel(repository: injector<Repository>()),
  );

  injector.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      injector<Repository>(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    injector.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(injector<Repository>()),
    );
  }
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    injector.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(injector<Repository>()),
    );
  }
}
