import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan/core/cubit/cubit.dart';
import 'package:scan/core/cubit/states.dart';
import 'package:scan/modules/home/presentation/qr_code_scanner.dart';
import 'package:toast/toast.dart';

import '../widgets/itemBuilder.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String? _result;
  //
  // void setResult(String result) {
  //   setState(() => _result = result);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if(state is LaunchUrlErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(MainCubit.get(context).launchError),
        duration: Duration(seconds: 1),),
    );
        }
      },
      builder: (context, state) =>  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('Hello, Rasid'),
        actions: [
          InkWell(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.qr_code),
          ),
            onTap: (){Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => QrCodeScanner(
                 // setResult:
                 //  MainCubit.get(context).setResult(
                 //    MainCubit.get(context).result
                 // ),
              ),
              ));},

        ),],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/.2,
              child: ListView.builder(
                  itemBuilder: (context, index) => Itembuilder(
                    context: context,
                    id: MainCubit.get(context).info[index]['id'],
                    data: MainCubit.get(context).info[index]['data'],
                  ),
                itemCount: MainCubit.get(context).info.length,
              ),
            ),
        ],
              ),
      )
    ),
    );
  }
}