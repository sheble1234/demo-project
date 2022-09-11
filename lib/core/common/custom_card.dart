import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomCard extends StatefulWidget {
  CustomCard({
    required this.child,
    this.title,
    this.onTap,
    this.isSelected = false,
    this.showCheckBox = false,
    this.onLongPress,
    this.gridView = false,
    this.customHeight,
    this.customElevation,
    this.customBorderRadius = CustomBorderRadius.medium,
    this.showBorder = false,
    this.titleUnderChild = false,
    this.isCard = true,
    this.color = Colors.white,
    this.showUnderline = true,
  });

  final String? title;
  final Widget child;
  final void Function()? onTap;
  final bool isSelected;
  final bool showCheckBox;
  final void Function()? onLongPress;
  final bool gridView;
  final double? customHeight;
  final double? customElevation;
  final double? customBorderRadius;
  final bool? showBorder;
  final Color? color;

  /// If true, the title will be placed under it's child
  final bool? titleUnderChild;

  /// By default, this displayed as cards, otherwise display as tiles
  final bool? isCard;

  /// Underline on listview
  final bool? showUnderline;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.primary.withOpacity(0.75);

    Widget gridContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null)
                Expanded(
                    child: SelectableText(widget.title!,
                        style: theme.textTheme.bodyText1)),
              widget.showCheckBox
                  ? Icon(
                      widget.isSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank,
                      color: widget.isSelected
                          ? theme.primaryColor
                          : theme.dividerColor,
                    )
                  : Container(),
            ],
          ),
          SizedBox(height: CustomSpacing.small),
          Expanded(child: widget.child),
        ],
      );
    }

    return InkWell(
      onHover: (val) {
        setState(() {
          isHover = val;
        });
      },
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: widget.gridView
          ? AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: isHover
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        widget.customBorderRadius ?? CustomBorderRadius.medium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        )
                      ],
                    )
                  : BoxDecoration(),
              child: widget.isCard!
                  ? Card(
                      //elevation: widget.customElevation ?? 1,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(CustomSpacing.small),
                          side: widget.isSelected
                              ? BorderSide(width: 2, color: theme.primaryColor)
                              : BorderSide(color: theme.dividerColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(CustomSpacing.medium),
                        child: gridContent(),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(CustomSpacing.medium),
                      decoration: BoxDecoration(
                        border: widget.isSelected
                            ? widget.showCheckBox
                                ? CustomDividers.bottomBorder
                                : Border(
                                    top: BorderSide(
                                        color: borderColor, width: 2.0),
                                    bottom: BorderSide(
                                        color: borderColor, width: 2.0),
                                  )
                            : widget.showBorder!
                                ? Border(
                                    bottom: BorderSide(
                                        color: CustomColors.divider,
                                        width: 1.0),
                                    top: BorderSide(
                                        color: CustomColors.divider,
                                        width: 1.0),
                                    left: BorderSide(
                                        color: CustomColors.divider,
                                        width: 1.0),
                                    right: BorderSide(
                                        color: CustomColors.divider,
                                        width: 1.0),
                                  )
                                : CustomDividers.bottomBorder,
                        color: theme.colorScheme.background,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.title != null &&
                                  widget.titleUnderChild == false)
                                Expanded(
                                    child: SelectableText(widget.title!,
                                        style: theme.textTheme.bodyText1)),
                              widget.showCheckBox
                                  ? Icon(
                                      widget.isSelected
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      color: widget.isSelected
                                          ? theme.primaryColor
                                          : theme.dividerColor,
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: CustomSpacing.small),
                          widget.child,
                          Spacer(),
                          widget.titleUnderChild!
                              ? Container(
                                  width: double.infinity,
                                  child: SelectableText(
                                    widget.title!,
                                    style: theme.textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(CustomSpacing.medium),
              decoration: BoxDecoration(
                border: widget.isSelected
                    ? widget.showCheckBox
                        ? CustomDividers.bottomBorder
                        : Border(
                            top: BorderSide(color: borderColor, width: 2.0),
                            bottom: BorderSide(color: borderColor, width: 2.0),
                          )
                    : widget.showBorder!
                        ? Border(
                            bottom: BorderSide(
                                color: CustomColors.divider, width: 1.0),
                            top: BorderSide(
                                color: CustomColors.divider, width: 1.0),
                            left: BorderSide(
                                color: CustomColors.divider, width: 1.0),
                            right: BorderSide(
                                color: CustomColors.divider, width: 1.0),
                          )
                        : widget.showUnderline!
                            ? CustomDividers.bottomBorder
                            : null,
                color: theme.colorScheme.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (widget.title != null &&
                          widget.titleUnderChild == false)
                        Expanded(
                            child: SelectableText(widget.title!,
                                style: theme.textTheme.bodyText1)),
                      widget.showCheckBox
                          ? Icon(
                              widget.isSelected
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                              color: widget.isSelected
                                  ? theme.primaryColor
                                  : theme.dividerColor,
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: CustomSpacing.small),
                  widget.child,
                ],
              ),
            ),
    );
  }
}
