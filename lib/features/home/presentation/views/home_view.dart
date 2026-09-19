import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_sliders/get_sliders_cubit.dart';
import 'package:nti9_eco/features/home/presentation/cubit/get_sliders/get_sliders_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> GetSlidersCubit()..fetch(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: BlocBuilder<GetSlidersCubit, GetSlidersState>(
          builder: (context, state){
            if(state is GetSlidersLoadingState){
              return Center(child: CircularProgressIndicator());
            }
            else if(state is GetSlidersErrorState){
              return Center(child: Text(state.errorMsg));
            }
            else if(state is GetSlidersSuccessState){
              return CarouselSlider(
                options: CarouselOptions(
                    height: 400.0,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(milliseconds: 500)


                ),
                items: state.sliders.map((sliderModel) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(sliderModel.imagePath??''))
                          ),
                          child: Text('${sliderModel.title}', style: TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
              );
            }
            return SizedBox();
          }
        ),
      ),
    );
  }
}
