import 'package:flutter/material.dart';
import 'package:frontend/data/data.dart';
import 'package:frontend/infra/infra.dart';
import 'package:frontend/ui/ui.dart';
import 'package:provider/provider.dart';

class ContactGridModel extends StatelessWidget {
  const ContactGridModel({Key? key, this.item}) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          item.email,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Text(
                          item.tel,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.CRUD, arguments: {item});
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Excluir Produto'),
                        content: Text('Tem certeza?'),
                        actions: [
                          TextButton(
                            child: Text('Não'),
                            onPressed: () => Navigator.of(ctx).pop(false),
                          ),
                          TextButton(
                            child: Text('Sim'),
                            onPressed: () => Navigator.of(ctx).pop(true),
                          ),
                        ],
                      ),
                    ).then(
                      (value) async {
                        if (value ?? false) {
                          try {
                            await Provider.of<ContactProvider>(
                              context,
                              listen: false,
                            ).removeContact(item);
                          } on HttpException catch (error) {
                            Text(error.toString());
                          }
                        }
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
