import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/url.dart';

class RegisterBloc extends Cubit<ValueNotifier<GraphQLClient>> {
  HttpLink httpLink = HttpLink(
    urlEnvironmentGraphql,
  );

  RegisterBloc()
      : super(ValueNotifier(
          GraphQLClient(
            link: HttpLink(
              urlEnvironmentGraphql,
            ),
            cache: GraphQLCache(store: HiveStore()),
          ),
        ));

  void AddToken(String token) {
    AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );
    Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
        GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));
    emit(client);
  }
}
