import 'package:flutter/material.dart';

class DiagonalContainer extends StatefulWidget {
  final double screenwidth;
  final double screenheight;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Widget header;
  const DiagonalContainer({
    super.key,
    required this.screenwidth,
    this.screenheight = double.infinity,
    required this.child,
    required this.header,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  State<DiagonalContainer> createState() => _DiagonalContainerState();
}

class _DiagonalContainerState extends State<DiagonalContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.screenwidth,
      height: widget.screenheight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(children: [widget.header, widget.child]),
      ),
    );
  }
}
