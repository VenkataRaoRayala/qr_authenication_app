import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrbasedauthenication/features/user/providers.dart';

class UsersScreen extends ConsumerWidget {
  final String userId;
  const UsersScreen({super.key,required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userInfoProvider(userId));

    if(userData.hasValue){
      return Column(children: [
        Text('User name: ${userData.value?['name']}'),
        Text('Email: ${userData.value?['email']}'),
        if(userData.value!['imageUrl']!=null)
        Image.network(userData.value!['imageUrl'])
      ],);
    }
    if(userData.hasError){
      return Text('Something went wrong');
    }
    return CircularProgressIndicator();
  }
}
