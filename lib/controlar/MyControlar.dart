import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/helpers/ApiHandler.dart';
import '../Resources/UrlResources.dart';
import '../helpers/ErrorHandler.dart';
import '../model/product.dart';

class MyControlar extends GetxController
{
  TextEditingController itemid = TextEditingController();
  @override
  void onInit() {
    getAllProducts();
  }

  RxList<product>? alldata = <product>[].obs;

  getAllProducts() async {
    try
    {

      // var id = 10;
      // var params = {
      //   "limit": id.toString(),
      // };
      //
      // var headers = {
      //   "Postman-Token": "<calculated when request is sent>",
      //   "Host": "<calculated when request is sent>",
      //   "User-Agent": "PostmanRuntime/7.33.0",
      //   "Accept": "*/*",
      //   "Accept-Encoding": "gzip, deflate, br",
      //   "Connection": "keep-alive",
      // };


      await ApiHandler.getRequest(UrlResources.BASE_URL).then((json){
        alldata!.value = json.map<product>((obj) => product.fromJson(obj)).toList();
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        //redirect to no internet page
      }
      else if(ex.message.toString()=="Bad Response Format")
      {
        //redirect to support page
      }
    }
  }

  addProduct() async
  {
    var obj = product(
      id: itemid.text.toString(),
      url: "https://t4.ftcdn.net/jpg/02/66/72/41/360_F_266724172_Iy8gdKgMa7XmrhYYxLCxyhx6J7070Pr8.jpg",
      width: 100,
      height: 100
    );
    itemid.text = "";
    alldata!.add(obj);
  }

}