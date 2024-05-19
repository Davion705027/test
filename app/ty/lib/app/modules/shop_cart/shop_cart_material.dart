import 'package:flutter/material.dart';

class ShopCartMaterial extends StatefulWidget {
  final Widget? child;

  const ShopCartMaterial({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _ShopCartMaterialState createState() => _ShopCartMaterialState();
}

class _ShopCartMaterialState extends State<ShopCartMaterial> {
  late Overlay _overlayEntry;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}