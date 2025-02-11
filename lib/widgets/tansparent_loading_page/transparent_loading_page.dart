import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/widgets/future_widget.dart';

class TransparentLoadingPage<T> extends StatefulWidget {
  final Future<T> future;
  final void Function(T data)? onComplete;
  final Function(String error)? onErrorOk;
  const TransparentLoadingPage({
    super.key,
    required this.future,
    this.onComplete,
     this.onErrorOk,
  });

  @override
  State<TransparentLoadingPage<T>> createState() => _TransparentLoadingPageState<T>();
}

class _TransparentLoadingPageState<T> extends State<TransparentLoadingPage<T>> {
  
  @override
  void initState() {
    widget.future.then((value) => WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop<T>(context);
        widget.onComplete?.call(value);
    }));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(140, 0, 0, 0),
        body: Center(
          child: FutureWidget<T>(
            onLoading: const CircularProgressIndicator(color: white),
            future: widget.future, 
            onComplete: (data) {
              return Container();
            },
            onError:  (error) => AlertDialog(
              title: const Text('Error'),
              content: Text(error),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    if(widget.onErrorOk != null) {
                      widget.onErrorOk?.call(error);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
              
            )
              
              
          
          )
        ),
      ),
    );
  }
}