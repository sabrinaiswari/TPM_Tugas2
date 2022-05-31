import 'package:flutter/material.dart';
import 'package:tugas2/view/detail_video.dart';

class ResepCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cooktime;
  final String thumbnailUrl;
  final String videoUrl;



  const ResepCard(
      { required this.title,
        required this.rating,
        required this.cooktime,
        required this.thumbnailUrl,
        required this.videoUrl,

      });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(0.0, 8.0),
                blurRadius: 6.0,
                spreadRadius: -6.0),
          ],
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.multiply),
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover
          )
      ),
      child: Stack(children: [
        Align(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 19),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          alignment: Alignment.center,
        ),
         Align(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Visibility(
                 visible: videoUrl != "novideo" ? true : false,
                 child: Container(
                   padding: EdgeInsets.all(5),
                   margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       color: Colors.black.withOpacity(0.4),
                       borderRadius: BorderRadius.circular(15)
                   ),
                   child: InkWell(
                     onTap: () => {
                       Navigator.push(
                           context, MaterialPageRoute(
                           builder: (context) => DetailVideo(
                             videoUrl: videoUrl,
                           )))
                     },
                     child: Row(
                       children: [
                         Icon(
                           Icons.play_circle_fill_rounded,
                           color: Colors.yellow,
                           size: 20,
                         ),
                         SizedBox(width: 7),
                         Text('Play Video'),
                       ],
                     ),
                   ),
                 ),
               ),
         Container(
          decoration: BoxDecoration(
               color: Colors.black.withOpacity(0.4),
               borderRadius: BorderRadius.circular(15)
           ),
           child: Row(
             children: [
               Icon(
                 Icons.schedule,
                 color: Colors.yellow,
                 size: 20,
               ),
               SizedBox(width: 7),
               Text(cooktime),
             ],
           ),
         ),
      ],
      ),
       alignment: Alignment.bottomLeft,
         ),
       ],)
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
