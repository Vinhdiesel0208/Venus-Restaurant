import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Thêm import này
import 'package:thebags_mobile/models/ingredient.dart';
import 'package:thebags_mobile/apis/ingredient_api.dart';
import 'package:thebags_mobile/apis/cartline_api.dart';
import 'package:thebags_mobile/widgets/menuList/ingredient_card.dart';
import 'package:go_router/go_router.dart';

class IngredientScreen extends StatefulWidget {
  final int tableId;

  IngredientScreen({required this.tableId});

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final IngredientApi _ingredientApi = IngredientApi();
  final CartLineApi _cartLineApi = CartLineApi();
  List<Ingredient> _ingredients = [];
  List<Ingredient> _filteredIngredients = [];
  List<String> _categories = [];
  String _selectedCategory = 'All categories';
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
    _searchController.addListener(_onSearchChanged);
  }

  void _fetchIngredients() async {
    try {
      List<Ingredient> ingredients = await _ingredientApi.getIngredients();
      setState(() {
        _ingredients = ingredients;
        _filteredIngredients = ingredients;
        _categories = ['All categories'] +
            _ingredients
                .map((ingredient) => ingredient.categoryName)
                .toSet()
                .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching ingredients: $e');
    }
  }

  void _onSearchChanged() {
    setState(() {
      _filterIngredients();
    });
  }

  void _filterIngredients() {
    setState(() {
      _filteredIngredients = _ingredients
          .where((ingredient) =>
              (_selectedCategory == 'All categories' ||
                  ingredient.categoryName == _selectedCategory) &&
              ingredient.ingredientName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _filterIngredients();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void addToCart(Ingredient ingredient, double quantity) async {
    if (ingredient.quantityInStock == 0) {
      Fluttertoast.showToast(
        msg: '${ingredient.ingredientName} is temporarily out of stock.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    try {
      await _cartLineApi.addToCart(
        widget.tableId,
        ingredient.id,
        quantity,
        ingredient.price,
        false,
        "Table ${widget.tableId}",
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('${ingredient.ingredientName} added to cart')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add to cart: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        leading: IconButton(
          icon: Icon(Icons.table_restaurant),
          onPressed: () {
            GoRouter.of(context).go('/tables');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              GoRouter.of(context).go('/order-history/${widget.tableId}');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search dishes...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                if (value != null) {
                  _onCategorySelected(value);
                }
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredIngredients.length,
                    itemBuilder: (context, index) {
                      return IngredientCard(
                        ingredient: _filteredIngredients[index],
                        addToCart: addToCart,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
