import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Images1 extends StatefulWidget {
  @override
  _Images1State createState() => _Images1State();
}

class _Images1State extends State<Images1> {
   List data = [];
  List <String>imgurls =[];
  List <String>description =[];
  bool showing = false;
  bool page = false;
  File imagefile;
  bool imagecollection = false;
  getdata() async{
    http.Response response = await http.get('https://api.unsplash.com/collections/1580860/photos/?client_id=jLyPEL4fIns5JliITXj6akZat1OEQ9JirwsE6QU_kg8');
     data = json.decode(response.body);
    print(data);
_assign();
setState(() {
  showing = true;
});
}
_assign(){
    for(var i = 0;i<data.length;i++){
      imgurls.add(data.elementAt(i)["urls"]["regular"]);
      description.add(data.elementAt(i)["alt_description"]);
    }

}


  @override


  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      body:ListView(
        children: [
          Row(
            children: [
              SizedBox(width: 7,),
              InkWell(
                onTap: (){
                  setState(() {
                    page =true;
                  });
                },
                child: page?Container(
                  height: MediaQuery.of(context).size.height/10,
width: MediaQuery.of(context).size.width/2.1,
child: Center(
  child:   Text("API",style: TextStyle(
    fontFamily: 'Katibeh',
    fontWeight: FontWeight.w700,
    color: Colors.white,

    fontSize: 40,

  ),),
),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 5
                    ),
                    color: Colors.black
                  ),
                ):Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width/2.1,
                  child: Center(
                    child:   Text("API",style: TextStyle(

                        color: Colors.black,
                        fontFamily: 'Katibeh',
                        fontWeight: FontWeight.w700,
                        fontSize: 40,

                    ),),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 5
                      ),
                      color: Colors.white
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    page =false;
                  });
                },
                child: page?Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width/2.1,
                  child: Center(
                    child:   Text("Local",style: TextStyle(
                        fontFamily: 'Katibeh',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,

                        fontSize: 40,

                    ),),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 5
                      ),
                      color: Colors.white
                  ),
                ):Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width/2.1,
                  child: Center(
                    child:   Text("Local",style: TextStyle(
fontFamily: 'Katibeh',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,

                      fontSize: 40,

                    ),),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.red,
                          width: 5
                      ),
                      color: Colors.black
                  ),
                )
              ),
            ],
          ),
         
         page?GridView.builder(
            physics: ScrollPhysics(),
           shrinkWrap: true,
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
            ),
            itemBuilder: (ctx,i) {
              return
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                                height: MediaQuery.of(context).size.height/4,
                                child: Image.network(imgurls.elementAt(i),fit: BoxFit.cover,)),
                          ),
                      ),
                      Text(description.elementAt(i),style: TextStyle(
                        fontSize: 9,
                      ),)
                    ],
                  );
                  },
          ): Imagepicker()
        ],
      )

    );
  }

Widget Imagepicker(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 50,),
        FloatingActionButton.extended(
          backgroundColor: Colors.black,
          label: Text("Take image from Camera"),
          onPressed: () {
            _opencamera();
          },
          heroTag: UniqueKey(),
          icon: Icon(Icons.camera,),
        ),
SizedBox(height: 50,),
        FloatingActionButton.extended(
          backgroundColor: Colors.black,
          label: Text("Load image from Gallery"),
          onPressed: () {
            _opengallery();
          },
          heroTag: UniqueKey(),
          icon: Icon(Icons.photo_library),
        )
      ],
    );
}

  _opengallery() async{
    // ignore: deprecated_member_use
    final  picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagefile=picture;
    });
  }
  _opencamera() async{
    // ignore: deprecated_member_use
    final picture = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imagefile=picture;
    });
  }

}
