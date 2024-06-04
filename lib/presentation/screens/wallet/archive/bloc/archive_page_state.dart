part of 'archive_page_bloc.dart';

class ArchivePageState extends Equatable {
  const ArchivePageState({required this.wallets});

  final List<Wallet> wallets;

  @override
  List<Object?> get props => [wallets];
}
