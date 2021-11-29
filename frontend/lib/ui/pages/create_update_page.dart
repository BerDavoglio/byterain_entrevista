import 'package:flutter/material.dart';

import '../components/components.dart';

class CreateUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: HomeAppBar(),
      body: CreateUpdateBody(),
    );
  }
}
