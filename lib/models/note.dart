import 'dart:convert';
import 'package:dio/dio.dart';

class Note {
  final String id;
  final String photoId;
  final String title;
  final String description;
  final String price;
  final String ram;
  final String simCards;
  final String supports5G;
  final String screenSize;
  final String refreshRate;
  final String camera;
  final String processor;
  bool isLiked;
  int quantity;

  Note({
    required this.id,
    required this.photoId,
    required this.title,
    required this.description,
    required this.price,
    required this.ram,
    required this.simCards,
    required this.supports5G,
    required this.screenSize,
    required this.refreshRate,
    required this.camera,
    required this.processor,
    this.isLiked = false,
    this.quantity = 1,
  });

  // Метод для получения всех заметок
  static Future<List<Note>> fetchNotes() async {
    final dio = Dio();
    final response = await dio.get('http://10.0.2.2:8080/notes');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      return jsonResponse.map((note) => Note.fromJson(note)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  // Метод для создания новой заметки
  static Future<Note> createNote(Note note) async {
    final dio = Dio();
    final response = await dio.post(
      'http://10.0.2.2:8080/notes/create',
      data: note.toJson(), // Используем метод toJson
    );

    if (response.statusCode == 201) {
      return Note.fromJson(response.data);
    } else {
      throw Exception('Failed to create note');
    }
  }

  // Метод для создания объекта Note из JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      photoId: json['photo_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      ram: json['ram'],
      simCards: json['simCards'],
      supports5G: json['supports5G'],
      screenSize: json['screenSize'],
      refreshRate: json['refreshRate'],
      camera: json['camera'],
      processor: json['processor'],
      isLiked: json['isLiked'],
      quantity: json['quantity'],
    );
  }

  // Метод для преобразования объекта Note в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo_id': photoId,
      'title': title,
      'description': description,
      'price': price,
      'ram': ram,
      'simCards': simCards,
      'supports5G': supports5G,
      'screenSize': screenSize,
      'refreshRate': refreshRate,
      'camera': camera,
      'processor': processor,
      'isLiked': isLiked,
      'quantity': quantity,
    };
  }
}
