import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan/core/cubit/cubit.dart';
import 'package:scan/core/cubit/states.dart';

class QrCodeScanner extends StatelessWidget {
   QrCodeScanner({super.key, });
   //final void setResult;
  final MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
        listener: (context, state) {},
      builder: (context, state) => MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) async {
        final List<Barcode> barcodes = capture.barcodes;
        final barcode = barcodes.first;

        if (barcode.rawValue != null) {
          MainCubit.get(context).
          setResult(barcode.rawValue);

          await controller
              .stop()
              .then((value) => controller.dispose())
              .then((value) => Navigator.of(context).pop());
        }
      },
          ),
    );
  }
}