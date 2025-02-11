import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class LoadedStreamProvider<T> extends StatefulWidget {
  final Stream<T> stream;
  final Widget Function(T data) onData;
  const LoadedStreamProvider({super.key, 
    required this.stream, 
    required this.onData
  });

  @override
  State<LoadedStreamProvider<T>> createState() => _LoadedStreamProviderState<T>();
}

class _LoadedStreamProviderState<T> extends State<LoadedStreamProvider<T>> {
  late Stream<T> broadcast;

  @override
  initState() {
    super.initState();
    broadcast =  widget.stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: broadcast, 
      builder: (context, snapshot) {
        if (
          snapshot.connectionState == ConnectionState.waiting || 
          snapshot.hasError
        ) {
          return const LoadingScreen();
        }
        return StreamProvider<T>(
          updateShouldNotify: (_, __) => true,
          create: (context) => broadcast,
          initialData: snapshot.data as T,
          child: widget.onData(snapshot.data as T));
      },
    );
  }
}