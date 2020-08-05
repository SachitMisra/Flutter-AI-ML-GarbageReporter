import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'main.dart';
import 'picture.dart';

class DetailPage extends StatefulWidget {
  final Data data;
  final PicData strd;
  DetailPage({
    Key key,
    this.data,
    this.strd,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(this.data, this.strd);
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState(Data data, PicData strd);
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String locationmessage = "80.0466259,12.8247617",
      addressmessage = "80.0466259,12.8247617",
      address1message = "Kattankulathur, 603203, Tamil Nadu, India",
      s1;
  bool analyzed = true, uploaded = true, isvisible = true;

  void getlocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationmessage = "${position.latitude},${position.longitude}";
    });
  }

  void getadress() async {
    final position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = p[0];
    setState(() {
      addressmessage = "${position.longitude},${position.latitude}";
      address1message =
          "${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country} ";
    });
  }

  int once = 1;
  String url = "";
  String respons="";
  String detected = "",registered="";
  void post() async {
    var result = await http.post(
      url,
    );
    print(result.body);
    respons = result.body.toString();
    if(respons.substring(respons.length-1)=="0")
    {
      setState(() {
        detected="Garbage Detected";
      });
    }
    else if(respons.substring(respons.length-1)=="1")
    {
      setState(() {
        detected="Potholes Detected";
      });
    }
    else if(respons.substring(respons.length-1)=="2")
    {
      setState(() {
        detected="Stray Cattle Detected";
      });
    }
    else if(respons.substring(respons.length-1)=="3")
    {
      setState(() {
        detected="Nothing Detected";
      });
    }
    var afteresult = await http.post(
      respons,
    );
    print(afteresult.body);
    if(afteresult.body.toString()=="Successfully registered!!")
    {
      setState(() {
        registered = "Your complaint has been successfully registered in our database";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (once == 1) {
      Timer(Duration(milliseconds: 3000), () {
        //getadress();
        setState(() {
          getlocation();
            getadress();
          analyzed = false;
        });
      });
      once = 0;
    }
    final levelIndicator = Container(
        child: Container(
      child: analyzed
          ? LinearProgressIndicator(
              backgroundColor: Colors.indigo,
              valueColor: AlwaysStoppedAnimation(Colors.green))
          : LinearProgressIndicator(
              backgroundColor: Colors.indigo,
              valueColor: AlwaysStoppedAnimation(Colors.green),
              value: 1,
            ),
    ));

    final coursePrice = Container(
        /*padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "Free",
        style: TextStyle(color: Colors.white),
      ),*/
        );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100.0),
        Icon(
          Icons.image,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 990.0,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        analyzed
            ? Text(
                "Analyzing Image",
                style: TextStyle(color: Colors.white, fontSize: 45.0),
              )
            : uploaded
                ? Text(
                    "Uploaded Successfully",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  )
                : Text(
                    "Submitted Successfully",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: analyzed
                        ? Text(
                            "Processing...",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "Anazlyzed",
                            style: TextStyle(color: Colors.white),
                          ))),
            Expanded(flex: 1, child: coursePrice),
            
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: 990.0,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 20.0),
        Text(detected,style: TextStyle(color: Colors.white, fontSize: 20.0),),
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/maps.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //color: Color.fromRGBO(58, 66, 86, .9)
            color: Colors.indigo,
          ),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );
    /*final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 45),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 3,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          onPressed: () async {
            getlocation();
            
          },
          //color: Color.fromRGBO(58, 66, 86, 1.0),
          color: Colors.indigo,
          child: Text("Get Location", style: TextStyle(color: Colors.white)),
        )
    );*/
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(address1message,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 30.0),
            Icon(
          Icons.done,
          color: Colors.green,
          size: 40.0,
        ),
            Container(
          width: 990.0,
          child: new Divider(color: Colors.black54),
        ),
          Text(registered,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,)
            //Text(locationmessage+"hello"),
            
            /*RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              onPressed: () {
                setState(() {
                  url = "http://192.168.43.189:8000/post/" +
                      data.txcontroller.text +
                      "/" +
                      DateTime.now().hour.toString() +
                      DateTime.now().minute.toString() +
                      DateTime.now().second.toString() +
                      "/" +
                      locationmessage +
                      "/";
                });
                post();
              },
              //color: Color.fromRGBO(58, 66, 86, 1.0),
              color: Colors.indigo,
              child:
                  Text("Post Request", style: TextStyle(color: Colors.white)),
            ),*/
          ],
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          label: Text("Submit"),
          icon: Icon(
            Icons.local_post_office,
          ),
          onPressed: () {
            getlocation();
            getadress();
            setState(() {
              url = "http://aryasekhar0704.pythonanywhere.com/post/" +
                  data.txcontroller.text +
                  "/" +
                  datetimestr +
                  ".png" +"/"
                  +
                  addressmessage
                   ;
            });
            print(url);
            post();
            analyzed = false;
            uploaded = false;
            isvisible = false;
          },
        ),
        visible: isvisible,
      ),
      body: Column(
        children: <Widget>[
          topContent,
          bottomContent,
        ],
      ),
    );
  }
}
