import 'package:flutter/material.dart';

/// A custom widget which shows a loading indicator on the top of its
/// [child] widget when [isLoading] is true.
/// If [cover] is true, the loading indicator appears on the top of the child,
/// dimming it but not replacing it.
/// If [cover] is false, the child is replaced by the loading indicator while loading.
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false
  });

  /// Private getter to create the loading indicator widget.
  get _loadingView => const Center(
    child: CircularProgressIndicator(color: Colors.blue,),
  );

  /// Private getter which creates `Stack` widget combing the child and
  /// the loading indicator if [isLoading] is true.
  get coverView => Stack(
    children: [child, isLoading ? _loadingView : Container()],
  );

  /// Private getter which returns either the loading indicator or the child depending
  /// on the state of [isLoading].
  get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover ? coverView : normalView;
  }
}
