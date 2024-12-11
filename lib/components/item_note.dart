import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/pages/note_page.dart';
import 'package:flutter_application_1/models/cart.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({
    Key? key,
    required this.note,
    required this.cart,
    required this.onFavoriteToggle,
    required this.isFavorite,
  }) : super(key: key);

  final Note note;
  final Cart cart;
  final Function(Note, bool) onFavoriteToggle; // Функция для переключения состояния избранного
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePage(note: note, cart: cart),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(205, 255, 255, 255),
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: const Color.fromARGB(115, 255, 255, 255),
              width: 4.0,
            ),
          ),
          width: double.infinity,
          height: 600,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Загрузка изображения из сети
                  Image.network(
                    note.photoId,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Ошибка загрузки изображения'));
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${note.price} ₽', // Используем поле price
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 128, 0, 0)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    note.title, // Используем поле title
                    style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        cart.addItem(note);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Вы добавили в корзину ${note.title} за ${note.price}')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Icon(Icons.shopping_cart, size: 24),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : const Color.fromARGB(255, 198, 187, 186),
                  ),
                  onPressed: () async {
                    // Если товар уже в избранном, удаляем его
                    if (isFavorite) {
                      await onFavoriteToggle(note, false); // Удаляем из избранного
                    } else {
                      // Если товар не в избранном, добавляем его
                      await onFavoriteToggle(note, true); // Добавляем в избранное
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
