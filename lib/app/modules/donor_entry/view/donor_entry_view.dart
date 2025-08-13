import 'package:flutter/material.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:garuda/app/modules/payment_options/binding/payment_options_binding.dart';
import 'package:garuda/app/modules/payment_options/controller/payment_options_controller.dart';
import 'package:garuda/app/modules/payment_options/view/payment_options_view.dart';
import 'package:get/get.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import '../controller/donor_entry_controller.dart';

class DonorEntryView extends GetView<DonorEntryController> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        elevation: 0,
        title: Obx(() => controller.isSearching.value
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.withOpacity(0.7),
                      Colors.orangeAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade100,
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    )
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  autofocus: true,
                  cursorColor: Colors.black87,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Search donor name...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: controller.filterDonors,
                ),
              )
            : const Text(
                "Donor Entry",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              )),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  controller.isSearching.value ? Icons.close : Icons.search,
                  color: Colors.deepOrange,
                )),
            onPressed: controller.toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.deepOrange),
            onPressed: () {
              Get.defaultDialog(
                title: "🙏 Collection Summary",
                titleStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                content: Obx(
                  () => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    color: Colors.orange.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("🚩 Jai Shree Ganesh",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              )),
                          const SizedBox(height: 12),
                          _infoRow(Icons.currency_rupee, "Total Amount",
                              controller.totalAmount.toString(), Colors.green),
                          const SizedBox(height: 12),
                          _infoRow(
                              Icons.check_circle,
                              "Collected",
                              controller.collectedAmount.toString(),
                              Colors.blue),
                          const SizedBox(height: 12),
                          _infoRow(
                              Icons.hourglass_bottom,
                              "Remaining",
                              controller.amountToCollect.toString(),
                              Colors.redAccent),
                        ],
                      ),
                    ),
                  ),
                ),
                radius: 12,
                backgroundColor: Colors.white,
                barrierDismissible: true,
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.orange.shade50,
      body: Obx(() => PageView.builder(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => controller.currentIndex.value = index,
            itemCount: controller.filteredDonorList.isEmpty
                ? 1 // Show only the "No donors found" page
                : controller.filteredDonorList.length, // Show all donors
            itemBuilder: (context, index) {
              if (controller.filteredDonorList.isEmpty) {
                return const Center(
                  child: Text(
                    "No donors found",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }

              // Show donor card
              final donor = controller.filteredDonorList[index];
              return TurnPageTransition(
                animation: const AlwaysStoppedAnimation(1.0),
                overleafColor: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _donorCard(context, index, donor),
                ),
              );
            },
          ),),
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
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("|| గణపతి బప్పా మోరియా ||",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.deepOrange)),
                    const SizedBox(height: 4),
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
                        keyboardType: TextInputType.name,
                        enabled: donor.isEditable),
                    _inputField("Mobile No.", donor.mobileController,
                        keyboardType: TextInputType.number,
                        enabled: donor.isEditable),
                    _inputField("Amount-(₹)", donor.amountController,
                        keyboardType: TextInputType.number,
                        enabled: donor.isEditable),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 👈 Left: Edit & Delete Icons
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.deepOrange),
                                onPressed: () {
                                  controller.enableEditing(
                                      index); // 👈 triggers editable state
                                },
                              ),
                              // IconButton(
                              //   icon:
                              //       const Icon(Icons.delete, color: Colors.red),
                              //   onPressed: () async {
                              //     final donor = controller.donorList[index];

                              //     if (donor.id != null) {
                              //       await controller.deleteDonorFromFirestore(
                              //           donor.id!); // 👍 OK to await here
                              //     }

                              //     controller.donorList.removeAt(index);
                              //     controller.donorList.refresh();

                              //     if (controller.currentIndex.value >=
                              //             controller.donorList.length &&
                              //         controller.donorList.isNotEmpty) {
                              //       controller.currentIndex.value =
                              //           controller.donorList.length - 1;
                              //     }
                              //   },
                              // ),
                            ],
                          ),

                          // 👉 Right side buttons: SAVE + PAY
                          Row(
                            children: [
                              // ✅ SAVE button
                              // ✅ SAVE button with isSaving check
                              Obx(
                                () => GestureDetector(
                                  onTap: controller.isSaving.value
                                      ? null
                                      : () {
                                          donor.name =
                                              donor.nameController.text;
                                          donor.mobile =
                                              donor.mobileController.text;
                                          donor.amount =
                                              donor.amountController.text;
                                          donor.isEditable = false;

                                          controller
                                              .saveDonorToFirestore(donor);
                                          controller.donorList.refresh();

                                          Get.snackbar(
                                            "Success",
                                            "Donor ${donor.name} details saved!",
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor:
                                                Colors.orange.withOpacity(0.9),
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(12),
                                            borderRadius: 10,
                                            duration:
                                                const Duration(seconds: 2),
                                          );
                                        },
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.deepOrange.shade400,
                                          Colors.orange.shade200
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.deepOrange
                                              .withOpacity(0.4),
                                          blurRadius: 8,
                                          offset: const Offset(2, 4),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.deepOrange.shade700,
                                        width: 1.5,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: controller.isSaving.value
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.spa,
                                                  color: Colors.white,
                                                  size: 18), // spa = lotus look
                                              SizedBox(width: 6),
                                              Text(
                                                "save",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),

                              // 💰 PAY button
                              GestureDetector(
                                onTap: () {
                                  if (donor.isPaid) {
                                    Get.snackbar(
                                      "Already Paid",
                                      "${donor.name} has already paid.",
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.green[400],
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(12),
                                      borderRadius: 10,
                                      duration: const Duration(seconds: 2),
                                    );
                                    return; // Stop here, don't open dialog
                                  }
                                  PaymentOptionsBinding().dependencies();
                                  final paymentController =
                                      Get.find<PaymentOptionsController>();
                                  paymentController.donorIndex = index;
                                  Get.dialog(
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      backgroundColor: Colors.orange[50],
                                      title: Column(
                                        children: const [
                                          SizedBox(height: 8),
                                          Text(
                                            "Choose Offering Mode",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.deepOrange,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "Your contribution makes Vinayaka Chavithi divine ✨",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      content: PaymentOptionsView(
                                        donor: donor,
                                      ),
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
                                  width: 90,
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: donor.isPaid
                                        ? Colors.green.shade50
                                        : Colors.orange.shade50,
                                    border: Border.all(
                                      color: donor.isPaid
                                          ? Colors.green
                                          : Colors.deepOrange,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: donor.isPaid
                                            ? Colors.green.withOpacity(0.2)
                                            : Colors.orange.withOpacity(0.2),
                                        blurRadius: 6,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        donor.isPaid
                                            ? Icons.check_circle_rounded
                                            : Icons.volunteer_activism,
                                        color: donor.isPaid
                                            ? Colors.green.shade700
                                            : Colors.deepOrange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        donor.isPaid ? "paid" : "pay",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.0,
                                          color: donor.isPaid
                                              ? Colors.green.shade800
                                              : Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Text(
          "$label: ₹$value",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      required bool enabled}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        enabled: enabled, // 👈 disables when false
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
