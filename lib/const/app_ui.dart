import 'package:flutter/material.dart';

class AppUi {
  static const pageContentPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 24);

  static const cardBorderRadius = Radius.circular(4.0);
  static const cardMargin = EdgeInsets.only(top: 16.0, left: 27.0, right: 27.0);
  static const cardPadding = EdgeInsets.all(10.0);
  static const cardDivider = Divider(height: 16.0);
  static const listDivider = Divider(height: 0.0);
  static const listPadding = EdgeInsets.all(10.0);
  static const listPaddingFilter =
      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0);
  static const bannerDescriptionPadding = EdgeInsets.all(16.0);

  static const cardElementMarginBottom = EdgeInsets.only(bottom: 6.0);
  static Container cardElementMarginBottomContainer =
      Container(margin: cardElementMarginBottom);

  static const floatingButtonLocation =
      FloatingActionButtonLocation.centerFloat;
  static const floatingActionButtonPadding =
      EdgeInsets.symmetric(horizontal: 16);

  static const bottomSheetRadius = Radius.circular(10.0);
  static const bottomSheetContentMargin = EdgeInsets.all(16.0);

  static const verticalSpaceSmall = SizedBox(height: 8.0);
  static const verticalSpace = SizedBox(height: 16.0);
  static const buttonMinSize = Size(0, 44.0);

  static Image imageMainPageBannerInvoice =
      Image.asset('img/banner_invoice.png');
  static Image imageMainPageBannerInvoiceOut =
      Image.asset('img/banner_invoice_out.png');
  static Image imageMainPageBannerInventory = Image.asset(
    'img/banner_inventory.png',
    // color: F3MobileColors.textColorDisabled,
    // colorBlendMode: BlendMode.color,
  );
  static Image imageMainPageBannerDisassembling = Image.asset(
    'img/banner_disassembling1.png',
    //  color: F3MobileColors.textColorDisabled,
    // colorBlendMode: BlendMode.color,
  );

  static Image imageBannerNoData = Image.asset('img/banner_no_data.png');
  static Image imageBannerError = Image.asset('img/banner_error.png');
  static Image imageBannerNoConnection =
      Image.asset('img/banner_no_connection.png');
  static Image imageQrCodeExample = Image.asset('img/banner_qr_code.png');
  static Image imageBannerInfo = Image.asset('img/banner_info.png');
  static Image imagePinCodeBanner = Image.asset('img/pincode.png');
  static Image imageBannerFirstSgtin =
      Image.asset('img/banner_first_gtin_load.png');
  static Image imageBadKiz = Image.asset(
    'img/icons/badkiz.png',
    //color: F3MobileColors.textColorDisabled,
    //colorBlendMode: BlendMode.color,
  );
  static Image imageSickGopher = Image.asset('assets/images/gopher.png');
  static Image imageF3mobile = Image.asset('img/f3banner.png');
  static AssetImage imageLeadingLogo =
      const AssetImage('assets/images/leadingLogo.png');
  static Image imageBankCard = Image.asset('assets/images/bonuscard.png');
  static Image errorGopher = Image.asset('assets/images/gopher_error.png');
}
