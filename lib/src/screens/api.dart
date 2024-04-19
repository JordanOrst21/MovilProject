import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_11/src/screens/login_screen.dart';

void main() => runApp(API());

class API extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<API> {
  late Future<List<Cocktail>> _listCocktails;
  Cocktail? _selectedCocktail;

  Future<List<Cocktail>> _getCocktailsByFirstLetter(String letter) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=$letter'));

    List<Cocktail> cocktails = [];

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final drinks = jsonData['drinks'];

      for (var item in drinks) {
        cocktails.add(Cocktail(
          item['strDrink'],
          item['strDrinkThumb'] + '/preview',
          item['strInstructions'] ?? 'No instructions available',
        ));
      }
      return cocktails;
    } else {
      throw Exception('Failed to load cocktails');
    }
  }

  void _showCocktailDetailsModal(Cocktail cocktail) {
    setState(() {
      _selectedCocktail = cocktail;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Text(
                _selectedCocktail!.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Image.network(
                _selectedCocktail!.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 12),
              Text(
                _selectedCocktail!.instructions,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _listCocktails = _getCocktailsByFirstLetter('a');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de cocteles',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cocteles'),
          backgroundColor: Color(0xFF004173),
        ),
        body: FutureBuilder(
          future: _listCocktails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final data = snapshot.data as List<Cocktail>;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final cocktail = data[index];
                  return GestureDetector(
                    onTap: () {
                      _showCocktailDetailsModal(cocktail);
                    },
                    child: Card(
                      color: Color(0xFFbbdffb),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              cocktail.imageUrl,
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cocktail.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "¡Click para mas informacion!",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF004173),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('SALIR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cocktail {
  final String name;
  final String imageUrl;
  final String instructions;

  Cocktail(this.name, this.imageUrl, this.instructions);
}
