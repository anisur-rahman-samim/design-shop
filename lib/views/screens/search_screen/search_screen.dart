import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/product_details_controller.dart';
import '../../../controllers/searchControler.dart';
import '../../widgets/custom_buton_outline.dart';
import '../../widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());

  TextEditingController searchText = TextEditingController();

  ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    print("======================> ${searchText}");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white70,
          // leading: Icon(Icons.arrow_back),
          title: Container(
            height: 45,
            child: TextFormField(
              controller: searchText,
              onChanged: (searchValue) {searchScreenController.getSearchData( search: searchValue);},
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {
                        // SaveText(searchText.text);
                      },
                      icon: Icon(Icons.search)),
                  hintText: "Search here",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          // actions: const [
          //   Badge(
          //       alignment: Alignment.center,
          //       label: Text("2"),
          //       child: Icon(Icons.shopping_cart))
          // ],
        ),
        body: GetBuilder<SearchScreenController>(builder: (controller) {
          return controller.isLoading? const Center(child: CircularProgressIndicator()) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                ),
                Obx(() => searchScreenController.products.isEmpty? Center(child: Text("Item not found")) : Container(
                  margin: EdgeInsets.only(top: 30),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: searchScreenController.products.length,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  /*GridView.builder(
                    itemCount: searchScreenController.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 5, crossAxisCount: 2),*/
                    itemBuilder: (context, index) {
                      var product = searchScreenController.products[index];
                      print("===========${searchScreenController.products.length}");
                      return Card(
                        elevation: 0,
                        child: GestureDetector(
                          onTap: () {
                            productDetailsController.getProductDetailsRepo(
                                product.sId!, product.productName!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: const Color(0xFF54A630),),

                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0))
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: Image.network(
                                product.productImage!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        // child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Expanded(
                        //       flex: 8,
                        //       child: Image.network(product.productImage,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 7,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(product.productName),
                        //           // Text("${product["price"]}"),
                        //           const SizedBox(
                        //             height: 7,
                        //           ),
                        //           //
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                      );
                    },
                  ),
                )),
              ],
            ),
          );
        },),
    );
  }
  //
  // Future<void> SaveText(String text) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("searchText", text);
  // }
  //
  // Future<void> saveText() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String text = preferences.getString("searchText") ?? "";
  //
  //   setState(() {
  //     searchText = text as TextEditingController;
  //     searchText.addListener(() {
  //       text;
  //     });
  //   });
  // }
}
