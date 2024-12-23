import 'package:flutter/material.dart';
import 'package:percobaan1/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Title Api",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Api-Post")),
        body: FutureBuilder<List<dynamic>>(
            future: apiService.fetchPhotos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.network(
                            snapshot.data![index]['thumbnailUrl'],
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![index]['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }));
  }
}

// class HomeScreen extends StatelessWidget {
//   final ApiService apiService = ApiService();

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Api-Post")),
//         body: FutureBuilder<List<dynamic>>(
//             future: apiService.fetchPost(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index]['title']),
//                         subtitle: Text(snapshot.data![index]['body']),
//                       );
//                     });
//               }
//             }));
//   }
// }
