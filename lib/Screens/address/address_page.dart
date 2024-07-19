import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/address/pickAddress_page.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/sign_up_field.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Widgets/small_text.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoggedIn;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _isLoggedIn = Get.find<AuthController>().isUserLoggedIn();
  //   if (_isLoggedIn && Get.find<UserController>().userModel == null) {
  //     Get.find<UserController>().getUserInfo();
  //   }
  //   if (Get.find<LocationController>().addressList.isNotEmpty) {
  //     Get.find<LocationController>().getUserAddress();
  //     // Get.find<LocationController>().getUserAddress();
  //     _cameraPosition = CameraPosition(
  //       target: LatLng(
  //         double.parse(Get.find<LocationController>().getAddress["latitude"]),
  //         double.parse(Get.find<LocationController>().getAddress["longitude"]),
  //       ),
  //       zoom: 17,
  //     );
  //     _initialPosition = LatLng(
  //       double.parse(Get.find<LocationController>().getAddress["latitude"]),
  //       double.parse(Get.find<LocationController>().getAddress["longitude"]),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromStorage() == "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      double latitude =
          double.parse(Get.find<LocationController>().getAddress["latitude"]);
      double longitude =
          double.parse(Get.find<LocationController>().getAddress["longitude"]);
      _cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 17,
      );
      _initialPosition = LatLng(latitude, longitude);
    } else {
      print("Address list is empty.");
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments;
      if (args != null && args['pickedAddress'] != null) {
        double latitude = args['pickedLatitude'];
        double longitude = args['pickedLongitude'];
        setState(() {
          _addressController.text = args['pickedAddress'];
          _cameraPosition = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 17,
          );
          _initialPosition = LatLng(latitude, longitude);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonNameController.text.isEmpty) {
            _contactPersonNameController.text =
                '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            var address = Get.find<LocationController>().getUserAddress();
            if (address != null &&
                Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text = address.address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placeMark.name ?? ''}'
                  '${locationController.placeMark.locality ?? ''}'
                  '${locationController.placeMark.postalCode ?? ''}'
                  '${locationController.placeMark.country ?? ''}';
              print("address in my view is " + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.height120 + Dimensions.height20,
                      width: MediaQuery.sizeOf(context).width,
                      margin: EdgeInsets.only(
                          left: Dimensions.width5,
                          right: Dimensions.width5,
                          top: Dimensions.height5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.height5),
                        border:
                            Border.all(width: 2, color: AppColors.mainColor),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(
                                RouteHelper.getPickAddressPage(),
                                arguments: PickAddressPage(
                                  fromLogIn: false,
                                  fromAddress: true,
                                  googleMapController:
                                      locationController.mapController,
                                ),
                              );
                            },
                            indoorViewEnabled: true,
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20, left: Dimensions.width20),
                      child: SizedBox(
                        height: Dimensions.height50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                      vertical: Dimensions.height10),
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.height20 / 4),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    index == 0
                                        ? Icons.home_filled
                                        : index == 1
                                            ? Icons.work
                                            : Icons.location_on,
                                    color:
                                        locationController.addressTypeIndex ==
                                                index
                                            ? AppColors.mainColor
                                            : Theme.of(context).disabledColor,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width30),
                      child: BigText(text: "Delivery Address"),
                    ),
                    SizedBox(height: Dimensions.height10),
                    SignUpFields(
                      hintText: "Address",
                      textController: _addressController,
                      icon: Icons.location_on,
                    ),
                    SizedBox(height: Dimensions.height10),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width30),
                      child: BigText(text: "Name"),
                    ),
                    SizedBox(height: Dimensions.height10),
                    SignUpFields(
                      hintText: "Name",
                      textController: _contactPersonNameController,
                      icon: Icons.person,
                    ),
                    SizedBox(height: Dimensions.height10),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width30),
                      child: BigText(text: "Contact No"),
                    ),
                    SizedBox(height: Dimensions.height10),
                    SignUpFields(
                      hintText: "Phone",
                      textController: _contactPersonNumber,
                      icon: Icons.phone_android,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height45),
                    topRight: Radius.circular(Dimensions.height45),
                  ),
                  color: AppColors.buttonBackgroundColor,
                ),
                padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  top: Dimensions.height20,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonNameController.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        print(_addressModel.addressType.toString());
                        locationController
                            .addAddress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar(
                                "Address", "Added Address Successfully !");
                          } else {
                            Get.snackbar("Address",
                                "Couldn't Add Address Successfully !");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.height17),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                          color: AppColors.mainColor,
                        ),
                        child: SmallText(
                          text: "Save Address",
                          size: Dimensions.height20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
