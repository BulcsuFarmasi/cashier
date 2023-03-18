

enum PaymentMethod {
  card('Kártya'),
  cash('Készpénz');

  const PaymentMethod(this.name);

  final String name;
}