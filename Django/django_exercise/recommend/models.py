from django.db import models
from django.urls import reverse

# Create your models here.
class Movie(models.Model):
    # 영화명
    title = models.CharField(max_length=200)
    # 영화명(영문)
    title_en = models.CharField(max_length=200)
    # 누적관객수
    audience = models.IntegerField()
    # 개봉일
    open_date = models.DateTimeField()
    # 장르
    genre = models.CharField(max_length=100)
    # 관람등급
    watch_grade = models.CharField(max_length=100)
    # 평점
    score = models.FloatField()
    # 포스터 이미지 URL
    poster_url = models.TextField()
    # 영화 소개
    description = models.TextField()

    def __str__(self):
        return self.title
    
    def get_absolute_url(self):
        return reverse('recommend:detail', args=[str(self.pk)])
