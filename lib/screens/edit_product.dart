import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/form_input.dart';

class EditProductScreen extends StatefulWidget {
  static const route = "edit-product";

  const EditProductScreen({super.key});

  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isInit = false;
  bool _isLoading = false;
  Product _product = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    image_url: "",
    category: "",
    brand: "",
    quantity: 0,
    created_at: DateTime.now(),
    updated_at: DateTime.now(),
  );

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _isInit = true;
      final product = await Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).getProductById(productId);
      if (product != null) {
        setState(() {
          _product = product;
        });
        _titleController.text = _product.title;
        _brandController.text = _product.brand;
        _categoryController.text = _product.category;
        _priceController.text = _product.price.toString();
        _quantityController.text = _product.quantity.toString();
        _descriptionController.text = _product.description;
        _imageController.text = _product.image_url;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
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
          ? CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormInput(
                        controller: _titleController,
                        hintText: "Title",
                        onSaved: (value) {
                          _product = _product.copyWith(title: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Title is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _brandController,
                        hintText: "Brand",
                        onSaved: (value) {
                          _product = _product.copyWith(brand: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Brand is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _categoryController,
                        hintText: "Category",
                        onSaved: (value) {
                          _product = _product.copyWith(category: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Category is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _priceController,
                        hintText: "Price",
                        onSaved: (value) {
                          _product = _product.copyWith(
                              price: double.tryParse(value!) ?? 0.0);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Price is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _quantityController,
                        hintText: "Quantity",
                        onSaved: (value) {
                          _product = _product.copyWith(
                              quantity: int.tryParse(value!) ?? 0);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Quantity is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _descriptionController,
                        maxLines: 4,
                        hintText: "Description",
                        onSaved: (value) {
                          _product = _product.copyWith(description: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Description is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 10.0),
                      FormInput(
                        controller: _imageController,
                        hintText: "Image URL",
                        onSaved: (value) {
                          _product = _product.copyWith(image_url: value!);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Image URL is required' : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          Button(
                            text: "Cancel",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                            isPrimary: false,
                          ),
                          const SizedBox(width: 16),
                          Button(
                            text: "Save",
                            onPressed: submitForm,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                          )
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
