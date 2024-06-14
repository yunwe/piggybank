class AppStrings {
  //Common Widgets
  static const String selectDate = 'Select Date';

  //Authentication
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String registerText = "Don't have a account? REGISTER HERE";
  static const String signinText = "Already have an account? Log In";
  static const String titleSignin = "Sign In";
  static const String titleRegister = "Sign Up";
  static const String forgotPw = "Reset Password";
  static const String titleMailSent = 'Your email is on the way';
  static const String textMailSent =
      'Check your email test@test.com and follow the instructions to reset your password';
  static const String titleHome = "My Savings";
  static const String hintUserName = "Username";
  static const String hintPw = "Password";
  static const String hintConfirmPw = "Confirm Password";
  static const String hintEmail = "Email";
  static const String labelLogin = "Login";
  static const String labelLogout = "Log Out";
  static const String labelSignup = "Sign up";
  static const String labelReset = "Send a reset email.";
  static const String errorInvalidPassword =
      'Password must be at least 8 characters and contain at least one letter and number';
  static const String errorEmptyPassword = 'Please enter a password';
  static const String errorShortUsername =
      'Username must be at least 4 characters.';
  static const String errorLongUsername =
      'Username must not be more than 30 characters.';
  static const String errorEmptyUsername = 'Username must not be empty';
  static const String errorMismatch = 'Passwords do not match.';

  //Onboarding
  static const String onBoardingTitle1 = 'Welcome to SaveUp';
  static const String onBoardingTitle2 = 'Track your savings';
  static const String onBoardingTitle3 = 'Achieve your goals';

  static const String onBoardingSubtitle1 =
      'Start your journey to financial freedom with SaveUp';
  static const String onBoardingSubtitle2 =
      'Easily monitor your savings and set achievable goals';
  static const String onBoardingSubtitle3 =
      'Reach your financial milestones and secure your future';

  static const String skip = 'Skip';

  //Home
  static const String titleDrawer = 'Saving Up!';
  static const String archive = 'Archived Goals';
  static const String rateUs = 'Rate the App';
  static const String removeAd = 'Rate the App';

  static const String labelGoals = 'Goals';
  static const String labelThisMonth = 'This Month';
  static const String labelLastMonth = 'Last Month';
  static const String titleCurrent = 'Current Goals';

  static const String noArchive = 'No archived goal.';

  //Wallet
  static const String errorEmptyInput = 'This must not be empty';
  static const String errorNotANumber = 'This must be a number';
  static const String errorLessThanZero = 'Input must be larger than zero.';

  static const String errorShortWalletname = 'Must be at least 4 characters.';
  static const String errorLongWalletname =
      'Must not be more than 30 characters.';
  static const String errorInvalidTargetDate = 'Must be within 3 years.';
  static const String errorLongRemark = 'Must not be more than 35 characters.';

  static const String titleCreate = 'Create New Goal';
  static const String labelSetTarget = 'Set Target';
  static const String labelTargetAmount = 'Target Amount';
  static const String labelCreate = 'Create Goal';
  static const String hintAmount = 'Amount';
  static const String hintRemark = 'Remark';

  static const String titleConfirmArchive = 'Archive';
  static const String contentConfirmArchive =
      'Archived wallet can no longer be editable.\n'
      'But, you can still view it in the archived list.';
  static const String titleConfirmDelete = 'Delete';
  static const String contentConfirmDelete =
      'Deleted wallet can no longer be accessible';
  static const String labelArchive = 'Archive';
  static const String labelDelete = 'Delete';

  static const String labelRetry = 'Retry';
  static const String textNoAuth = 'No Authentication.';

  static const String titleError = 'Error';
  static const String labelBackToHome = 'Back to Home';
  static const String messageWalletArchived =
      '\'%1\$\' is successfully archived.';

  static const String messageCreateWallet = 'Create your financial goal.';

  static const String noWallet = 'No Wallet Found';

  static const String labelWithdrawl = 'I need to withdraw money.';
  static const String labelSaving = 'I want to save up.';
  static const String labelWithdrawlButton = 'Withdrawl';
  static const String labelSavingButton = 'Save Up';

  static const String titleUpdate = 'Update';
  static const String messageExceedingFund =
      'Withdrawl amount is exceeding saving fund.';
  static const String messageWithdrawn = '\'%1\$\' is withdrawn from \'%2\$\'.';
  static const String messageAddedFund = '\'%1\$\' is added to  \'%2\$\'.';
  static const String labelBalance = 'Balance';

  //Report
  static const String startedOn = 'Started on \'%1\$\'.';
  static const String archivedOn = 'Archived on \'%1\$\'.';
  static const String activeFor = 'Active for %1\$.';
  static const String endIn = 'End in %1\$.';
  static const String avgSaving = 'Average Saving : \$%1\$';
  static const String labelStartDate = 'Start Date : %1\$';
  static const String labelAmountToSave = 'Amount To Save : \$%1\$';
  static const String labelCurrent = 'Current Saving : \$%1\$';
  static const String labelHistory = 'History';
  static const String noHistory = 'No transaction.';
  static const String titleMonthlyReport = 'Monthly Report';
  static const String viewDetail = 'View Detail';
  static const String savingPeriod = 'Saving period was %1\$.';
  static const String avgSavingPerM = 'Average saving per month was \$%1\$.';
  static const String succeed = 'You have achieved your target.';
  static const String savedPercent = 'Saved %1\$% of your target.';
  static const String targetAmt = 'Target amount was \$%1\$.';
  static const String titleTargetReached = 'Move to Archive';
  static const String targetDateReached =
      'Target date has reached.\nYou can no longer add new transactions to this goal.';
  static const String targetAmountReached =
      'Congratulations.\nYou have achieved saving goal for \'%1\$\'.';
}
