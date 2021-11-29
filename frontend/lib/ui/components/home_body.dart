import 'package:flutter/material.dart';
import 'package:frontend/ui/utils/utils.dart';
import 'package:provider/provider.dart';

import '../ui.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);
    final List<ContactModel> loadedContacts = provider.items;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              height: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.amber[300],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        child: Text(
                          'Listar Contatos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 21),
                        ),
                        onPressed: () => {
                          Navigator.of(context).popAndPushNamed(AppRoutes.HOME)
                        },
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Criar Contato',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                      onPressed: () => {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.CRUD)
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.all(4),
                  itemCount: loadedContacts.length,
                  itemBuilder: (context, index) {
                    final item = loadedContacts[index];
                    return ContactGridModel(item: item);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
