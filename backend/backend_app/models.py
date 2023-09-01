
from django.db import models

class Video(models.Model):
    url = models.URLField(max_length=200)
    is_playlist = models.BooleanField(default=False)
    download_directory = models.CharField(max_length=200)
    bytes_downloaded = models.IntegerField(default=0)
    paused = models.BooleanField(default=False)
    chunk_size = models.IntegerField(default=1024)
    quality = models.CharField(max_length=10)

    def __str__(self):
        return self.url

# Create your models here.
