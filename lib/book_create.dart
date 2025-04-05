import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitob_ol/category_list.dart';
import 'package:kitob_ol/provider.dart';
import 'package:provider/provider.dart';

class BookCreatePage extends StatefulWidget {
  @override
  _BookCreatePageState createState() => _BookCreatePageState();
}

class _BookCreatePageState extends State<BookCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _category = "Kategoriya";
  String _condition = "Holati";
  List<XFile?> _images = [];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("E'lon qo'shish")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryList(),
              _buildTextField("Kitob nomi", _nameController),
              _buildDropdown(["Kategoriya", "Badiiy", "Ilmiy"], _category,
                  (val) {
                setState(() => _category = val);
              }),
              _buildTextField("Muallif", _authorController),
              _buildTextField("Kitob tasviri", _descriptionController),
              _buildTextField("Sahifalar soni", _pagesController),
              _buildTextField("Chop etilgan yil", _yearController),
              _buildTextField("Narxi", _priceController),
              _buildDropdown(["Holati", "Yangi", "Ishlatilgan"], _condition,
                  (val) {
                setState(() => _condition = val);
              }),
              _buildImagePicker(),
              _buildTextField("Manzil", _addressController),
              _buildTextField("Email", _emailController),
              _buildTextField("Telefon", _phoneController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ma'lumotlarni saqlash
                  }
                },
                child: Text("E'lonni joylash"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value!.isEmpty ? "$label kiritilishi shart" : null,
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String selected, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        value: selected,
        items: items.map((String category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) => onChanged(value!),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rasmlar"),
        Wrap(
          children: _images.map((img) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(img!.path, width: 80, height: 80),
            );
          }).toList(),
        ),
        ElevatedButton(onPressed: _pickImage, child: Text("Rasm qo'shish")),
      ],
    );
  }
}
