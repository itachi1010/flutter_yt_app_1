from django.shortcuts import render

# Create your views here.
from django.http import JsonResponse
from pytube import YouTube, Playlist
import re
import requests
import os
from .models import Video



def ensure_directory_exists(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)

def download(request):
    url = request.GET.get('url')
    is_playlist = request.GET.get('is_playlist', False)
    download_directory = request.GET.get('download_directory')
    quality = request.GET.get('quality', '720p')

    try:
        if is_playlist:
            playlist = Playlist(url)
            playlist_name = re.sub(r'\W+', '-', playlist.title)
            playlist_directory = os.path.join(download_directory, playlist_name)

            ensure_directory_exists(playlist_directory)

            for idx, video_url in enumerate(playlist.video_urls, start=1):
                youtube = YouTube(video_url)
                video_stream = youtube.streams.get_highest_resolution()

                response = requests.get(video_stream.url, stream=True)
                total_size = int(response.headers.get('content-length', 0))

                video_title_cleaned = re.sub(r'\W+', '-', youtube.title)
                video_filename = f"{idx:02d} - {video_title_cleaned}.mp4"
                video_path = os.path.join(playlist_directory, video_filename)

                with open(video_path, 'wb') as f:
                    for chunk in response.iter_content(chunk_size=1024):
                        if chunk:
                            f.write(chunk)
                            # Update the bytes_downloaded field of the Video object
                            video.bytes_downloaded += len(chunk)
                            video.save()
            return JsonResponse({'message': 'Download completed'})

        else:
            youtube = YouTube(url)
            video_stream = youtube.streams.get_highest_resolution()

            response = requests.get(video_stream.url, stream=True)
            total_size = int(response.headers.get('content-length', 0))

            video_title_cleaned = re.sub(r'\W+', '-', youtube.title)
            video_filename = f"{video_title_cleaned}.mp4"
            video_path = os.path.join(download_directory, video_filename)

            with open(video_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=1024):
                    if chunk:
                        f.write(chunk)
                        # Update the bytes_downloaded field of the Video object
                        video.bytes_downloaded += len(chunk)
                        video.save()
            return JsonResponse({'message': 'Download completed'})

    except Exception as e:
        return JsonResponse({'message': f'Error during download: {str(e)}'})

def pause_resume(request):
    url = request.GET.get('url')
    video = Video.objects.get(url=url)
    video.paused = not video.paused
    video.save()
    return JsonResponse({'message': 'Download paused' if video.paused else 'Download resumed'})


def refresh(request):
    all_videos = Video.objects.all()
    for video in all_videos:
        video.delete()
    return JsonResponse({'message': 'Refreshed'})

def get_progress(request):
    url = request.GET.get('url')
    video = Video.objects.get(url=url)
    total_size = video.stream.filesize
    percent = (video.bytes_downloaded / total_size) * 100
    downloaded_mb = video.bytes_downloaded / (1024 * 1024)
    total_mb = total_size / (1024 * 1024)
    remaining_mb = total_mb - downloaded_mb

    response_dict = {
        'progress': percent,
        'downloaded_mb': round(downloaded_mb, 2),
        'total_mb': round(total_mb, 2),
        'remaining_mb': round(remaining_mb, 2)
    }
    return JsonResponse(response_dict)

