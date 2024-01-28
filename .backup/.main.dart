// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:padeprokan/components/graphql/login.dart';

// void main() async {
//   await initHiveForFlutter();

//   final HttpLink httpLink =
//       HttpLink("https://dev-panenineifkm.microgen.id/graphql/");

//   ValueNotifier<GraphQLClient> client = ValueNotifier(
//     GraphQLClient(
//       link: httpLink,
//       cache: GraphQLCache(store: HiveStore()),
//     ),
//   );

//   runApp(MyApp(client: client));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.client});

//   final ValueNotifier<GraphQLClient> client;
//   @override
//   Widget build(BuildContext context) {
//     print("${client.value.link} 0000");
//     return GraphQLProvider(
//       client: client,
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Panenin',
//           theme: ThemeData(),
//           home: const Home()
//           // initialRoute: "/",
//           // routes: {
//           //   '/': (BuildContext context) => new SplashScreen(),
//           // },
//           ),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Query(
//         options: QueryOptions(
//             fetchPolicy: FetchPolicy.networkOnly,
//             document: gql(showProducts),
//             variables: const {'skip': 0, 'limit': 100}
//             // pollInterval: const Duration(seconds: 10),
//             ),
//         builder: ((result, {fetchMore, refetch}) {
//           // print('fsrs, $result');
//           // if (result.hasException) {
//           //   print("${result.exception}0a0a0a0a0");
//           //   return (const Text("kk"));
//           // }
//           if (result.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           List login = result.data?["productsConnection"]["data"];
//           print(login.length);
//           // print(result.data?['productsConnection'].data);
//           // List data = result;
//           return ListView.builder(
//             itemCount: login.length,
//             itemBuilder: (context, index) {
//               return Text(login[index]["name"].toString() + index.toString());
//             },
//           );
//         }));
//   }
// }
