import 'package:flutter/widgets.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_page.dart';



Future pushTransparentLoadingRoute<T>(
  BuildContext context,{
    required Future<T> future,
    Function(T data)? onComplete,
    void Function(String error)? onErrorOk,
  }) {
  return Navigator.of(context).push<T>(
    PageRouteBuilder(
    
      opaque: false, // set to false
      pageBuilder: (context, __, ___) => TransparentLoadingPage<T>(
        future: future,
        onErrorOk : onErrorOk,
        onComplete: onComplete,
      ),
    ),
  );
}