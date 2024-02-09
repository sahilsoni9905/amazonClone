import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screen/product_screen_details.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widget/searched_product.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 23,
                                    ),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(top: 10),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                hintText: "search Amazon.in",
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemExtent: 150,
                    itemCount: products!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: products![index]);
                        },
                        child: Column(
                          children: [
                            SearchedProduct(product: products![index]),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              color: Color.fromARGB(165, 188, 188, 188),
                              height: 3,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
