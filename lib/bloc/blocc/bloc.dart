import 'dart:async';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';



import '../../model/model_create.dart';
import '../../model/modelchats.dart';
import '../../pages/notification.dart';
import '../../pages/profile.dart';
import '../bloc_state/bloc_state.dart';


class BlocPage extends Cubit<BlocState> {
  BlocPage() : super(InitializeBlocState());

  static BlocPage get(context) => BlocProvider.of(context);
  UserCreateModel? model;
  Completer<GoogleMapController> controlMap = Completer();
  CameraPosition positionOld =
  const CameraPosition(target: LatLng(30.671025, 30.948486), zoom: 14.756);
  Marker mMarker = const Marker(
      markerId: MarkerId('positionOld'),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Google plex'),
      position: LatLng(30.671025, 30.948486));

  CameraPosition kLake = const CameraPosition(
    target: LatLng(30.680569, 30.940295),
    zoom: 19.546,
    tilt: 59.440717697143555,
    bearing: 192.8334901395799,
  );
  Marker lLake = Marker(
      markerId: const MarkerId('kLake'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'home'),
      position: const LatLng(30.680569, 30.940295));

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lag = place['geometry']['location']['lag'];
    final GoogleMapController control = await controlMap.future;
    control.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lag), zoom: 12)));
    emit(GoToPlaceEmit());
  }

  Future<void> newPosition() async {
    final GoogleMapController control = await controlMap.future;
    control.animateCamera(CameraUpdate.newCameraPosition(kLake));
    emit(ChangeMapLocation());
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    ChatDetailsModel chatModel = ChatDetailsModel(
      text: text,
      sendId: model!.uId,
      receiveId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(model!.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }


  List<UserCreateModel> allUsers = [];

  void getAllUsers() {
    // emit(LoadingGetAllUsersStateHome());
    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        emit(SuccessGetAllUsersStateHome());
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId) {
            allUsers.add(UserCreateModel.fromJson(element.data()));
          }
        });
      }).catchError((error) {
        emit(ErrorGetAllUsersStateHome(error.toString()));
      });
    }
  }



  void removeImageSender() {
    imageSend = null;
    emit(RemoveImageSenderSuccess());
  }

  void sendChatDetails({
    required String text,
    required String dateTime,
    required String? receiveID,
    required String image,
  }) {
    ChatDetailsModel modelDetails = ChatDetailsModel(
      dateTime: dateTime,
      text: text,
      receiveId: receiveID,
      sendId: model!.uId,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveID)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }


  // void getUserData() {
  //   emit(LoadingGetDataStateHome());
  //
  //   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
  //     // print(value.data());
  //     model = UserCreateModel.fromJson(value.data());
  //     emit(SuccessGetDataStateHome());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ErrorGetDataStateHome(error.toString()));
  //   });
  // }


  List<ChatDetailsModel> messages = [];

  void getMessages({
    required String? receiveID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatDetailsModel.fromJson(element.data()));
      });
      emit(SuccessGetAllChatsDetailsStateHome());
    });
  }


  File? imageSend;

  Future<void> getImageSend() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageSend = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseCoverPickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseCoverPickerScreenError());
    }
  }

  void uploadingImageSend({
    required String text,
    required String dateTime,
    required String? receiveID,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref('messages')
        .child('messages/${Uri.file(imageSend!.path).pathSegments.last}')
        .putFile(imageSend!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendChatDetails(
            text: text, dateTime: dateTime, receiveID: receiveID, image: value);
      }).catchError((error) {
        emit(ErrorGetImageSendDetailsStateHome(error.toString()));
      });
    }).catchError((error) {
      emit(ErrorGetImageSendDetailsStateHome(error.toString()));
    });
  }

  String dropDownValue = 'item1';

  var items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];

  int currentIndex = 0;

  List<Widget> screens = [
    Notification_Page(),
    Container(),
    Profile()
  ];

  void changeScreen(index) {
    currentIndex = index;
    emit(ChangeScreenBottomNavBar());
  }
  int val = 1;

  increaseVal() {
    val += 1;
    emit(BlocStateIncrease());
  }

  decreaseVal() {
    val -= 1;
    emit(BlocStateDecrease());
  }

  changeItem(String? newValue) {
    dropDownValue = newValue!;
    emit(BlocStateHappened());
  }


}






