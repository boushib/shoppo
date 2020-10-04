import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';

class EditProductScreen extends StatefulWidget {
  static const route = 'edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _productImageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isInit = false;
  bool _isLoading = false;

  Map _initialValues = {
    'title': '',
    'description': '',
    'price': '',
    // 'imageUrl': '',
  };

  Product _product = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final _productId = ModalRoute.of(context).settings.arguments as String;
      _isInit = true;
      if (_productId != null) {
        _product = Provider.of<ProductsProvider>(context, listen: false)
            .getProductById(_productId);
        _initialValues = {
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toString(),
          // 'imageUrl': _product.imageUrl,
        };
        _productImageController.text = _product.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _productImageController.dispose();
    super.dispose();
  }

  void submitForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      if (_product.id == null) {
        try {
          await productsProvider.addProduct(_product);
        } catch (err) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text('Some error happened!'),
              actions: [
                FlatButton(
                  child: Text('Dismiss'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }
      } else {
        await productsProvider.updateProduct(_product);
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initialValues['title'],
                        decoration: const InputDecoration(
                          hintText: 'Product Title',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _product = Product(
                            id: _product.id,
                            title: value,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) return 'Title field is required';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: _initialValues['price'],
                        decoration: const InputDecoration(
                          hintText: 'Product Price',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            price: double.parse(value),
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Price field is required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please provide a valid price';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Price should be a positive number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: _initialValues['description'],
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Product Description',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                        // textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            description: value,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            isFavorite: _product.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Description field is required';
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Container(
                            height: 100.0,
                            width: 100.0,
                            margin: EdgeInsets.only(top: 10.0, right: 10.0),
                            // padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: _productImageController.text.isEmpty
                                ? Center(
                                    child: Text(
                                      'Please enter an image URL!',
                                    ),
                                  )
                                : Image.network(
                                    _productImageController.text,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // you can't use both initialValue & controller
                              // initialValue: _initialValues['imageUrl'],
                              decoration: const InputDecoration(
                                hintText: 'Product Image',
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _productImageController,
                              onFieldSubmitted: (_) => submitForm(),
                              onSaved: (value) {
                                _product = Product(
                                  id: _product.id,
                                  title: _product.title,
                                  description: _product.description,
                                  price: _product.price,
                                  imageUrl: value,
                                  isFavorite: _product.isFavorite,
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Description field is required';
                                // if (!value.endsWith('.png') &&
                                //     !value.endsWith('.jpg')) {
                                //   return 'Please provide a valid image url';
                                // }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      ButtonBar(
                        children: [
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            color: Colors.green,
                            child: Text('Save'),
                            onPressed: () => submitForm(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
