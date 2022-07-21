abstract class ServerStates {}

class CounterInitialState extends ServerStates {}

class CounterPlusState extends ServerStates
{
  final bool counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends ServerStates
{
  final int counter;

  CounterMinusState(this.counter);
}

class ConnectServer extends ServerStates {}
class ListenMessage extends ServerStates {}
class ErrorConnectServer extends ServerStates {}
class SendMessage extends ServerStates {}
class OnDonConnectServer extends ServerStates {}

class ReConnectServer extends ServerStates {}

class ChangePasswordVisibilityState extends ServerStates{}

class AppLoginLoadingState extends ServerStates {}

class ShopLoginSuccessState extends ServerStates
{}

class AppLoginErrorState extends ServerStates
{
  final String error;

  AppLoginErrorState(this.error);
}