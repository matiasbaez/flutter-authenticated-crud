
import 'package:shop/config/config.dart';
import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

class ProductMapper {

  static Product productJsonToEntity( Map<String, dynamic> json ) => Product(
    id: json['id'],
    title: json['title'],
    price: json['price'] != null ? double.parse( json['price'].toString() ).toInt() : 0,
    description: json['description'],
    slug: json['slug'],
    stock: json['stock'],
    sizes: List<String>.from( json['sizes'].map((size) => size) ),
    gender: json['gender'],
    tags: List<String>.from( json['tags'].map((tag) => tag) ),
    images: List<String>.from( json['images'].map((image) => image.startsWith('http')
      ? image
      : '${Environment.apiUrl}/files/product/$image'
    )),
    user: UserMapper.userJsonToEntity(json['user']),
  );

}
