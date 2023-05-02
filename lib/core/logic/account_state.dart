part of 'account_cubit.dart';

class AccountState extends Equatable {
  AccountState({
    this.status = RequestLoading.initial,
  });
  final RequestLoading status;
  final List<String> listEmail = [
    'ndimas@gmail.com',
    'junior@gmail.com',
    'marco@gmail.com',
  ];
  final List<Account> listAccount = [
    Account(
        name: 'Ndimas',
        email: 'ndimas@gmail.com',
        password: 'Ndi123',
        telephone: '081375726600',
        address: [
          {
            "Rumah": {"Jl. Kediri Nuansa No.45A": "sebelah toko kado"}
          }
        ]),
    Account(
        name: 'Junior',
        email: 'junior@gmail.com',
        password: 'Jun123',
        telephone: '081375726601'),
    Account(
        name: 'Marco',
        email: 'marco@gmail.com',
        password: 'Mar123',
        telephone: '081375726602'),
  ];

  AccountState copyWith({
    RequestLoading? status,
    List<Account>? listAccount,
  }) {
    return AccountState(
      status: status ?? this.status,
    );
  }

  bool checkAccount({
    String? email,
    String? password,
  }) {
    if (email != null && password != null) {
      for (var el in listAccount) {
        if (email == el.name || email == el.email) {
          if (password == el.password) {
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  // TODO: implement props
  List<dynamic> get props => [
        status,
        listEmail,
        listAccount,
      ];
}
