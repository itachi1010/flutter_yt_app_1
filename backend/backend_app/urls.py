from django.urls import path
from .import views

urlpatterns = [
    path('download/', views.download, name='download'),
    path('pause_resume/', views.pause_resume, name='pause_resume'),
    path('refresh/', views.refresh, name='refresh'),
    path('progress/', views.get_progress, name='progress'),
]

