import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../styles_images/utils.dart';

Padding settingsPrivacy(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Privacy Policy',
                  style: safeGoogleFont(
                    'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      '''This privacy policy explains how MOOSIC collects, uses, and shares information about you when you use our app and the choices you have associated with that information.

Information We Collect :

We collect information about you when you use our app,including:Information you provide to us: When you sign up for an account, we may collect your name, email address, and other contact information.

Information we collect automatically: 

When you use our app, we may collect information about your device, including your IP address, device type, and operating system. We may also collect information about your usage of the app, such as the pages you visit and the actions you take within the app.
                                
Location information:

We may collect information about your location when you use our app, including through the use of GPS, Bluetooth, and other technologies.                               
                                
Use of Information:

We use the information we collect to provide and improve our app, and for the following purposes:
To provide and personalize our app: We use the information we collect to provide and personalize the app, including to customize the content and recommendations we show you.
To communicate with you: We may use the information we collect to communicate with you, such as to send you updates or notifications about your account or the app.
To analyze and improve our app: We may use the information we collect to understand how people use our app and to identify areas for improvement.
                                
Sharing of Information:

We may share the information we collect as follows:
With service providers: We may share information with third parties that provide services to us, such as hosting and maintenance, analytics, and payment processing.
With legal authorities: We may share information with legal authorities if we are required to do so by law or if we believe it is necessary to protect the rights, property, or safety of our app, users, or others.
                                
Your Choices:

You have the following choices regarding the information we collect and how it is used:
Opting out of location tracking: You can disable location tracking on your device at any time. Please note that some features of our app may not be available if you disable location tracking.
Opting out of email communications: You can opt out of receiving emails from us at any time by following the unsubscribe instructions in the emails we send you.
Deleting your account: You can delete your account at any time by contacting us or using the delete account feature within the app. Please note that some information may remain in our records after you delete your account.
                                
Data Retention:

We will retain the information we collect for as long as your account is active or as needed to provide you with the app. We may also retain and use this information as necessary to comply with legal obligations, resolve disputes, and enforce our agreements.
Changes to This Privacy Policy
We may update this privacy policy from time to time. We will post any updates on this page and encourage you to review the policy periodically. If we make significant changes to the policy, we may also provide additional notice, such as by sending an email or displaying a notice within the app.
                                
Contact Us:

If you have any questions about this privacy policy or the information we collect, please contact us at

harikrishnamanoj2@gmail.com''',
                      textAlign: TextAlign.justify,
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: safeGoogleFont('Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.black),
                  ),
                )
              ],
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Privacy Policy',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding settingsShare(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Share.share(
            '''https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwi1_5Ln_ej-AhUYoZYKHT2rAP4YABAAGgJ0bA&ohost=www.google.com&cid=CAESauD2RmQ8Nid8aJKmuDvL_rg8Zbuh4Iyvp5gsctPJ42KAW5dWpJc-pcPGSGzD9FamhfmDOwdcAWA8306m7szNDGtcGdxSUdCspVbY5PHuU7yKMGZf9gC-OlUt6ixQcZiUBJ1ZEF-EmUOPTSM&sig=AOD64_2Xz1iQK-rMR3h_zzEQ5vi_ePmrgQ&q&adurl&ved=2ahUKEwiBnovn_ej-AhVHtVYBHZufC-cQ0Qx6BAgIEAE''',
            subject: "Github Repo Of This App");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Share App',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding settingsAbout(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'About Us',
                  style: safeGoogleFont(
                    'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '''We are a team of passionate music lovers who have come together to create a better music listening experience for you. Our app is designed to make it easy for you to discover new music, create personalized playlists, and enjoy your favorite tracks anytime, anywhere.

We believe in the power of music to bring people together, and we strive to create a welcoming and inclusive community for music fans of all kinds. We are constantly working to improve the app and add new features to enhance your listening experience.
                
Thank you for choosing Rythm Music App as your go-to music player. We hope you enjoy using it as much as we enjoyed creating it. If you have any feedback or suggestions, we would love to hear from you. Contact us at

harikrishnamanoj2@gmail.com.
                
                ''',
                      textAlign: TextAlign.justify,
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: safeGoogleFont('Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.black),
                  ),
                )
              ],
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'About Us',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding settingsTerms(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Terms and Condition',
                  style: safeGoogleFont(
                    'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '''
Terms and Conditions:

By accessing or using our music player app 'RYTHM', you agree to be bound by these terms and conditions (the "terms"). If you do not agree to these terms, do not use the app.

We reserve the right to change these terms at any time, and you are responsible for reviewing these terms for any updates. Your continued use of the app after any changes have been made constitutes your acceptance of the revised terms.

Use of the App:

The app is intended for personal, non-commercial use. You may not use the app for any illegal or unauthorized purpose. You may not use the app to distribute or download any material that is illegal, copyrighted, or that violates these terms.

We grant you a limited, non-exclusive, non-transferable license to use the app for your personal, non-commercial use. This license does not include the right to sell or distribute the app, or to modify or create derivative works of the app.

Content and Intellectual Property

The app includes content that is owned or licensed by us, including but not limited to text, images, music, and other audio and visual materials. This content is protected by copyright and other intellectual property laws, and you may not use this content except as provided in these terms or with the express written permission of the owner.

The app also includes music and other audio files that are owned or licensed by third parties. We do not claim ownership of these files, and you are responsible for obtaining the necessary permissions to use them.

Accounts and Privacy:

In order to access certain features of the app, you may be required to create an account. You are responsible for maintaining the confidentiality of your account and password, and for all activities that occur under your account.

We respect your privacy and will not share your personal information with third parties, except as required by law or as necessary to provide the app to you. For more information on how we handle your personal information, please see our privacy policy.

Disclaimer of Warranties:

The app is provided on an "as is" and "as available" basis, without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not guarantee that the app will be available at all times or that it will be error-free.

Limitation of Liability:

We will not be liable for any damages arising out of or in connection with your use of the app, including but not limited to direct, indirect, incidental, consequential, or punitive damages. This limitation applies even if we have been advised of the possibility of such damages.

Governing Law:

These terms are governed by the laws of the state of Kerala, and you agree to submit to the exclusive jurisdiction of the courts located in India for any disputes arising out of or in connection with these terms or the app.

Contact Us:

If you have any questions about these terms or the app, please contact us at 

harikrishnamanoj2@gmail.com''',
                      textAlign: TextAlign.justify,
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: safeGoogleFont('Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.black),
                  ),
                )
              ],
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Terms and Condition',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding settingsExit(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Are you sure you want to exit?',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'Exit',
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.red,
                      ),
                    ))
              ],
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Exit',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding settingsHeading(String head) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 80, bottom: 40),
    child: Text(
      head,
      style: safeGoogleFont(
        'Poppins',
        fontSize: 50,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: Colors.white,
      ),
    ),
  );
}

Text bottomVersion() {
  return Text(
    'Version 1.0.0',
    style: safeGoogleFont('Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: Colors.white),
  );
}
