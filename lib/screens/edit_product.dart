import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';

class EditProductScreen extends StatefulWidget {
  static const route = "edit-product";

  const EditProductScreen({super.key});

  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _productImageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isInit = false;
  bool _isLoading = false;

  Map<String, String> _initialValues = {
    "title": "",
    "description": "",
    "price": "",
    "image_url": "",
  };

  Product _product = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    image_url: "",
    category: "",
    brand: "",
    quantity: 0,
    created_at: "",
    updated_at: "",
  );

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _isInit = true;
      final productRes = await Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).getProductById(productId);
      if (productRes != null) {
        _product = productRes;
        _initialValues = {
          "title": _product.title,
          "description": _product.description,
          "price": _product.price.toString(),
          "image_url": _product.image_url,
        };
        _productImageController.text = _product.image_url;
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
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState?.save();
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      await productsProvider.updateProduct(_product);
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
        title: const Text(
          "Edit Product",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initialValues["title"],
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: const TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.03),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Change border color when focused
                              width: 2.0, // Set border width when focused
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(fontSize: 16),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _product = _product.copyWith(title: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Title is required' : null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: _initialValues["price"],
                        decoration: InputDecoration(
                          hintText: "Product Price",
                          hintStyle: const TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.03),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Change border color when focused
                              width: 2.0, // Set border width when focused
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(fontSize: 16),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(
                            _descriptionFocusNode,
                          );
                        },
                        onSaved: (value) {
                          _product =
                              _product.copyWith(price: double.parse(value!));
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Price is required";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please provide a valid price";
                          }
                          if (double.parse(value) <= 0) {
                            return "Price should be positive";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: _initialValues["description"],
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Product Description",
                          hintStyle: const TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.03),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Change border color when focused
                              width: 2.0, // Set border width when focused
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _product = _product.copyWith(description: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Description is required' : null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _productImageController,
                        decoration: InputDecoration(
                          hintText: "Product Image",
                          hintStyle: const TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.03),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Change border color when focused
                              width: 2.0, // Set border width when focused
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => submitForm(),
                        onSaved: (value) {
                          _product = _product.copyWith(image_url: value!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Image URL is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 16,
                              ),
                            ),
                            onPressed: submitForm,
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
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
