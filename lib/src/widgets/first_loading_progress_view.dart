import 'package:flutter/material.dart';
import 'package:gophermart/const/app_ui.dart';

class FirstLoadingProgressView extends StatefulWidget {
  const FirstLoadingProgressView({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  State<FirstLoadingProgressView> createState() =>
      _FirstLoadingProgressViewState();
}

class _FirstLoadingProgressViewState extends State<FirstLoadingProgressView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppUi.bannerDescriptionPadding,
              alignment: Alignment.center,
              child: _buildBannerDescription(),
            ),
            Container(
              padding: AppUi.bannerDescriptionPadding,
              alignment: Alignment.center,
              child: Image.asset('assets/images/gopher.gif'),
            )
          ],
        ),
      ),
    );
  }

  _buildBannerDescription() {
    var style = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w500, height: 1.6);
    return Text(widget.description, textAlign: TextAlign.center, style: style);
  }
}
