import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/bloc/cubit/cubit.dart';
import 'package:paymob/bloc/cubit/states.dart';
import 'package:paymob/screens/toggle_screen.dart';
import 'package:paymob/widgets/my_button.dart';
import 'package:paymob/widgets/my_form_field.dart';

var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var emailNameController = TextEditingController();
var phoneNameController = TextEditingController();
var priceNameController = TextEditingController();
var formKey = GlobalKey<FormState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PayMobCubit()..getAuth(),
      child: BlocConsumer<PayMobCubit, PayMobStates>(
        listener: (context, state) {
          if (state is GetPaymentRequestSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ToggleScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = PayMobCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.purple.shade300,
              centerTitle: true,
              title: Text(
                'PayMob',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/delivery.gif',
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyFormField(
                              controller: firstNameController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your First Name';
                                }
                                return null;
                              },
                              prefix: Icons.person,
                              label: 'first name',
                              radius: 20.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: MyFormField(
                              controller: lastNameController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Last Name';
                                }
                                return null;
                              },
                              prefix: Icons.person,
                              label: 'last name',
                              radius: 20.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      MyFormField(
                        controller: emailNameController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Email';
                          }
                          return null;
                        },
                        prefix: Icons.email_outlined,
                        label: 'email address',
                        radius: 20.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      MyFormField(
                        controller: phoneNameController,
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Phone';
                          }
                          return null;
                        },
                        prefix: Icons.phone_android,
                        label: 'phone',
                        radius: 20.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      MyFormField(
                        controller: priceNameController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Price';
                          }
                          return null;
                        },
                        prefix: Icons.attach_money,
                        label: 'price',
                        radius: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! GetRegistrationOrderLoadingState,
                        builder: (context) => MyButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.getOrderId(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailNameController.text,
                                phone: phoneNameController.text,
                                price: priceNameController.text,
                              );
                            }
                          },
                          text: 'register',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                          radius: 20.0,
                          background: Colors.purple.shade300,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
//95795843
