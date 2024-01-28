import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/splash_view.dart';
// import 'package:padeprokan/views/space/features/courses/iframe.dart';
// import 'package:padeprokan/views/space/features/courses/video.dart';
// import 'package:padeprokan/views/space/features/courses/videoqw.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        )
      ],
      child: BlocBuilder<LoginBloc, ValueNotifier<GraphQLClient>>(
        builder: (context, state) => GraphQLProvider(
          client: state,
          child: MaterialApp(
            title: 'Padeprokan',
            theme: ThemeData(
              fontFamily: 'Poppins',
              primarySwatch: Colors.orange,
            ),
            home: SplashView(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

// // ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// /// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

// void main() {
//   runApp(
//     /// Providers are above [MyApp] instead of inside it, so that tests
//     /// can use [MyApp] while mocking the providers
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Counter()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// /// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// // ignore: prefer_mixin
// class Counter with ChangeNotifier {
//   int _count = 0;

//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }

//   /// Makes `Counter` readable inside the devtools by listing all of its properties
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text('You have pushed the button this many times:'),

//             /// Extracted as a separate widget for performance optimization.
//             /// As a separate widget, it will rebuild independently from [MyHomePage].
//             ///
//             /// This is totally optional (and rarely needed).
//             /// Similarly, we could also use [Consumer] or [Selector].
//             Count(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         key: const Key('increment_floatingActionButton'),

//         /// Calls `context.read` instead of `context.watch` so that it does not rebuild
//         /// when [Counter] changes.
//         onPressed: () => context.read<Counter>().increment(),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class Count extends StatelessWidget {
//   const Count({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
//       '${context.watch<Counter>().count}',
//       key: const Key('counterState'),
//       style: Theme.of(context).textTheme.headlineMedium,
//     );
//   }
// }
