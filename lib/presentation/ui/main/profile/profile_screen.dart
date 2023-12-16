import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/dialog/error_alert.dart';
import 'package:my_street_merchant/presentation/common_components/progress_indicator_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:provider/provider.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/sharedpref_utils.dart';
import '../../../common_components/dialog/image_picker_dialog.dart';
import '../../../common_components/dialog/prompt_alert.dart';
import '../../../common_components/gradient_background.dart';
import '../../../common_components/notification_icon_widget.dart';
import '../../../common_components/routes.dart';
import '../../../stores/main/home/home_store.dart';
import '../../../stores/main/profile/profile_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  late ProfileStore _store;
  late HomeStore _homeStore;
  bool dialogShowing = false;

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
    _homeStore = Provider.of<HomeStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            _store.clearStatus();
            if (!dialogShowing) {
              dialogShowing = true;
              showErrorAlert(context,
                  actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError, onPressed: () {
                dialogShowing = false;
                Navigator.of(context, rootNavigator: true).pop();
              });
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            NotificationIconWidget(
              profileStore: _store,
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  showPromptAlert(context,
                      positiveMsg: context.strings.yes.toUpperCase(),
                      negativeMsg: context.strings.no.toUpperCase(),
                      title: context.strings.areYouSureToLogOut, onPositivePressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    _store.isLoading = true;
                    SharedPrefs().clearAll();
                    Navigator.of(context, rootNavigator: true).pushReplacementNamed(AppRouter.signInScreen);
                    _store.isLoading = false;
                  }, onNegativePressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  });
                },
                child: Icon(
                  Icons.logout,
                  color: AppColors().lightBlue,
                ),
              ).paddingEnd(20.w),
            ).paddingTop(MediaQuery.of(context).viewPadding.top + 20.h).paddingEnd(35.w),
            Text(
              context.strings.profile,
              style: context.textTheme.displayLarge,
            ).paddingStart(27.w).paddingTop(MediaQuery.of(context).viewPadding.top + 50.h),
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profile")
              ],
            )).paddingTop(MediaQuery.of(context).viewPadding.top + 100.h),
            // Observer(builder: (context) {
            //   return Visibility(
            //     visible: _store.isLoading,
            //     child: const CustomProgressIndicatorWidget(),
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  void showImagePicker() {
    showImagePickerDialog(context, onCameraPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
      String? path = await ImageUtils.pickFromCamera(ratio: CropAspectRatioPreset.square, isCircleCrop: true);
    }, onUploadPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
      String? path =
          await ImageUtils.pickFromGallery(ratio: CropAspectRatioPreset.square, isCircleCrop: true);
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
