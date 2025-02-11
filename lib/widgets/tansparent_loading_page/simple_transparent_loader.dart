import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';



class SimpleTransparentLoader<T> extends StatefulWidget {
  final Future<T> future;
  final void Function(T data)? onComplete;
  final void Function(String error)? onError;
  const SimpleTransparentLoader({super.key, required this.future
    ,required this.onComplete,
    this.onError
  });

  @override
  State<SimpleTransparentLoader<T>> createState() => _SimpleTransparentLoaderState<T>();
}

class _SimpleTransparentLoaderState<T> extends State<SimpleTransparentLoader<T>> {

  @override
  void initState() {
    widget.future.then((value) => 
      completed(() => widget.onComplete?.call(value))
    ).onError((error, stackTrace) => 
      completed(() => widget.onError?.call(error.toString()))
    );
    super.initState();
  }

  void completed(VoidCallback complete) =>
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop<T>(context);
      complete();
    });



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(175, 0, 0, 0),
        body: Center(
          child: CircularProgressIndicator(color: white),
        ),
      ),
    );
  }
}

Future<T?> pushSimpleTransparentLoadingRoute<T>(
  BuildContext context,
  {
    required Future<T> future,
    void Function(T data)? onComplete,
    void Function(String error)? onError,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleTransparentLoader<T>(
        future: future,
        onComplete: onComplete,
        onError: onError,
      ),
    );
}