from flask import Flask, request, jsonify

# Your existing import statements
import re
import threading
import os
import tkinter as tk
from tkinter import ttk
from tkinter import filedialog
import pytube
import requests


app = Flask(__name__)
@app.route('/download', methods=['POST'])
def download():
    # Retrieve the URL and isPlaylist parameters from the request
    url = request.json['url']
    is_playlist = request.json['isPlaylist']
    
    # Create an instance of DownloadManager and call the download method
    download_manager = DownloadManager(progress_bar=None, quality_var=None, error_text_widget=None)
    download_manager.start_download(url, download_directory=None, is_playlist=is_playlist)
    
    return jsonify({'message': 'Download initiated'})

if __name__ == '__main__':
    app.run()

