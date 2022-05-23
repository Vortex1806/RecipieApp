import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class RecipieScreen extends StatelessWidget {
  static const routeName = '/recipie_screen';

  final Function toggleFacorites;
  final Function isFavorite;

  RecipieScreen(this.toggleFacorites, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedRecipie =
        DUMMY_MEALS.firstWhere(((meal) => meal.id == mealId));

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedRecipie.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedRecipie.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(selectedRecipie.ingredients[index])),
                ),
                itemCount: selectedRecipie.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(selectedRecipie.steps[index]),
                  ),
                  Divider()
                ],
              ),
              itemCount: selectedRecipie.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () => toggleFacorites(mealId),
      ),
    );
  }
}
