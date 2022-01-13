from django.db import models
from datetime import datetime

def articles_image_path(instance, filename):
    now = datetime.now()
    return f'articles/{now.year}/{now.month}/{now.day}'

# Create your models here.
class Article(models.Model):
    title = models.CharField(max_length=50)
    content = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    # blank = True // 굳이 받지 않아도 된다.
    image = models.ImageField(blank=True, upload_to=articles_image_path)
