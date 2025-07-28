import 'package:flutter/material.dart';
import 'package:garuda/app/modules/payment_options/binding/payment_options_binding.dart';
import 'package:garuda/app/modules/payment_options/view/payment_options_view.dart';
import 'package:get/get.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import '../controller/donor_entry_controller.dart';

class DonorEntryView extends GetView<DonorEntryController> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Obx(() => PageView.builder(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => controller.currentIndex.value = index,
            itemCount: controller.donorList.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.donorList.length) {
                // Add Page
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    onPressed: () {
                      controller.addNewDonor();
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              final donor = controller.donorList[index];
              return TurnPageTransition(
                animation: const AlwaysStoppedAnimation(1.0),
                overleafColor: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _donorCard(context, index, donor),
                ),
              );
            },
          )),
    );
  }

  Widget _donorCard(BuildContext context, int index, DonorModel donor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Transparent background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/gani.png',
                width: 400,
                height: 400,
                //            fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.1), // soft transparency
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            // Foreground content
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("|| గణపతి బప్పా మోరియా ||",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepOrange)),
                  const SizedBox(height: 6),
                  const Text("GARUDA - youth association",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepOrange)),
                  const Text("Chakriyal, Sangareddy Dist.",
                      style: TextStyle(fontSize: 14)),
                  const Divider(
                      thickness: 1.5, color: Colors.deepOrange, height: 20),
                  const Text("DONATION RECEIPT",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Receipt No: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            TextSpan(
                              text: donor.receiptNo,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Date: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            TextSpan(
                              text: donor.date,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _inputField("Mr./Mrs.", donor.nameController,
                      keyboardType: TextInputType.name),
                  _inputField("Mobile No.", donor.mobileController,
                      keyboardType: TextInputType.number),
                  _inputField("Amount-(₹)", donor.amountController,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      PaymentOptionsBinding().dependencies();
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: Colors.orange[50],
                          title: Column(
                            children: [
                              // const Icon(Icons.volunteer_activism,
                              //     size: 36, color: Colors.deepOrange),
                              const SizedBox(height: 8),
                              const Text(
                                "Choose Offering Mode",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.deepOrange,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Your contribution makes Vinayaka Chavithi divine ✨",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          content:
                              PaymentOptionsView(), // 👇 custom content below

                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange.shade50,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "pay",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: Colors.deepOrange,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepOrange),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
          ),
        ),
      ),
    );
  }
}
