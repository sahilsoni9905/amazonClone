import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  const CategoryDealsScreen({super.key, required this.category});
  final String category;

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? product_list;
  final Homeservices homeservices = Homeservices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    product_list = await homeservices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: product_list == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    itemCount: product_list!.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final product = product_list![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 15),
                            child: Text(
                              product.name,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
