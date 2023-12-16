import 'package:flutter/material.dart';
import 'package:my_street_merchant/utils/hex_color.dart';

import '../../utils/sharedpref_utils.dart';

class AppColors {
  factory AppColors() => AppColors._internal();

  AppColors._internal();

  Color get primaryColor => HexColor("#0060FF");

  Color get backgroundColor => HexColor("#FAFAFB"); //#DCDCDC

  Color get backgroundColor2 => HexColor("#F4F6FF");

  Color get backgroundColor3 => HexColor("#F5F5F5");

  Color get backgroundYellow => HexColor("#FFFCEE");

  Color get textFieldDisabledBackground => HexColor("#F8F8F8");

  Color get textFieldDisabledBorder => HexColor("#E0E0E0");

  Color get black => SharedPrefs().isDarkMode ? Colors.white : Colors.black;

  Color get fontBlack => HexColor("#263238");

  Color get fontBlack2 => HexColor("#2E2E2E");

  Color get fontBlack3 => HexColor("#1F1F1F");

  Color get fontGrey => HexColor("#777171");

  Color get fontGrey2 => HexColor("#8B8888");

  Color get hintGrey => HexColor("#DCDCDC");

  Color get lightGrey => HexColor("#848484");

  Color get lightGrey2 => HexColor("#AAAAAA");

  Color get lightGrey3 => HexColor("#B8B8B8");

  Color get lightGrey4 => HexColor("#ABABAB");

  Color get lightGrey5 => HexColor("#ECECEC");

  Color get fontGreySubtitle => HexColor("#5E5E5E");

  Color get fontLightGrey => HexColor("#A8A8A8");

  Color get darkBlue => HexColor("#001677");

  Color get darkBlue2 => HexColor("#054CC2");

  Color get darkBlue3 => HexColor("#00163A");

  Color get white => HexColor("#FFFFFF");

  Color get grey => HexColor("#EFEFEF");

  Color get grey2 => HexColor("#535353");

  Color get grey3 => HexColor("#E7E7E7");

  Color get grey4 => HexColor("#F4F4F4"); //step

  Color get grey5 => HexColor("#524D4D"); //dropdownArrow

  Color get grey6 => HexColor("#D9D9D9"); //panel

  Color get grey7 => HexColor("#E2E4E8");

  Color get grey8 => HexColor("#EDEDED");

  Color get grey9 => HexColor("#999494");

  Color get grey10 => HexColor("#787878");

  Color get grey11 => HexColor("#B7B7B7");

  Color get grey12 => HexColor("#E1E1E1");

  Color get grey13 => HexColor("#9B9B9B");

  Color get grey14 => HexColor("#363636");

  Color get grey15 => HexColor("#71706F");

  Color get grey16 => HexColor("#F0F0F0");

  Color get grey17 => HexColor("#626262");

  Color get grey18 => HexColor("#EEEEEE");

  Color get grey19 => HexColor("#414040");

  Color get grey20 => HexColor("#696767");

  Color get grey21 => HexColor("#7C7878");


  Color get errorBorderRed => HexColor("#F47577");

  Color get red => HexColor("#D42427");

  Color get red2 => HexColor("#ED6C6E"); //error msg

  Color get red3 => HexColor("#CF2F00");

  Color get red4 => HexColor("#DF240B");

  Color get red5 => HexColor("#FFD3D3");

  Color get red6 => HexColor("#FF7373");

  Color get red7 => HexColor("#FF725E");

  Color get red8 => HexColor("#EE0606");

  Color get red9 => HexColor("#A12500");

  Color get red10 => HexColor("#FFDADA");

  Color get red11 => HexColor("#FFE0E0");

  Color get lightRed => HexColor("#FFA1A1");

  Color get lightRed2 => HexColor("#FFF1F1");

  Color get lightRed3 => HexColor("#FEE6E1");

  Color get warningRed => HexColor("#FFEEEE");

  Color get lightGreen => HexColor("#D6F4C2");

  Color get lightGreen2 => HexColor("#EFFCFF");

