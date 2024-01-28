import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/url.dart';

class LoginBloc extends Cubit<ValueNotifier<GraphQLClient>> {
  HttpLink httpLink = HttpLink(
    urlEnvironmentGraphql,
  );
  WebSocketLink websocketLink = WebSocketLink(
    urlEnvironmentSocket,
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  LoginBloc()
      : super(ValueNotifier(
          GraphQLClient(
            link: HttpLink(
              urlEnvironmentGraphql,
            ),
            cache: GraphQLCache(store: HiveStore()),
          ),
        ));

  void generateToken(String token) {
    AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );
    WebSocketLink websocketLinkAu = WebSocketLink(
      urlEnvironmentSocket,
      config: SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: const Duration(seconds: 30),
          initialPayload: {"Authorization": "Bearer $token"}),
    );
    Link splitLink = Link.split(
      (request) => request.isSubscription,
      websocketLinkAu,
      httpLink,
    );
    Link link = authLink.concat(splitLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    emit(client);
  }
}
