import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(0, 75, 136, 132),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.9YeQihZ5H7XI_2fyO0q_RwHaHa?w=228&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                  height: 25,
                  width: 25,
                ),
              ),
              title: const Text(
                'Waterproofing Works Specialist',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
              actions: [
                Icon(Icons.person_4_outlined),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Hii Employee 1 !",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // SizedBox(height: 10),
                      Text("Employee ID : E135689",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(height: 80),
                      Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.card_membership_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Stock Inventory")
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.account_balance_wallet_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Material Requisition")
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.car_crash_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Fuel Inventory")
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.calendar_month_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Daily Record")
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.personal_injury_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Leave Request")
                        ],
                      ),
                      SizedBox(width: 125)
                    ],
                  )
                ],
              ),
            )));
  }
}
