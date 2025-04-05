import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constant/app_color.dart';
import 'package:weather_app/screen/weather/weather_controller.dart';
import 'package:weather_app/screen/weather/weather_state.dart';
import 'package:weather_app/screen/weather/widget/error_view.dart';
import 'package:weather_app/widget/loading_view.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherBloc(), child: WeatherScreen());
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _sizeAnim;

  final globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _sizeAnim = Tween<double>(begin: 0.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(listener: (context, state) {
      if (state.hasFetchSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox =
              globalKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final size = renderBox.size;
            _sizeAnim = Tween<double>(begin: size.height, end: 0.0).animate(
                CurvedAnimation(parent: _controller, curve: Curves.linear));
            _controller.reset();
            _controller.forward();
          }
        });
      }
    }, builder: (context, state) {
      final bloc = context.read<WeatherBloc>();
      return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: state.isError
            ? ErrorView(onTap: bloc.fetchWeather)
            : state.isLoading
                ? LoadingView()
                : _buildWeatherScreen(state),
      );
    });
  }

  Widget _buildWeatherScreen(WeatherState state) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 56),
          Text(
            '${(state.weatherModel?.main?.temp ?? 0.0)}',
            style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryTextColor),
          ),
          const SizedBox(height: 16),
          Text('Bangalore',
              style:
                  TextStyle(fontSize: 36, color: AppColor.secondaryTextColor)),
          const SizedBox(height: 62),
          Expanded(
              child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, _sizeAnim.value),
              child: Container(
                key: globalKey,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: AppColor.secondaryTextColor.withOpacity(.1),
                      blurRadius: 20,
                      offset: const Offset(0, -10))
                ]),
                child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemCount: state.weatherNextFewDays?.length ?? 0,
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppColor.secondaryTextColor.withOpacity(.1)),
                    itemBuilder: (context, index) {
                      final model = state.weatherNextFewDays?[index];
                      return SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Text(
                                DateFormat("EEEE")
                                    .format(model?.time ?? DateTime.now()),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.primaryTextColor)),
                            Spacer(),
                            Text('${model?.main?.temp ?? 0.0} C',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.primaryTextColor)),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
