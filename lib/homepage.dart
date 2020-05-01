import 'dart:convert';
import 'package:ncov/panels/Tindia.dart';
import 'package:ncov/panels/Hospital.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:ncov/datasorce.dart';
import 'package:ncov/pages/countyPage.dart';
import 'package:ncov/panels/infoPanel.dart';
import 'package:ncov/panels/mosteffectedcountries.dart';
import 'package:ncov/panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:ncov/panels/India.dart';
import 'package:ncov/panels/World.dart';
import 'package:ncov/panels/Hstate.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://disease.sh/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List<dynamic> countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://disease.sh/v2/countries?sort=deaths');
    setState(() {
      countryData = json.decode(response.body);
    });
  }
  /*
  navigateToWHO(url) async
    {
      if(await canLaunch(url))
      {
        await launch(url);
      }
      else {
        Text('Link is not Working $url');
      }
    }*/
    /*
  navigateToIndia() async
   {
       await Navigator.push(context, 
       MaterialPageRoute(
         builder: (context) => Tindia()
         ));
   }*/
  navigateToIndiaMap() async{
       await Navigator.push(context, 
       MaterialPageRoute(
         builder: (context) => India()
         ));
   }
   navigateToWorld() async
   {
       await Navigator.push(context, 
       MaterialPageRoute(
         builder: (context) => World()
         ));
   }

   navigateToHospital() async
   {
       await Navigator.push(context, 
       MaterialPageRoute(
         builder: (context) => Hospital()
         ));
   }

   
    navigateToHstate() async
   {
       await Navigator.push(context, 
       MaterialPageRoute(
         builder: (context) => Hstate()
         ));
   }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],

        centerTitle: false,
        title:Row(
          children: <Widget>[
            Text(
              'Seventh Erudition',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70
              ),
            ),
            Text(
              ' COVID-19 Tracker',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w100
              ),
            ),
          ],
        ), 
       /*   Text(
          'Seventh Erudition COVID-19 Tracker',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70
          ),
        ),*/
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(
              DataSource.quote,
              style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Caveat',
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Worldwide',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'All Countries',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldwidePanel(
                  worldData: worldData,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: Text(
              'Most affected Countries',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          countryData == null
              ? Container()
              : MostAffectedPanel(
                  countryData: countryData,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 10),
                  child: Text(
                    "National Stats",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                //We have to add extra features here
                Padding(padding: EdgeInsets.only(top :20.0)),
                Container(
         child:Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[ 

           Card(
                   child :Container(color: Color(0xFF292929),
                  child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[

                     
                 Padding(padding: EdgeInsets.only(top :20.0)),

                 Image(image: AssetImage("images/indialogo.jpg"),
                 height: 165,
                 width: 165
                 ,
                 ),
                 Padding(padding: EdgeInsets.only(top :20.0,left: 10.0)),
                  OutlineButton(
          borderSide: BorderSide(color : Colors.transparent),

                   onPressed: ()=> navigateToIndiaMap(),
                
                 child : Text(
                   "State Statistics",
                   //"          Indian \n Statewise Statistics",
                   style: TextStyle(
                     fontSize: 15,
                     color:Colors.white70,
                     fontWeight: FontWeight.bold,
                     //color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]
                     ),
                     ),
                    ),

                 ]))


      ) ),
      Card(
                   child :Container(color: Color(0xFF292929),
                  child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[

                     
                 Padding(padding: EdgeInsets.only(top :20.0,right: 10.0)),

                 Image(image: AssetImage("images/indianemblem.jpg"),
                 height: 165,
                 width: 165
                 ,
                 ),
                 Padding(padding: EdgeInsets.all(10)),
                  OutlineButton(
          borderSide: BorderSide(color : Colors.transparent),

                   onPressed: ()=>navigateToHospital(),
                
                 child : Text(
                 "National Hospital\n      Statistics",
                 //"          Indian \n Hospital Statistics",
                 style: TextStyle(
                   fontSize: 15,
                   color:Colors.white70,
                   fontWeight: FontWeight.bold),
                   ),
                  ),

                 ]))


      ) ),
     
           ],
           ),
           ),

           Padding(padding: EdgeInsets.only(top :20.0,left: 10.0)),
                 Container(
         child:Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[ 

            Card(
                   child :Container(color: Color(0xFF292929),
                  child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[

                     
                 Padding(padding: EdgeInsets.only(top :20.0)),

                 Image(image: AssetImage("images/hospitallogo.jpg"),
                 height: 165,
                 width: 165
                 ,
                 ),
                 Padding(padding: EdgeInsets.all(10)),
                 OutlineButton(
                    borderSide: BorderSide(color : Colors.transparent),

                   onPressed: ()=> navigateToHstate(),
                
                 child : Text(
                  "State Hospital\n    Statistics",
                  //"    Indian Hospitals \n Statewise Statistics",
                 style: TextStyle(
                  fontSize: 15,
                  color:Colors.white70,
                  fontWeight: FontWeight.bold
                  ),
                  ),
                    ),

                 ]))


          ) ),
      ]

           ) ),


          InfoPanel(),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'STAY STRONG STAY HOME',
            
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 16,
              fontFamily: 'Lobster'
              ),
          )),
          SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}