import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_11/src/bloc/usersingleton.dart';
import 'package:flutter_application_11/src/screens/api.dart';
import 'package:flutter_application_11/src/screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Post(),
  ));
}

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORSTBOOK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostList(),
    );
  }
}

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<PostModel> posts = [];

  void _showPostDetailsModal(PostModel post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
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
                  post.nombre,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                CachedNetworkImage(
                  imageUrl: post.imageUrl.isNotEmpty ? post.imageUrl : '',
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(height: 12),
                Text(
                  post.descripcion,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 12),
                Text(
                  post.lugar,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String nombreUsuario = UserSingleton().nombre;
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        backgroundColor: Color(0xFF004173),
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostForm()),
            ).then((newPost) {
              if (newPost != null) {
                setState(() {
                  posts.add(newPost);
                });
              }
            });
          },
        ),
      ),
      body: posts.isEmpty
          ? Center(
              child: Text('No hay posts creados'),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onTap: () {
                    _showPostDetailsModal(post);
                  },
                  child: Card(
                    color: Color(0xFFbbdffb),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                post.imageUrl.isNotEmpty ? post.imageUrl : '',
                            width: 100,
                            height: 100,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      nombreUsuario,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.clear, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          posts.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  post.nombre,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "!Click para mas informacion¡",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
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
                  MaterialPageRoute(builder: (context) => API()),
                );
              },
              child: Text('API'),
            ),
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
    );
  }
}

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _lugarController = TextEditingController();
  TextEditingController _imagenUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Post'),
        backgroundColor: Color(0xFF004173),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'POST',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _lugarController,
              decoration: InputDecoration(labelText: 'Lugar'),
            ),
            TextField(
              controller: _imagenUrlController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nombre = _nombreController.text.trim();
                final descripcion = _descripcionController.text.trim();
                final lugar = _lugarController.text.trim();
                final imageUrl = _imagenUrlController.text.trim();

                if (nombre.isEmpty ||
                    descripcion.isEmpty ||
                    lugar.isEmpty ||
                    imageUrl.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Todos los campos son requeridos.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (!imageUrl.toLowerCase().startsWith('http')) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text(
                          'La URL de la imagen debe comenzar con http(s).'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  final newPost = PostModel(
                    nombre: nombre,
                    descripcion: descripcion,
                    lugar: lugar,
                    imageUrl: imageUrl,
                  );
                  Navigator.pop(context, newPost);
                }
              },
              child: Text('Crear Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostModel {
  final String nombre;
  final String descripcion;
  final String lugar;
  final String imageUrl;

  PostModel({
    required this.nombre,
    required this.descripcion,
    required this.lugar,
    required this.imageUrl,
  });
}
