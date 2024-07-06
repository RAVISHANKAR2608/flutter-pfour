import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLocation = 'New York'; // Default selected location
  int _selectedIndex = 0; // Index of the selected bottom navigation bar item

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LocationBottomSheet(
          selectedLocation: selectedLocation,
          onLocationSelected: (location) {
            setState(() {
              selectedLocation = location;
            });
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amazon App Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              _showLocationBottomSheet(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selected Location: $selectedLocation',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class LocationBottomSheet extends StatelessWidget {
  final List<String> locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
  ];

  final List<String> images = [
    'https://via.placeholder.com/150/0000FF',
    'https://via.placeholder.com/150/FF0000',
    'https://via.placeholder.com/150/00FF00',
    'https://via.placeholder.com/150/FFFF00',
    'https://via.placeholder.com/150/FF00FF',
    'https://via.placeholder.com/150/00FFFF',
    'https://via.placeholder.com/150/000000',
    'https://via.placeholder.com/150/FFFFFF',
    'https://via.placeholder.com/150/808080',
    'https://via.placeholder.com/150/800000',
  ];

  final String selectedLocation;
  final Function(String) onLocationSelected;

  LocationBottomSheet(
      {required this.selectedLocation, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220, // Adjusted height for better display
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Available Locations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: locations.length,
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = locations[index] == selectedLocation;
                return GestureDetector(
                  onTap: () {
                    onLocationSelected(locations[index]);
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isSelected
                            ? Colors.blue
                            : Colors.grey, // Change border color if selected
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 150, // Fixed width for each card
                      padding: const EdgeInsets.all(8), // Adjusted padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Image.network(
                              images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.error, size: 100);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            locations[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




// Bottom Modal Sheet with Card Design


//   void _showShopSelectionSheet() {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: ListView.builder(
//           itemCount: _shops?.length ?? 0,
//           itemBuilder: (context, index) {
//             final shop = _shops![index];
//             final isSelected = shop['id'] == _selectedShopId;

//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedShopId = shop['id'];
//                   _selectedShopName = shop['name'];
//                   _selectedShopLocation = shop['location'];
//                 });

//                 print("Selected Shop ID : $_selectedShopId");
//                 print("Selected Shop Name : $_selectedShopName");
//                 print("Selected Shop Location : $_selectedShopLocation");
//                 Navigator.pop(context);
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 elevation: isSelected ? 4 : 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(
//                     color: isSelected ? Colors.blue : Colors.transparent,
//                     width: 2,
//                   ),
//                 ),
//                 child: ListTile(
//                   title: Text(shop['name']),
//                   subtitle: Text(shop['location']),
//                   trailing: isSelected ? const Icon(Icons.check) : null,
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     },
//   );
// }