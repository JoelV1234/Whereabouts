import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/loading_screen.dart';

class StreamWidget<T> extends StatelessWidget {
  final Widget? onLoading;
  final Widget Function(T data) onData;
  final Stream<T> stream;
  final Widget Function(String error)? onError;
  const StreamWidget({
    super.key, 
    this.onLoading, 
    required this.onData, 
    required this.stream, 
    this.onError
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        Widget loadingWidget = const  LoadingScreen();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: onLoading ?? loadingWidget
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return onError?.call(snapshot.error.toString()) ?? Center(
              child: CustomText(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final T data = snapshot.data as T;
            return onData(data);
          } else {
            return onData("No data" as T);
          }
        }
        return loadingWidget;
      },
    );
  }
}