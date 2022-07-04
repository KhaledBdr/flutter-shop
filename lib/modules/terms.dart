import 'package:flutter/material.dart';

class Terms_Screen extends StatelessWidget {
  List <String> terms = [
    'Phasellus vel rhoncus ligula. Phasellus diam felis,faucibus feugiat Maecenas',
    ' molestie semper odio vitae, gravida vestibulum lorem. Suspendisse feugiat in',
    ' pellentesque tellus ipsum, sed scelerisque dui interdum in. Vivamus eleifend',
    ' viverra ipsum, quis ornare diam volutpat ut. Pellentesque eleifend velit quis ',
    ' pellentesque. In rhoncus vulputate velit at gravida. Vestibulum ante ipsum ',
    ' orci luctus et ultrices posuere cubilia curae; Aliquam sit amet blandit dui.',
    ' magna at cursus viverra, risus nulla ultricies orci, nec ultrices arcu lectus.',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Terms and Rights',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder:(context, index){
                  return Text(
                    '${index+1} - ${terms[index]}',
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                  );
                },
                separatorBuilder: (context , index){
                  return SizedBox(height: 20.0,);
                },
                itemCount: terms.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
