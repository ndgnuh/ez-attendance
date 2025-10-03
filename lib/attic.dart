class CheckinPage extends StatelessWidget {
  const CheckinPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tool điểm danh"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ChangeNotifierProvider(
        create: (context) => _State(),
        child: ListView(children: [ScanButton(), ImageOutput()]),
      ),
    );
  }
}

class ImageOutput extends StatelessWidget {
  const ImageOutput({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<_State>(context);
    return Text(state.output);
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<_State>(
      builder: (context, state, _) {
        return TextButton(
          onPressed: () async {
            state.startScanning();
          },
          child: Text("Scan"),
        );
      },
    );
  }
}

class _State extends ChangeNotifier {
  final documentOptions = DocumentScannerOptions(
    documentFormat: DocumentFormat.jpeg, // set output document format
    mode: ScannerMode.base, // to control what features are enabled
    pageLimit: 1, // setting a limit to the number of pages scanned
    isGalleryImport: false, // importing from the photo gallery
  );

  String? _output;
  String get output => _output ?? "No result";

  startScanning() async {
    // Scan document
    final documentScanner = DocumentScanner(options: documentOptions);
    DocumentScanningResult result = await documentScanner.scanDocument();
    final pdf = result.pdf; // A PDF object.
    final images = result.images; // A list with the paths to the images.
    documentScanner.close();

    final scannedImage = images.firstOrNull;
    if (scannedImage == null) {
      return;
    }

    // Recognize text
    final inputImage = InputImage.fromFilePath(scannedImage);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );

    await textRecognizer.close();

    // output
    List<String> lines = [];
    for (TextBlock block in recognizedText.blocks) {
      for (final line in block.lines) {
        lines.add(line.text);
      }
    }

    _output = lines.join("\n");
    notifyListeners();
  }
}
