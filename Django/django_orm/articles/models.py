from django.db import models

# Create your models here.
class Article(models.Model):
    '''
    제목, 내용, 생성된 날짜 ,수정된 날짜
    '''
    title = models.CharField(max_length=50)
    # CahrField = 길이 제한이 있는 문자열
    content = models.TextField()
    # TextField = 길이 제한이 없는 문자열
    created_at = models.DateTimeField(auto_now_add=True)
    # 생성된 시간에 자동 생성
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.id}번글- {self.title} : {self.content}'