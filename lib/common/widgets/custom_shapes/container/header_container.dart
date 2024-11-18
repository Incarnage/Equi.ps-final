import 'package:equips_v2/common/widgets/custom_shapes/container/circle.dart';
import 'package:equips_v2/common/widgets/custom_shapes/curved_edges/cureved_edges_widget.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdge(
      child: Container(
          color: const Color(0xFF25291C),
          padding: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -380,
                child: CircularContainer(
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              child,
            ],
          )),
    );
  }
}
