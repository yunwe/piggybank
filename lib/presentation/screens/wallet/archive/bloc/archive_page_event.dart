part of 'archive_page_bloc.dart';

sealed class ArchivePageEvent {
  const ArchivePageEvent();
}

final class ArchivePageWalletsChanged extends ArchivePageEvent {
  const ArchivePageWalletsChanged(this.wallets);

  final List<Wallet> wallets;
}
