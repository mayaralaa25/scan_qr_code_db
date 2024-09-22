import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path/path.dart';
import 'package:scan/core/cubit/states.dart';
import 'package:scan/core/dp/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit() : super(InitStates());

  static MainCubit get(context)=> BlocProvider.of(context);
  List<Map> info = [];
  final String databaseName = "qr_code_data.db";


  String? result;

    void setResult(String? re) {
    emit(SetResultLoadingState());
    result = re;
    if(re == null) emit(SetResultErrorState());
    else {
      insertData(result!);
      emit(SetResultSuccessState());
    }
  }

  late String launchError;
  Future<void> launchURL(String url) async {
    emit(LaunchUrlLoadingState());
  try {
    if (await canLaunch(url)) {
      await launch(url);
      emit(LaunchUrlSuccessState());
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    launchError = e.toString();
    emit(LaunchUrlErrorState());
    print('Error launching URL: $e');
  }
}

  DatabaseHelper db = DatabaseHelper();
  Future<void> initSql() async {
    db.initDB();
  }

  Future<void> getData() async {
    db.fetchQRCodes()
        .then(
            (value){
                info = value;
                emit(GetDataSuccessState());
                print(info);
            })
        .catchError(
            (onError){
                emit(GetDataErrorState());
                print(onError.toString());
            });
  }


  Future<void> insertData(String info) async {
    db.insertQRCode(info)
        .then(
            (value){
          emit(InsertDataSuccessState());
        })
        .catchError(
            (onError){
          emit(InsertDataErrorState());
          print(onError.toString());
        });
    getData();
  }

  Future<void> deleteData(int id)async{
    db.deleteQRCode(id);
    getData();
  }

}