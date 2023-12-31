# Generated by Django 4.2.3 on 2023-08-31 23:09

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Video',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('url', models.URLField()),
                ('is_playlist', models.BooleanField(default=False)),
                ('download_directory', models.CharField(max_length=200)),
                ('bytes_downloaded', models.IntegerField(default=0)),
                ('paused', models.BooleanField(default=False)),
                ('chunk_size', models.IntegerField(default=1024)),
                ('quality', models.CharField(max_length=10)),
            ],
        ),
    ]
