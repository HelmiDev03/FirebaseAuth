import 'package:loginsignup/widgets/health_needs.dart';
import 'package:loginsignup/widgets/nearby_doctors.dart';
import 'package:loginsignup/widgets/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsignup/user_model.dart';
import 'package:loginsignup/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget {
  final String name ;
  const HomePage({Key? 
   key,required this.name}) : super(key: key);

  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
   void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    var data = snapshot.data();
    if (data != null) {
      setState(() {
        this.loggedInUser = UserModel.fromMap(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //take widget.name after remoing @gmail.com


            Text(widget.name.replaceFirst('@gmail.com', '')),
         
         
            SizedBox(height: 4),
             
            Text(
              "How are you feeling today?",
              style: TextStyle( fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
               ),
            ),
          ],
        ),
        actions: [
           ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                       logout(context);
                    
                  }),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          ),
          
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.search_outline),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        
        padding: const EdgeInsets.all(14),
        children: [
          
          const UpcomingCard(),
          const SizedBox(height: 20),
          Text(
            "Health Needs",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 15),
          const HealthNeeds(),
          const SizedBox(height: 25),
          Text(
            "Nearby Doctors",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 15),
          const NearbyDoctors(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            activeIcon: Icon(Ionicons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.calendar_outline),
            activeIcon: Icon(Ionicons.calendar),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.chatbubble_ellipses_outline),
            label: "Home",
            activeIcon: Icon(Ionicons.chatbubble_ellipses),
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            activeIcon: Icon(Ionicons.person),
            label: "Home",
          ),
        ],
      ),
    );
  }

   Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
