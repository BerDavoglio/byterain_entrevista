import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/data.dart';
import '../../ui/ui.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> _items = [];

  List<ContactModel> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadContacts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/contact/'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    print(data);

    data.forEach((_, productData) {
      _items.add(
        ContactModel(
          id: productData['id'],
          name: productData['name'],
          email: productData['email'],
          tel: productData['tel'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveContact(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final contact = ContactModel(
      id: data['id'] as int,
      name: data['name'] as String,
      email: data['email'] as String,
      tel: data['tel'] as String,
    );

    if (hasId) {
      return updateContact(contact);
    } else {
      return addContact(contact);
    }
  }

  Future<void> addContact(ContactModel contact) async {
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}/contact/'),
      body: jsonEncode(
        {
          "name": contact.name,
          "email": contact.email,
          "tel": contact.tel,
        },
      ),
    );

    print(jsonDecode(response.body));

    _items.add(ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      tel: contact.tel,
    ));
    notifyListeners();
  }

  Future<void> updateContact(ContactModel contact) async {
    int index = _items.indexWhere((p) => p.id == contact.id);

    if (index >= 0) {
      await http.put(
        Uri.parse('${Constants.BASE_URL}/contact/'),
        body: jsonEncode(
          {
            "id": contact.id,
            "name": contact.name,
            "email": contact.email,
            "tel": contact.tel,
          },
        ),
      );

      _items[index] = contact;
      notifyListeners();
    }
  }

  Future<void> removeContact(ContactModel contact) async {
    int index = _items.indexWhere((p) => p.id == contact.id);

    if (index >= 0) {
      final contact = _items[index];
      _items.remove(contact);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.BASE_URL}/contact/'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, contact);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}