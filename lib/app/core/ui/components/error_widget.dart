import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;
  final Exception? exception;

  const CustomErrorWidget(this.message, this.exception, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 100,
          ),
          Text(
            message ?? 'Oops... something went wrong',
          ),
          Text(
            exception?.toString() ?? '',
          ),
        ],
      ),
    );
  }
}
