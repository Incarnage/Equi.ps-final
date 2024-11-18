import 'package:equips_v2/common/widgets/custom_shapes/curved_edges/cureved_edges.dart';
import 'package:flutter/material.dart';

class CurvedEdge extends StatelessWidget {
  const CurvedEdge({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ECustomeCurvedEdges(),
      child: child,
    );
  }
}
