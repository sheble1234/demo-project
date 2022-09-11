import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'custom_card.dart';
import 'custom_image_card.dart';

class CustomProductCardWithImage extends StatelessWidget {
  CustomProductCardWithImage({
    required this.imageUrl,
    this.imageHeight = 90,
    this.imageWidth = 90,
    this.customHeight = 300,
    this.title,
    this.onTap,
    this.isSelected = false,
    required this.child,
    this.onLongPress,
  });

  final String imageUrl;
  final double imageHeight;
  final double imageWidth;
  final double customHeight;
  final String? title;
  final void Function()? onTap;
  final bool isSelected;
  final Widget child;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomCard(
        onTap: onTap,
        onLongPress: onLongPress,
        isSelected: isSelected,
        gridView: true,
        child: SizedBox(
          height: customHeight,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    height: 120,
                    // customHeight == 300 ? 180 : customHeight! - 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: CustomImage(
                      imageUrl,
                      fit: BoxFit.cover,
                      emptyImageColor: CustomColors.imageBackground,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: title == null
                        ? [child]
                        : [
                            SelectableText(
                              title!,
                              style: theme.textTheme.bodyText1!.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                            //SizedBox(height: CustomSpacing.xSmall),
                            child,
                          ],
                  ),
                ],
              ),
            ],
          ),
        )
        // : Stack(
        //     alignment: Alignment.topRight,
        //     children: [
        //       (useAltLayout != null && useAltLayout!)
        //         ? Column(
        //               children: [
        //                 Row(
        //                   children: [
        //                     Container(
        //                       height: 75,
        //                       width: 75,
        //                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        //                       child: CustomImage(
        //                         imageUrl,
        //                         fit: BoxFit.cover,
        //                         emptyImageColor: CustomColors.imageBackground,
        //                         borderRadius: BorderRadius.circular(5.0),
        //                       ),
        //                     ),
        //                     SizedBox(width: CustomSpacing.medium),
        //                     title != null
        //                         ? Expanded(
        //                           child: SelectableText(title!,
        //                               style: theme.textTheme.bodyText1!.copyWith(
        //                                 overflow: TextOverflow.ellipsis,
        //                               )),
        //                         )
        //                         : SizedBox.shrink()
        //                     // Expanded(child: child),
        //                   ],
        //                 ),
        //                 SizedBox(height: CustomSpacing.small),
        //                 _childLayout(theme, showTitle: false)
        //               ],
        //             )
        //         : Row(
        //               children: [
        //                 Container(
        //                   height: imageHeight,
        //                   width: imageWidth,
        //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        //                   child: CustomImage(
        //                     imageUrl,
        //                     fit: BoxFit.cover,
        //                     emptyImageColor: CustomColors.imageBackground,
        //                     borderRadius: BorderRadius.circular(5.0),
        //                   ),
        //                 ),
        //                 SizedBox(width: CustomSpacing.medium),
        //                 Expanded(
        //                   child: _childLayout(theme),
        //                   // child: Column(
        //                   //   crossAxisAlignment: CrossAxisAlignment.start,
        //                   //   children: title == null
        //                   //       ? [child]
        //                   //       : [
        //                             // SelectableText(title!,
        //                             //     style: theme.textTheme.bodyText1!.copyWith(
        //                             //       overflow: TextOverflow.ellipsis,
        //                             //     )),
        //                   //           SizedBox(height: CustomSpacing.small),
        //                   //           child,
        //                   //         ],
        //                   // ),
        //                 ),
        //               ],
        //             ),
        //       hasVariants
        //           ? Transform.rotate(
        //               angle: -math.pi / 3,
        //               child: Image(
        //                   height: 20,
        //                   width: 20,
        //                   image: NetworkImage(
        //                       'https://www.pinclipart.com/picdir/big/548-5480192_file-circle-diagram3-colored-venn-diagram-3-circles.png')),
        //             )
        //           : hasUOM
        //               ? Icon(MdiIcons.widgets, color: Colors.cyan)
        //               : Container(),
        //       isParent ? FaIcon(FontAwesomeIcons.link) : SizedBox.shrink()
        //     ],
        // )
        );
  }
}
