// Forcing a rewrite to fix the missing category parameter.
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(100, 3000);
  final Set<String> _selectedBrands = {};

  // Corrected: Added 'images' list to each Product
  final List<Product> _allProducts = [
    Product(name: "Gaming Laptop", category: "Laptops", brand: "Dell", price: "\$1500.00", images: ["https://images.unsplash.com/photo-1593642634315-48f5414c3ad9?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.5),
    Product(name: "MacBook Pro", category: "Laptops", brand: "Apple", price: "\$2500.00", images: ["https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.8),
    Product(name: "ThinkPad X1", category: "Laptops", brand: "Lenovo", price: "\$1800.00", images: ["https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.6),
    Product(name: "Surface Laptop", category: "Laptops", brand: "Microsoft", price: "\$1200.00", images: ["https://images.unsplash.com/photo-1593642702821-c8da67b18084?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.4),
    Product(name: "Gaming Desktop", category: "Desktops", brand: "HP", price: "\$2200.00", images: ["https://images.unsplash.com/photo-1603481588273-2f908a9a7a1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.7),
    Product(name: "IdeaPad", category: "Laptops", brand: "Lenovo", price: "\$800.00", images: ["https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.2),
    Product(name: "Spectre x360", category: "Laptops", brand: "HP", price: "\$1600.00", images: ["https://images.unsplash.com/photo-1598972428028-2d8031a0e1b1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"], rating: 4.6),
  ];

  List<Product> _filteredProducts = [];
  final List<String> _brands = ["Apple", "Dell", "HP", "Lenovo", "Microsoft"];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final productName = product.name.toLowerCase();
        final brandName = product.brand.toLowerCase();
        final textMatch = productName.contains(query) || brandName.contains(query);

        final price = double.parse(product.price.replaceAll('\$', ''));
        final priceMatch = price >= _currentRangeValues.start && price <= _currentRangeValues.end;

        final brandMatch = _selectedBrands.isEmpty || _selectedBrands.contains(product.brand);

        return textMatch && priceMatch && brandMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products, brands...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
              ),
            ),
            const SizedBox(height: 20),
            Text('Price Range', style: Theme.of(context).textTheme.titleLarge),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 5000,
              divisions: 50,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
                _filterProducts();
              },
            ),
            const SizedBox(height: 20),
            Text('Brands', style: Theme.of(context).textTheme.titleLarge),
            Wrap(spacing: 8.0,
              children: _brands.map((brand) {
                final isSelected = _selectedBrands.contains(brand);
                return FilterChip(
                  label: Text(brand),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedBrands.add(brand);
                      } else {
                        _selectedBrands.remove(brand);
                      }
                    });
                    _filterProducts();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text('No products found matching your criteria.'),
                    )
                  : ProductGrid(products: _filteredProducts),
            ),
          ],
        ),
      ),
    );
  }
}
