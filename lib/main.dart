import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:file_picker/file_picker.dart';


void main() {
  runApp(const YoutubeDownloaderApp());
}

class YoutubeDownloaderApp extends StatelessWidget {
  const YoutubeDownloaderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Downloader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const YoutubeDownloaderScreen(),
    );
  }
}

class YoutubeDownloaderScreen extends StatefulWidget {
  const YoutubeDownloaderScreen({Key? key}) : super(key: key);

  @override
  _YoutubeDownloaderScreenState createState() => _YoutubeDownloaderScreenState();
}

class _YoutubeDownloaderScreenState extends State<YoutubeDownloaderScreen> {
  TextEditingController linkController = TextEditingController();
  TextEditingController directoryController = TextEditingController();
  bool isPlaylist = false;
  String downloadDirectory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Downloader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter the URL:'),
            TextField(
              controller: linkController,
            ),
            CheckboxListTile(
              title: const Text('Download Playlist'),
              value: isPlaylist,
              onChanged: (value) {
                setState(() {
                  isPlaylist = value ?? false;
                });
              },
            ),
            const Text('Select the download directory:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: directoryController,
                    enabled: false,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _openFolderPicker();
                  },
                  icon: const Icon(Icons.folder_open),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Call the download function
                download();
              },
              child: const Text('Download'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call the refresh function
                refresh();
              },
              child: const Text('Refresh'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call the pause/resume function
                pauseResume();
              },
              child: const Text('Pause/Resume'),
            ),
            const LinearProgressIndicator(
              value: 0.5, // Replace with the actual progress value
            ),
            const Text('Select video quality:'),
            DropdownButton<String>(
              value: '720p',
              onChanged: (String? newValue) {
                setState(() {
                  // Assign the selected quality to a variable or perform any required logic here
                });
              },
              items: <String>['144p', '240p', '360p', '480p', '720p', '1080p']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Text('Error messages will be displayed here'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void download() async {
    String url = linkController.text;

    String apiUrl = 'http://127.0.0.1:8000/';  // Replace with your backend server URL

    // Send a POST request to the backend API
    await http.post(Uri.parse(apiUrl), body: {
      'url': url,
      'isPlaylist': isPlaylist.toString(),
      'downloadDirectory': downloadDirectory,
    });
  }

  void refresh() {
    // Implement the refresh logic
  }

  void pauseResume() {
    // Implement the pause/resume logic
  }

  Future<void> _openFolderPicker() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath();

    if (folderPath != null) {
      Directory folder = Directory(folderPath);
      setState(() {
        downloadDirectory = folder.path;
        directoryController.text = downloadDirectory;
      });
    }
  }
}
