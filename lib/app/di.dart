import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piggybank/app/service/network_info.dart';
import 'package:piggybank/data/auth/repository_impl.dart';
import 'package:piggybank/data/transaction/repository_impl.dart';
import 'package:piggybank/data/wallet/repository_impl.dart';
import 'package:piggybank/domain/channels/this_month_saving_channnel.dart';
import 'package:piggybank/domain/channels/user_channel.dart';
import 'package:piggybank/domain/channels/wallets_channel.dart';
import 'package:piggybank/domain/repository/auth_repository.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/create_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/list_transaction_usecase.dart';
import 'package:piggybank/domain/usecase/list_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/login_usecase.dart';
import 'package:piggybank/domain/usecase/logout_usecase.dart';
import 'package:piggybank/domain/usecase/signup_usercase.dart';
import 'package:piggybank/domain/usecase/sum_transaction_usecase.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import 'package:piggybank/firebase_options.dart';

final injector = GetIt.instance;

Future<void> initAppModule() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NetworkInfo networkInfo = NetworkInfo();

  injector.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(networkInfo: networkInfo),
  );
  injector.registerLazySingleton<WalletRepository>(
    () => FirebaseWalletRepository(networkInfo: networkInfo),
  );
  injector.registerLazySingleton<TransactionRepository>(
    () => FirebaseTransactionRepository(networkInfo: networkInfo),
  );

  injector.registerLazySingleton<UserChannel>(
    () => UserChannel(repository: injector<AuthRepository>()),
  );
  injector.registerLazySingleton<WalletsChannel>(
    () => WalletsChannel(repository: injector<WalletRepository>()),
  );
  injector.registerLazySingleton<ThisMonthSavingChannel>(
    () => ThisMonthSavingChannel(),
  );

  injector.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      injector<AuthRepository>(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    injector.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(injector<AuthRepository>()),
    );
  }
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    injector.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(injector<AuthRepository>()),
    );
  }
}

initCreateWalletModule() {
  if (!GetIt.I.isRegistered<CreateWalletUseCase>()) {
    injector.registerLazySingleton<CreateWalletUseCase>(
      () => CreateWalletUseCase(
        injector<WalletRepository>(),
      ),
    );
  }
}

initDetailWalletModule() {
  if (!GetIt.I.isRegistered<GetWalletUseCase>()) {
    injector.registerLazySingleton<GetWalletUseCase>(
      () => GetWalletUseCase(
        injector<WalletRepository>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<ListTransactionUseCase>()) {
    injector.registerLazySingleton<ListTransactionUseCase>(
      () => ListTransactionUseCase(
        injector<TransactionRepository>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<ArchiveWalletUseCase>()) {
    injector.registerLazySingleton<ArchiveWalletUseCase>(
      () => ArchiveWalletUseCase(
        injector<WalletRepository>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<DeleteWalletUseCase>()) {
    injector.registerLazySingleton<DeleteWalletUseCase>(
      () => DeleteWalletUseCase(
        injector<WalletRepository>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<UpdateAmountUseCase>()) {
    injector.registerLazySingleton<UpdateAmountUseCase>(() => UpdateAmountUseCase(
          transactionRepository: injector<TransactionRepository>(),
          walletRepository: injector<WalletRepository>(),
          thisMonthSavingChannel: injector<ThisMonthSavingChannel>(),
        ));
  }
}

initListWalletModule() {
  if (!GetIt.I.isRegistered<ListWalletUseCase>()) {
    injector.registerLazySingleton<ListWalletUseCase>(
      () => ListWalletUseCase(
        injector<WalletRepository>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<SumTransactionUseCase>()) {
    injector.registerLazySingleton<SumTransactionUseCase>(
      () => SumTransactionUseCase(
        injector<TransactionRepository>(),
      ),
    );
  }
}
