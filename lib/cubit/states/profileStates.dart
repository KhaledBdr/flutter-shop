class ProfileStates{}
class initialProfileState extends ProfileStates{}
class gettingProfileState extends ProfileStates{}
class successGettingProfileState extends ProfileStates{
  final user;
  successGettingProfileState(this.user);
}
class errorGettingProfileState extends ProfileStates{
  final error;
  errorGettingProfileState(this.error);
}