  Color get lightGreen3 => HexColor("#F5FFE0");

  Color get lightGreen4 => HexColor("#EBFFF3");

  Color get green => HexColor("#499FA4");

  Color get green2 => HexColor("#D2FFD7");

  Color get green3 => HexColor("#00732F");

  Color get green4 => HexColor("#E1FEE4");

  Color get green5 => HexColor("#F5FFDA");

  Color get green6 => HexColor("#045C02");

  Color get green7 => HexColor("#F0FEF1");

  Color get green8 => HexColor("#007932");

  Color get blue => HexColor("#084ECC");

  Color get blue2 => HexColor("#0051E3");

  Color get blue3 => HexColor("#0038A8");

  Color get lightBlue => HexColor("#337BFC");

  Color get lightBlue2 => HexColor("#DFEAFF");

  Color get lightBlue3 => HexColor("#DCE7FB");

  Color get lightBlue4 => HexColor("#ECF3FF");

  Color get lightBlue5 => HexColor("#EEF1FF");

  Color get lightBlue6 => HexColor("#77A7FF");//avatar

  Color get lightBlue7 => HexColor("#D6E5FF");//avatar

  Color get lightBlue8 => HexColor("#F1F6FF");

  Color get lightBlue9 => HexColor("#EBF2FF");

  Color get lightBlue10 => HexColor("#C2D8FF");

  Color get lightBlue11 => HexColor("#E3EDFF");

  Color get lightBlue12 => HexColor("#F2F6FF");

  Color get lightBlue13 => HexColor("#D3E5FF");

  Color get lightBlue14 => HexColor("#7DADFD");

  Color get lightBlue15 => HexColor("#E1ECFF");

  Color get lightBlue16 => HexColor("#AFCBFC");

  Color get lightBlue17 => HexColor("#EAF0FF");

  Color get lightBlue18 => HexColor("#5792FC");

  Color get lightBlue19 => HexColor("#D2E2FF");

  Color get yellow => HexColor("#FF9636");

  Color get yellow2 => HexColor("#FFFBD3");

  Color get yellow3 => HexColor("#FCD116");

  Color get darkPurple => HexColor("#780CCD");

  Color get purple => HexColor("#FBF1FF");

  Color get purple2 => HexColor("#7389FF");

  Color get purple3 => HexColor("#CBCAF2");

  Color get purple4 => HexColor("#1A056C");

  Color get orange => HexColor("#FA8D50");

  Color get orange2 => HexColor("#D46628");

  Color get newPink => HexColor("#EE06AD");
  Color get newPinkBG => HexColor("#FEF0FA");

  Color get inProgressPurple => HexColor("#780CCD");
  Color get inProgressPurpleBG => HexColor("#FBF1FF");

  Color get deliveredGreen => HexColor("#018225");
  Color get deliveredGreenBG => HexColor("#EFFFE5");

  Color get onTheWayBlue => HexColor("#001677");
  Color get onTheWayBlueBG => HexColor("#E5EDFF");

  Color get cancelled => HexColor("#D87400");
  Color get cancelledBG => HexColor("#FFF7E2");

  Color get publishedBG => HexColor("#D7E5FA");
  Color get publishedText => primaryColor;

  Color get unPublishedBG => HexColor("#D0CFEF");
  Color get unPublishedText => HexColor("#61008F");

  Color get draftBG => HexColor("#F2F0EF");
  Color get draftText => HexColor("#797878");

  Color get archivedBG => HexColor("#D0CFEF");
  Color get archivedText => HexColor("#62008F");

  Color get processingBG => HexColor("#FAF7D8");
  Color get processingText => HexColor("#822F01");

  Color get rejectedBG => HexColor("#FAD8D8");
  Color get rejectedText => red3;

  Color get blueGradient1 => HexColor("#FAFAFA");

  Color get blueGradient2 => HexColor("#E5EFFF");

  Color get blueGradient3 => HexColor("#E5EFFF");

  Color get mainPageGradient1 => HexColor("#FDFEFF");
  Color get mainPageGradient2 => HexColor("#CADCFF");

}
