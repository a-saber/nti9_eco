import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti9_eco/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:nti9_eco/features/home/presentation/cubit/search/search_cubit.dart';
import 'package:nti9_eco/features/home/presentation/cubit/search/search_state.dart';
import 'package:nti9_eco/features/home/presentation/views/widgets/search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SearchField(
                    readOnly: false,
                    controller: context.read<SearchCubit>().q,
                    onChanged: (value) => context.read<SearchCubit>().search(),
                  ),
                  SizedBox(height: 17.h),

                  Builder(
                    builder: (context) {
                      if (state is SearchLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SearchErrorState) {
                        return Center(child: Text(state.errorMsg));
                      } else if (state is SearchSuccessState) {
                        return Expanded(
                          child: Column(
                            children: [
                              Text('${state.products.length} items'),
                              SizedBox(height: 17.h),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var product = state.products[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 2),
                                            color: Colors.black.withValues(
                                              alpha: 0.15,
                                            ),
                                            blurRadius: 2.r,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),

                                            child: Image.network(
                                              product.imagePath ?? '',
                                              height: 200.h,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            product.name ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            product.description ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text('₹ ${product.price}'),
                                          Text('${product.rating}'),
                                          SizedBox(
                                            width: 200.w,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<CartCubit>()
                                                    .addProduct(
                                                      product: product,
                                                    );
                                              },

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.shopping_bag),
                                                  SizedBox(width: 10),
                                                  Text('Add To Cart'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemCount: state.products.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
