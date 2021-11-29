import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';

class CreateUpdateBody extends StatefulWidget {
  @override
  _CreateUpdateBodyState createState() => _CreateUpdateBodyState();
}

class _CreateUpdateBodyState extends State<CreateUpdateBody> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ContactProvider>(
        context,
        listen: false,
      ).saveContact(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro!'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final contact = arg as ContactModel;
        _formData['id'] = contact.id;
        _formData['name'] = contact.name;
        _formData['email'] = contact.email;
        _formData['tel'] = contact.tel;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 800,
                  height: 700,
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onSaved: (person) =>
                                _formData['person'] = person ?? '',
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onSaved: (email) =>
                                _formData['email'] = email ?? '',
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Tel',
                              icon: Icon(
                                Icons.tablet_android,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onSaved: (tel) => _formData['tel'] = tel ?? '',
                          ),
                          Container(height: 30),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            child: Text('Enter'.toUpperCase()),
                            onPressed: () {
                              _submitForm();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
