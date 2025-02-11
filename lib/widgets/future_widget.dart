import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';


class FutureWidget<T> extends StatefulWidget {
  final Future<T> future;
  final Widget? Function(String error)? onError;
  final Widget? initialWidget;
  final Widget? onLoading;
  final Widget Function(T data) onComplete;
  const FutureWidget({super.key, 
    required this.future, 
    this.onError, 
    required this.onComplete, this.onLoading, 
    this.initialWidget,
  });

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future, 
      builder: (context, snapshot) {
        Widget loadingWidget = const CircularProgressIndicator(color: Color.fromARGB(255, 0, 0, 0));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: widget.onLoading ?? loadingWidget
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.onError?.call(snapshot.error!.toString()) ?? Center(
              child: CustomText(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final T data = snapshot.data as T;
            return widget.onComplete(data);
          } else {
            return widget.onComplete("No data" as T);
          }
        }
        return widget.initialWidget ?? loadingWidget;
      },
    );
  }
}