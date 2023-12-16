import 'package:country_picker/country_picker.dart';

class CommonConsts {
  static const String success = "Success";
  static const String passwordChanged = "Password Changed Successfully";
  static const String termsURL = "terms.html";
  static const String ppURL = "privacy.html";
  static const String supportEmail = "support@g.com";
}

class CurrentStep {
  static const String home = "home";
  static const String verifyEmail = "VerifyEmail";
  static const String createStore = "StoreCreation";
  static const String setUpLocation = "UpdateLocation";
  static const String setUpCurrency = "UpdateCurrency";
  static const String setUpContact = "UpdateContact";
  static const String verifyPhone = "ConfirmMobile";
  static const String selectCategories = "SelectCategories";
  static const String paymentInfo = "PaymentMethod";
  static const String profileIsAlmostReady = "ProfileIsAlmostReady";
  static const String profileIsComplete = "ProfileIsComplete";
}

class PromoCodeStatus{
  static const active="active";
  static const inActive="inactive";
  static const archive="archive";
  static const deleted="deleted";
}

class OrderStatus{
  static const newStatus="new";
  static const inProgress="in_progress";
  static const delivered="delivered";
  static const onTheWay="on_the_way";
  static const cancelled="cancelled";
}

class FilterDatePeriod{
  static const oneMonth="one_month";
  static const sixMonths="six_months";
  static const oneYear="one_year";
  static const custom="custom";
}

class DiscountBasedOn{
  static const newPrice="new_price";
  static const discount="discount";
}

class StockStatus{
  static const inStock="in_stock";
  static const outOfStock="out_of_stock";
  static const limitedStock="limited_stock";
  static const processing="processing";
}

class ProductStatus{
  static const draft="draft";
  static const published="published";
  static const unpublished="unpublished";
  static const processing="processing";
  static const rejected="rejected";
  static const archived="archived";
}
class IntegratedProductStatus{
  static const available="available";
  static const unavailable="unavailable";
  static const integrated="integrated";
}

class ProductType{
  static const custom="custom";
  static const integrated="integrated";
}

class SelectedPlatform{
  static const shopify="shopify";
  static const woocommerce="woocommerce";
  static const bigcommerce="bigcommerce";
}

Country defaultCountry = Country(
    phoneCode: "971",
    countryCode: "AE",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "United Arab Emirates",
    example: "501234567",
    displayName: "United Arab Emirates (AE) [+971]",
    displayNameNoCountryCode: "United Arab Emirates (AE)",
    e164Key: "971-AE-0");




