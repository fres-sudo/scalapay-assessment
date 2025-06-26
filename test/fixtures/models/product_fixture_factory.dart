import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:scalapay_assessment/models/product/product.dart';

extension ProductFixture on Product {
  static ProductFixtureFactory factory() => ProductFixtureFactory();
}

class ProductFixtureFactory extends FixtureFactory<Product> {
  @override
  FixtureDefinition<Product> definition() => define(
    (faker, [int index = 0]) => Product(
      id: faker.guid.guid(),
      title: faker.lorem.words(3).join(' '),
      description: faker.lorem.sentence(),
      price: faker.randomGenerator.decimal(min: 50).toStringAsFixed(2),
      merchantBrand: faker.company.name(),
      installmentPrice: faker.randomGenerator
          .decimal(min: 10)
          .toStringAsFixed(2),
      image: faker.image.loremPicsum(),
      hasImage: true,
      url: faker.internet.httpsUrl(),
    ),
  );
}
