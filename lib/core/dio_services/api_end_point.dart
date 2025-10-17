abstract class ApiEndPoints {
  // static const String vegetablesData =
  //     'https://redsoftware.notion.site/Vegetable-JSON-7db18acfc4414978a65773b2c41a379f';

  static const String basicUrl = "http://10.0.2.2/fitness";
  static const String uploadUrl = "http://10.0.2.2/fitness/upload";

  static const String login = "$basicUrl/user/auth/login.php";
  static const String register = "$basicUrl/user/auth/signup.php";
  static const String viewMenu = "$basicUrl/user/vegetables/view.php";
  static const String viewDepartments = "$basicUrl/user/departments/view.php";
  static const String menuImages = "$uploadUrl/vegetables";
  static const String coachImages = "$uploadUrl/coaches";
  //cart
  static const String cartAdd = "$basicUrl/user/cart/add.php";
  static const String cartRemove = "$basicUrl/user/cart/remove.php";
  static const String cartview = "$basicUrl/user/cart/view.php";

  //coaches
  static const String viewCoaches = "$basicUrl/coaches/view.php";
  static const String addCoaches = "$basicUrl/coaches/add.php";
  static const String loginCoaches = "$basicUrl/coaches/login.php";
  // static const String viewCoachImage = "$uploadUrl/coaches";

  //chats
  static const String sendMessage = "$basicUrl/user/chats/add.php";
  static const String cardMessage = "$basicUrl/user/chats/cardmessage.php";
  static const String viewMessages = "$basicUrl/user/chats/view.php";
  static const String viewMessagesImage = "$uploadUrl/chats";

  //  monthly renewal
  static const String viewMonthlyRenewal = "$basicUrl/user/monthlyrenewal.php";
  static const String viewOffers = "$basicUrl/admin/offers/view.php";
  static const String viewOffersImages = "$uploadUrl/offers";
}
