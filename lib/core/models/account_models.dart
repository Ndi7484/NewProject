class ListAccount {
  ListAccount({
    this.listAccount,
  });
  final List<Account>? listAccount;
}

class Account {
  Account({
    required this.name,
    required this.email,
    required this.password,
    required this.telephone,
    this.address,
  });
  final String name;
  final String email;
  final String password;
  final String telephone;
  // <kategori,<Alamat,deskripsi>>
  final Map<String, Map<String, String>>? address;
}
