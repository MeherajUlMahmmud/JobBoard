import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jobboard/apis/api.dart';
import 'package:jobboard/providers/UserProfileProvider.dart';
import 'package:jobboard/providers/user_provider.dart';
import 'package:jobboard/screens/utility_screens/ImageViewScreen.dart';
import 'package:jobboard/utils/urls.dart';
import 'package:jobboard/widgets/custom_button.dart';
import 'package:jobboard/widgets/custom_text_form_field.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/update-profile';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late UserProvider userProvider;
  late String accessToken;

  late UserProfileProvider userProfileProvider;
  late String applicantId,
      organizationId,
      firstName,
      lastName,
      name,
      phoneNumber;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  bool isSubmitting = false;
  bool isError = false;
  String errorText = '';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Map<String, dynamic> updatedProfileData = {
    'first_name': '',
    'last_name': '',
    'phone_number': '',
  };

  // image
  File? imageFile;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    userProfileProvider = Provider.of<UserProfileProvider>(
      context,
      listen: false,
    );
    if (userProvider.userData?.isApplicant == true) {
      applicantId =
          userProfileProvider.userProfile.applicantData!.id.toString();
      firstName =
          userProfileProvider.userProfile.applicantData?.firstName ?? '';
      lastName = userProfileProvider.userProfile.applicantData?.lastName ?? '';
      phoneNumber =
          userProfileProvider.userProfile.applicantData?.phoneNumber ?? '';
    } else {
      organizationId =
          userProfileProvider.userProfile.organizationData!.id.toString();
      name = userProfileProvider.userProfile.organizationData?.name ?? '';
    }

    imageFile = File('assets/avatars/rdj.png');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  Future<File> getFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    File file = File(image!.path);
    return file;
  }

  Future<File> cropImage({required File imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    return File(croppedFile!.path);
  }

  handleSubmit() {
    setState(() {
      isSubmitting = true;
    });
    String url = '';
    if (userProvider.userData?.isApplicant == true) {
      url = '${URLS.kApplicantUrl}$applicantId/update/';
    } else {
      url = '${URLS.kApplicantUrl}$organizationId/update/';
    }
    APIService()
        .sendPatchRequest(
      accessToken,
      updatedProfileData,
      url,
    )
        .then((data) async {
      if (data['status'] == 200) {
        setState(() {
          isSubmitting = false;
        });
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          isSubmitting = false;
          isError = true;
          errorText = data['error'];
        });
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isError = true;
        errorText = e.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.save),
      //   onPressed: () {
      //     if (_formKey.currentState!.validate()) handleSubmit();
      //   },
      // ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 30.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: CustomButton(
          text: 'Update Profile',
          isLoading: isSubmitting,
          isDisabled: isLoading,
          onPressed: () {
            if (_formKey.currentState!.validate()) handleSubmit();
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ImageFullScreenWrapperWidget(
                              dark: true,
                              // child: Image.asset("assets/avatars/rdj.png"),
                              child: Image.asset(imageFile!.path),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                getFromGallery().then((value) {
                                  cropImage(imageFile: value).then((value) {
                                    setState(() {
                                      imageFile = value;
                                    });
                                  });
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        width: width,
                        controller: firstNameController,
                        labelText: 'First Name',
                        hintText: 'First Name',
                        prefixIcon: Icons.person_outline,
                        textCapitalization: TextCapitalization.words,
                        borderRadius: 10,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            updatedProfileData['first_name'] = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        width: width,
                        controller: lastNameController,
                        labelText: 'Surname',
                        hintText: 'Surname',
                        prefixIcon: Icons.person_outline,
                        textCapitalization: TextCapitalization.words,
                        borderRadius: 10,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            updatedProfileData['last_name'] = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter surname';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        width: width,
                        controller: phoneController,
                        labelText: 'Phone Number',
                        hintText: 'Phone Number',
                        prefixIcon: Icons.phone,
                        textCapitalization: TextCapitalization.none,
                        borderRadius: 10,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            updatedProfileData['phone_number'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
