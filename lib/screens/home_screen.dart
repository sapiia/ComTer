// Forcing a rewrite to fix the empty drawer issue.
import 'dart:async';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/product_grid.dart';
import '../widgets/section_header.dart';
import '../screens/promotion_screen.dart'; 
import '../screens/product_list_screen.dart';
import 'categories_screen.dart';
import 'category_products_screen.dart';
import 'my_orders_screen.dart';
import 'profile_screen.dart';
import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  late PageController _pageController;
  late Timer _timer;

  final List<Map<String, dynamic>> _adData = [
    {'text': '50% OFF on Gaming PCs','image': 'https://images.unsplash.com/photo-1593642634315-48f5414c3ad9?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','title': 'Gaming PCs','subtitle': 'Unleash Peak Performance','description': 'Explore our wide range of gaming PCs, built to deliver the ultimate gaming experience. Get up to 50% off for a limited time.','promo_image': 'https://images.unsplash.com/photo-1555680202-c86f0e12f086?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',},
    {'text': 'New MacBooks are Here!','image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','title': 'MacBook Collection','subtitle': 'Elegance Meets Power','description': 'Discover the latest lineup of MacBook Pro and MacBook Air, featuring the revolutionary M-series chips for incredible speed and battery life.','promo_image': 'https://images.unsplash.com/photo-1522199755839-a2bacb67c546?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',},
    {'text': 'Accessorize Your Setup','image': 'https://images.unsplash.com/photo-1603481588273-2f908a9a7a1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','title': 'PC Accessories','subtitle': 'Complete Your Battlestation','description': 'From high-speed mechanical keyboards to ergonomic mice, find the perfect accessories to complete your computer setup.','promo_image': 'https://images.unsplash.com/photo-1512756290469-ec264b7fbf87?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',},
  ];

  final List<String> _categories = ["All", "Laptops", "Desktops", "Gaming PCs", "Monitors", "Accessories"];

  late List<Product> _popularProducts;
  late List<Product> _newArrivals;
  late List<Product> _officeProducts;
  late List<Product> _powerUserProducts;
  late List<Product> _largeBusinessProducts;
  late List<Product> _secondHandProducts;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _popularProducts = allProducts.where((p) => p.isPopular).toList();
    _newArrivals = allProducts.where((p) => p.isNew).toList();
    _officeProducts = allProducts.where((p) => p.isForOffice).toList();
    _powerUserProducts = allProducts.where((p) => p.isForPowerUsers).toList();
    _largeBusinessProducts = allProducts.where((p) => p.isForLargeBusiness).toList();
    _secondHandProducts = allProducts.where((p) => p.isSecondHand).toList();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (mounted) {
         if (_currentPage < _adData.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48) / 2;
    final cardHeight = cardWidth / 0.75;

    return Scaffold(
      appBar: AppBar(title: const Text('TechShop'), actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})]),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF1E1E1E), // Dark background
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: const Text("Sophy Moeurn", style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: const Text("sophy.moeurn@example.com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                ),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2)),
              ),
              _buildDrawerItem(icon: Icons.home_outlined, text: 'Home', onTap: () => Navigator.pop(context), isSelected: true),
              _buildDrawerItem(icon: Icons.category_outlined, text: 'Categories', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen()))),
              _buildDrawerItem(icon: Icons.receipt_long_outlined, text: 'My Orders', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen()))),
              _buildDrawerItem(icon: Icons.person_outline, text: 'Profile', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()))),
              const Divider(color: Colors.white30),
              _buildDrawerItem(icon: Icons.logout, text: 'Logout', onTap: () {
                  showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('Confirm Logout'), content: const Text('Are you sure you want to log out?'), actions: [
                        TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
                        TextButton(onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (Route<dynamic> route) => false);
                          }, child: const Text('Logout', style: TextStyle(color: Colors.red))),
                      ]));
                }, textColor: Colors.red),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 180, child: PageView.builder(controller: _pageController, itemCount: _adData.length, onPageChanged: (int page) => setState(() => _currentPage = page), itemBuilder: (context, index) {
                    final ad = _adData[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: NetworkImage(ad['image']), fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: LinearGradient(begin: Alignment.bottomRight, colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.1)])),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ad['text'], style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              ElevatedButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionScreen(promotionData: ad)));
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                                child: const Text('Shop Now'),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_adData.length, (i) => AnimatedContainer(duration: const Duration(milliseconds: 300), margin: const EdgeInsets.symmetric(horizontal: 4.0), height: 8.0, width: 8.0, decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == i ? Colors.blue : Colors.grey.withOpacity(0.5)), transform: Matrix4.identity()..scale(_currentPage == i ? 1.5 : 1.0), transformAlignment: Alignment.center))),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((c) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ActionChip(
                            label: Text(c),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductsScreen(categoryName: c)));
                            },
                          ),
                        )).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "Popular", onViewAll: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "Popular", products: _popularProducts)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _popularProducts.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _popularProducts.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _popularProducts[index], heroTagPrefix: 'popular'))
                    );
                  },
                ),
              ),
               const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "New Arrivals", onViewAll: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "New Arrivals", products: _newArrivals)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _newArrivals.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _newArrivals.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _newArrivals[index], heroTagPrefix: 'new-arrivals'))
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "For Office/Home", onViewAll: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "For Office/Home", products: _officeProducts)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _officeProducts.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _officeProducts.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _officeProducts[index], heroTagPrefix: 'office-home'))
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "For Power Users", onViewAll: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "For Power Users", products: _powerUserProducts)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _powerUserProducts.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _powerUserProducts.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _powerUserProducts[index], heroTagPrefix: 'power-users'))
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "For Large Business", onViewAll: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "For Large Business", products: _largeBusinessProducts)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _largeBusinessProducts.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _largeBusinessProducts.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _largeBusinessProducts[index], heroTagPrefix: 'large-business'))
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SectionHeader(title: "Second Hand", onViewAll: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(title: "Second Hand", products: _secondHandProducts)));
                })),
              const SizedBox(height: 10),
              SizedBox(height: cardHeight, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _secondHandProducts.length, itemBuilder: (context, index) {
                    return SizedBox(width: cardWidth, child: Padding(padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == _secondHandProducts.length - 1 ? 16.0 : 8.0), child: ProductCard(product: _secondHandProducts[index], heroTagPrefix: 'second-hand'))
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SectionHeader(title: "Featured Video", onViewAll: () {}),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network("https://i.pinimg.com/originals/a1/f8/be/a1f8be54a08a324c83e747a8fa5ed660.gif", height: 200, width: double.infinity, fit: BoxFit.cover)),
                      Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(15))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Build Your Dream PC", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          ElevatedButton(onPressed: () {}, child: const Text("Shop Now")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap, bool isSelected = false, Color? textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.white70),
        title: Text(text, style: TextStyle(color: textColor ?? (isSelected ? Colors.blue : Colors.white), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
      ),
    );
  }
}
