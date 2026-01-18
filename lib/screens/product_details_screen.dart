import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String heroTag;

  const ProductDetailsScreen({super.key, required this.product, required this.heroTag});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedRam;
  String? _selectedStorage;
  String? _selectedColor;
  int _quantity = 1;
  int _currentPage = 0;
  late PageController _pageController;

  final Map<String, double> _ramPrice = {'8GB': 0, '16GB': 150, '32GB': 300};
  final Map<String, double> _storagePrice = {'256GB SSD': 0, '512GB SSD': 100, '1TB SSD': 250};
  final List<String> _colorOptions = ['Silver', 'Space Gray', 'Gold'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    double basePrice = double.parse(widget.product.price.replaceAll('\$', ''));
    double ramPrice = _selectedRam != null ? _ramPrice[_selectedRam]! : 0;
    double storagePrice = _selectedStorage != null ? _storagePrice[_selectedStorage]! : 0;
    return (basePrice + ramPrice + storagePrice) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final totalPrice = _calculateTotalPrice();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.heroTag,
              child: SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.product.images.length,
                  onPageChanged: (int page) => setState(() => _currentPage = page),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(widget.product.images[index], fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.product.images.length, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: _currentPage == i ? 24.0 : 8.0,
                decoration: BoxDecoration(color: _currentPage == i ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(12)),
              )),
            ),
            const SizedBox(height: 20),
            Text(widget.product.name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.product.brand, style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('\$${totalPrice.toStringAsFixed(2)}', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildDropdown('RAM', _ramPrice.keys.toList(), _selectedRam, (val) => setState(() => _selectedRam = val)),
            const SizedBox(height: 10),
            _buildDropdown('Storage', _storagePrice.keys.toList(), _selectedStorage, (val) => setState(() => _selectedStorage = val)),
            const SizedBox(height: 20),
            _buildColorSelector(),
            const SizedBox(height: 20),
            _buildQuantitySelector(),
            const SizedBox(height: 20),
            Text('Description', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('This is a placeholder description for the ${widget.product.name}. A more detailed description will be available soon...', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 120), // Space for buttons
          ],
        ),
      ),
      bottomSheet: _buildActionButtons(cart, context),
    );
  }

  Widget _buildDropdown(String title, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text('Select $title'),
          items: options.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)), contentPadding: const EdgeInsets.symmetric(horizontal: 16.0)),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(spacing: 8.0, children: _colorOptions.map((color) => ChoiceChip(label: Text(color), selected: _selectedColor == color, onSelected: (selected) => setState(() => _selectedColor = color))).toList()),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        Text('Quantity', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() => _quantity = (_quantity > 1) ? _quantity - 1 : 1)),
        Text('$_quantity', style: const TextStyle(fontSize: 18)),
        IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _quantity++)),
      ],
    );
  }

  Widget _buildActionButtons(CartProvider cart, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Expanded(child: OutlinedButton(onPressed: () {
            cart.addItem(widget.product, ram: _selectedRam, storage: _selectedStorage);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!'), duration: Duration(seconds: 2)));
          }, child: const Text("Add to Cart"))),
          const SizedBox(width: 16),
          Expanded(child: ElevatedButton(onPressed: () {
            cart.addItem(widget.product, ram: _selectedRam, storage: _selectedStorage);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CheckoutScreen()));
          }, child: const Text("Buy Now"))),
        ],
      ),
    );
  }
}
