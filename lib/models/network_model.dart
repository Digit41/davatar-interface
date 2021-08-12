
class NetworkModel{
  int id;
  String hex;
  String name;

  NetworkModel(this.id, this.hex, this.name);
}

final networks = [
  NetworkModel(1, '0x1', 'Mainnet'),
  NetworkModel(3, '0x3', 'Ropsten'),
  NetworkModel(4, '0x4', 'Rinkeby'),
  NetworkModel(5, '0x5', 'Goerli'),
  NetworkModel(42, '0x2a', 'Kovan'),
];