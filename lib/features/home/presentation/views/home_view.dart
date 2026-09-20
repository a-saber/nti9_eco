import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti9_eco/core/helper/my_navigator.dart';
import 'package:nti9_eco/core/utils/app_paddings.dart';
import 'package:nti9_eco/features/cart/presentation/views/cart_view.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_categories/get_categories_cubit.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_categories/get_categories_state.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_sliders/get_sliders_cubit.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_sliders/get_sliders_state.dart';
import 'package:nti9_eco/features/home/presentation/views/search_view.dart';
import 'package:nti9_eco/features/home/presentation/views/widgets/search_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetSlidersCubit()..fetch()),
        BlocProvider(create: (context) => GetCategoriesCubit()..fetch()),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart_checkout_rounded),
          onPressed: () => MyNavigator.goTo(context, toPage: CartView()),
        ),
        appBar: AppBar(title: Text('Home')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: AppPaddings.defaultPadding,
                child: SearchField(
                  readOnly: true,
                  onTap: () => MyNavigator.goTo(context, toPage: SearchView()),
                ),
              ),
              SizedBox(height: 20),

              // Categories
              BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                builder: (context, state) {
                  if (state is GetCategoriesLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetCategoriesErrorState) {
                    return Center(child: Text(state.errorMsg));
                  } else if (state is GetCategoriesSuccessState) {
                    return SizedBox(
                      height: 100,
                      child: ListView.separated(
                        padding: AppPaddings.defaultPadding,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                state.categories[index].imagePath ?? '',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(state.categories[index].title ?? ''),
                          ],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20),
                        itemCount: state.categories.length,
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 20),

              // Sliders
              BlocBuilder<GetSlidersCubit, GetSlidersState>(
                builder: (context, state) {
                  if (state is GetSlidersLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetSlidersErrorState) {
                    return Center(child: Text(state.errorMsg));
                  } else if (state is GetSlidersSuccessState) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 400.0,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                      ),

                      items: state.sliders.map((sliderModel) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: AppPaddings.defaultPadding,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    sliderModel.imagePath ?? '',
                                  ),
                                ),
                              ),
                              child: Text(
                                '${sliderModel.title}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
