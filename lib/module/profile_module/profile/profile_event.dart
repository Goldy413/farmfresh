part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class SelectImageEvent extends ProfileEvent {
  final XFile? file;
  SelectImageEvent(this.file);
}

class AddProfileEvent extends ProfileEvent {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String phone;
  AddProfileEvent(this.uid, this.name, this.email, this.bio, this.phone);
}

class MoveToHomeEvent extends ProfileEvent {}
