import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';

extension ProductJTOFixture on ProductJTO {
  static ProductJTOFixtureFactory factory() => ProductJTOFixtureFactory();
}

class ProductJTOFixtureFactory extends JsonFixtureFactory<ProductJTO> {
  @override
  FixtureDefinition<ProductJTO> definition() => define(
    (faker, [int index = 0]) => ProductJTO(
      affiliateUrl: faker.internet.httpsUrl(),
      brand: faker.lorem.word(),
      brandId: faker.guid.guid(),
      category: faker.lorem.word(),
      category1: faker.lorem.word(),
      category2: faker.lorem.word(),
      description: faker.lorem.sentence(),
      discountPercentage: faker.randomGenerator.integer(70),
      hasImage: 1,
      id: faker.guid.guid(),
      image: faker.image.loremPicsum(),
      imageMerchant: faker.image.loremPicsum(),
      listPrice: faker.randomGenerator.decimal(min: 100, scale: 2),
      merchant: faker.company.name(),
      merchantId: faker.guid.guid(),
      newOffer: faker.randomGenerator.boolean(),
      sellingPrice: faker.randomGenerator.decimal(min: 80, scale: 2),
      tags: ['example', 'test'],
      title: faker.lorem.words(3).join(' '),
      url: faker.internet.httpsUrl(),
    ),
  );

  @override
  JsonFixtureDefinition<ProductJTO> jsonDefinition() =>
      defineJson((object, [int index = 0]) => object.toJson());
}
