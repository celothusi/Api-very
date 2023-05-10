// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  CustomExpansionTile({
    Key? key,
    this.contentPadding,
    this.verticalVisualDensity = 0.0,
    this.isIcon = true,
    this.isData = true,
    this.tileHeight,
    this.leading,
    @required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget? leading;
  final bool isIcon;
  final bool isData;
  final Widget? title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget>? children;
  final double? tileHeight;
  final EdgeInsetsGeometry? contentPadding;
  late double verticalVisualDensity;
  final Widget? trailing;
  final bool? initiallyExpanded;

  @override
  CustomExpansionTileState createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController? controller;
  Animation<double?>? heightFactor;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    heightFactor = controller!.drive(easeInTween);

    isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (isExpanded) controller!.value = 1.0;
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void handleTap() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        controller!.forward();
      } else {
        controller!.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(isExpanded);
    }
  }

  Widget buildChildren(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: widget.tileHeight,
          child: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: ListTile(
              visualDensity: VisualDensity(
                  horizontal: 0, vertical: widget.verticalVisualDensity),
              minVerticalPadding: 0,
              contentPadding: widget.contentPadding,
              dense: true,
              onTap: widget.isData ? handleTap : () {},
              leading: widget.leading,
              title: widget.title,
              trailing: widget.trailing,
              // ??
              // RotationTransition(
              //   turns: _controller!.drive(halfTween.chain(easeInTween)),
              //   child: widget.isIcon
              //       ? Image.asset(
              //           _isExpanded ? AppAsset.minus : AppAsset.plus,
              //           height: 14,
              //           color: ColorConstant.grey,
              //           width: 14,
              //         )
              //       : Container(
              //           color: Colors.transparent,
              //           width: 1,
              //         ),
              // ),
            ),
          ),
        ),
        ClipRect(
          child: Align(
            heightFactor: heightFactor!.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !isExpanded && controller!.isDismissed;
    return AnimatedBuilder(
      animation: controller!.view,
      builder: buildChildren,
      child: closed ? null : Column(children: widget.children!),
    );
  }
}
