enum PAGES {
  onboarding,
  signin,
  register,
  forgotPassword,
  walletList,
  walletDetail,
  walletNew,
  walletTransaction,
  archivedWalletList,
  error,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.walletList:
        return "/";
      case PAGES.walletDetail:
        return "/wallet";
      case PAGES.walletNew:
        return "/wallet/new";
      case PAGES.walletTransaction:
        return "/wallet/transaction";
      case PAGES.archivedWalletList:
        return "/wallet/archived";
      case PAGES.onboarding:
        return "/onboarding";
      case PAGES.signin:
        return "/signin";
      case PAGES.register:
        return "/register";
      case PAGES.forgotPassword:
        return "/recover";
      case PAGES.error:
        return "/error";

      default:
        return "/";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.walletList:
        return "HOME";
      case PAGES.walletDetail:
        return "DETAIL";
      case PAGES.walletNew:
        return "NEW";
      case PAGES.walletTransaction:
        return "TRANSACTION";
      case PAGES.archivedWalletList:
        return "ARCHIVED-LIST";
      case PAGES.onboarding:
        return "ONBOARDING";
      case PAGES.signin:
        return "SIGNIN";
      case PAGES.error:
        return "ERROR";
      case PAGES.register:
        return "REGISTER";
      case PAGES.forgotPassword:
        return "FORGOT-PASSWORD";
      default:
        return "HOME";
    }
  }
}
