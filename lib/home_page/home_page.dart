import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ordenando/model/pessoa_model.dart';
import 'package:ordenando/repository/pessoa_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<PessoaModel> pplList;
  PessoaRepository pplRepo = PessoaRepository();
  @override
  void initState() {
    pplList = pplRepo.getAllUsers();
  }

  void sort() {
    setState(() {
      pplList.sort((PessoaModel ppl1, PessoaModel ppl2) {
        return ppl1.nota.compareTo(ppl2.nota);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  sort();
                },
                icon: const Icon(Icons.border_outer_outlined))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemCount: pplList.length,
            itemBuilder: (context, index) {
              return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading:
                      CircleAvatar(child: Text(pplList[index].nota.toString())),
                  tileColor: Color.fromARGB(255, Random().nextInt(255),
                      Random().nextInt(255), Random().nextInt(255)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pplList[index].nome,
                          style: const TextStyle(fontSize: 13)),
                      CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Text(pplList[index].price.toString(),
                              style: const TextStyle(fontSize: 13))),
                    ],
                  ));
            },
          ),
        ));
  }
}
