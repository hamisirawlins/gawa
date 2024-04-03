import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gawa/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:gawa/core/utils/image_picker.dart';
import 'package:gawa/modules/collection/presentation/bloc/collections_bloc.dart';
import 'package:gawa/modules/collection/presentation/pages/collection.dart';
import 'package:gawa/modules/collection/presentation/widgets/collection_editor.dart';
import 'package:gawa/core/utils/get_screen_size.dart';

import '../../../../core/common/widgets/show_snackbar.dart';

class AddCollectionScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddCollectionScreen());
  const AddCollectionScreen({super.key});

  @override
  State<AddCollectionScreen> createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  List<String> selectedPayment = ['M-Pesa'];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadCollection() {
    if (formkey.currentState!.validate() &&
        selectedPayment.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<CollectionsBloc>().add(CollectionUpload(
          userId: userId,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          amount: num.parse(amountController.text.trim()),
          paymentMethods: selectedPayment,
          image: image!));
    } else {
      showSnackBar(context,
          'Ensure all fields are filled and a payment option is selected');
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A Collection'),
        actions: [
          IconButton(
            onPressed: () {
              uploadCollection();
            },
            icon: const Icon(
              Icons.done_all_rounded,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: BlocConsumer<CollectionsBloc, CollectionsState>(
        listener: (context, state) {
          if (state is CollectionsSuccess) {
            Navigator.pushAndRemoveUntil(
                context, CollectionsPage.route(), (route) => false);
          } else if (state is CollectionsFaulure) {
            showSnackBar(context, state.message);
          } else if (state is CollectionsLoading) {
            showSnackBar(context, 'Uploading Collection...');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                height: SizeConfig.screenHeight * 0.25,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: Colors.grey[600]!,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              child: SizedBox(
                                height: SizeConfig.screenHeight * 0.25,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_sharp,
                                      size: SizeConfig.screenHeight * 0.04,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.04,
                                    ),
                                    Text(
                                      "Add Collection Image",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenHeight * 0.022,
                                          color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.014,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'M-Pesa',
                          'Card',
                        ]
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.02),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedPayment.contains(e)) {
                                      selectedPayment.remove(e);
                                    } else {
                                      selectedPayment.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    side: BorderSide.none,
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>((Set<MaterialState> states) {
                                      if (selectedPayment.contains(e)) {
                                        return Colors.blue[100];
                                      }
                                      return null;
                                    }),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.014,
                    ),
                    CollectionEditor(
                        controller: nameController,
                        hintText: 'Collection Name'),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.014,
                    ),
                    CollectionEditor(
                        controller: descriptionController,
                        hintText: 'Description'),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.014,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'A Target Amount is required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid Amount';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
