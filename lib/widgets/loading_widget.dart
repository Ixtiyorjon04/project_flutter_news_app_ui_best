import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_flutter_news_app/consts/vars.dart';
import 'package:project_flutter_news_app/services/utils.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScrrenSize;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
          physics:  const NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (ctx, index) {
            return ArticlesShimmerEffectWidget(
                baseShimmerColor: baseShimmerColor,
                highlightShimmerColor: highlightShimmerColor,
                size: size,
                borderRadius: borderRadius,
                widgetShimmerColor: widgetShimmerColor);
          }),
    );
  }
}

class ArticlesShimmerEffectWidget extends StatelessWidget {
  const ArticlesShimmerEffectWidget({
    Key? key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.size,
    required this.borderRadius,
    required this.widgetShimmerColor,
  }) : super(key: key);

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Size size;
  final BorderRadius borderRadius;
  final Color widgetShimmerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highlightShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.red,
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: widgetShimmerColor),
                            height: size.height * 0.06,
                            width: double.infinity,
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: widgetShimmerColor),
                              height: size.height * 0.025,
                              width: size.width * 0.4,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius,
                                      color: widgetShimmerColor),
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
