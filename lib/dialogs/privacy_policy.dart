import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatelessWidget {
  final double radius;
  final String mdFilename;

  PrivacyPolicy({Key? key, this.radius = 8, required this.mdFilename})
      : assert(mdFilename.contains('.md')),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString('assets/$mdFilename');
            }),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  return Markdown(
                      data: snapshot.data
                  );
              }
              return const Center(child: CircularProgressIndicator(),);
            },
          )),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius),
                )
              ),
              alignment: AlignmentDirectional.center,
              height: 50,
              width: double.infinity,
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.bold,

                )
              ),

            ),

          )
          
        ],
      ),
    );
  }
}
