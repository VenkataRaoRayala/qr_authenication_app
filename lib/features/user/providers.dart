import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userInfoProvider = FutureProvider.family<Map<String,dynamic>, String>((ref, id) async {
  try{
  final response = await http.get(
      Uri.parse('https://mockapi.example.com/users/$id'));
  final json = jsonDecode(response.body) as Map<String,dynamic>;
  return json;}
      catch(e){
        return {
          'Message':e.toString()
        };
      }
});
