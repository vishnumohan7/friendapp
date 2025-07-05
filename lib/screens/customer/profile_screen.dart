import 'package:feme/core/textstyles.dart';
import 'package:feme/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> aiPhotos = [
    'assets/images/ai1.jpg',
    'assets/images/ai2.jpg',
    'assets/images/ai3.jpg',
    'assets/images/ai4.jpg',
    'assets/images/ai5.jpg',
    'assets/images/ai6.jpg',
    'assets/images/ai7.jpg',
    'assets/images/ai8.jpg',
    'assets/images/ai9.jpg',
  ]; // Replace with your actual image paths

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black54),
          title: Text('Profile Photo', style: AppTextStyles.heading3),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Color(0xff2563EB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 4),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/current.jpg',
                        ), // your image
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff2563EB),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Current photo'),
                ],
              ),

              const SizedBox(height: 24),

              // AI Generated Photos Title
              Row(
                children: [
                  const Text(
                    'AI Generated Photos',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    '+ Generate More',
                    style: TextStyle(
                      color: Color(0xff7C3AED),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // AI Photo Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: aiPhotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(aiPhotos[index], fit: BoxFit.cover),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Upload Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffD1D5DB)),
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF9FAFB),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      size: 32,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Upload your own photo',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'JPG, PNG up to 10MB',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Upload functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE5E7EB),
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Choose File'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Photo Tips
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffE0ECFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline, color: Color(0xff2563EB)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Choose a clear, well-lit photo where your face is clearly visible. Avoid sunglasses or hats.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
