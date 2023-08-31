   import 'package:flutter/material.dart';

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
           primarySwatch: Colors.blue,
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
                )
              ,
               const Text('Select the download directory:'),
               TextField(
                 controller: directoryController,
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

     void download() {
       // Implement the download logic
     }

     void refresh() {
       // Implement the refresh logic
     }

     void pauseResume() {
       // Implement the pause/resume logic
     }
   }