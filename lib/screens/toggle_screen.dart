import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/bloc/cubit/cubit.dart';
import 'package:paymob/bloc/cubit/states.dart';
import 'package:paymob/network/constance/constance.dart';
import 'package:paymob/screens/ref_screen.dart';
import 'package:paymob/screens/visa_screen.dart';
import 'package:paymob/widgets/show_snack.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayMobCubit(),
      child: SafeArea(
        child: BlocConsumer<PayMobCubit, PayMobStates>(
          listener: (context, state) {
            if (state is GetRefCodeSuccessState) {
              showSnackBar(
                context: context,
                text: "Success get ref code ",
                color: Colors.amber.shade400,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReferenceScreen(),
                ),
              );
            }
            if (state is GetRefCodeErrorState) {
              showSnackBar(
                context: context,
                text: "Error get ref code ",
                color: Colors.red,
              );
            }
          },
          builder: (context, state) {
            var cubit = PayMobCubit.get(context);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.getRefCode();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15.0),
                            border:
                                Border.all(color: Colors.black87, width: 2.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: NetworkImage(AppImages.refCodeImage),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Payment with Ref code',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VisaScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Image(
                                image: NetworkImage(AppImages.visaImage),
                              ),
                              Text(
                                'Payment with visa',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
