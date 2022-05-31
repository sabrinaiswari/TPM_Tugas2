import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugas2/model/resep.dart';
import 'package:tugas2/model/resep_api.dart';
import 'package:tugas2/view/resep_card.dart';
import 'detail_resep.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  final bool isLogin;

  const HomePage({Key? key, required this.username,required this.isLogin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Resep> _resep;
  bool _isLoading = true;

  initState(){
    super.initState();
    getResep();
  }

  Future<void> getResep() async{
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Resep Makanan')
            ],
          ),
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
          ),
          itemCount: _resep.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ResepCard(
                title: _resep[index].name,
                cooktime: _resep[index].totalTime,
                rating: _resep[index].country.toString(),
                thumbnailUrl: _resep[index].images,
                videoUrl: _resep[index].videoUrl,
              ),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => DetailResep(
                      name: _resep [index].name,
                      images: _resep[index].images,
                      country: _resep[index].country.toString(),
                      totalTime: _resep[index].totalTime,
                      description: _resep[index].description,
                      videoUrl: _resep[index].videoUrl,
                      instructions: _resep[index].instructions,
                      sections: _resep[index].sections,
                    )))
              },
            );

          },
        ));
  }
}

