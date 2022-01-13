from django.db import models
from django.urls import reverse

# Create your models here.
class Article(models.Model):
    title = models.CharField(max_length=20)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        # ex) '/articles/10/'
        return reverse('articles:detail', args=[str(self.pk)])

class Comment(models.Model):
    content = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    # 변경전 article.comment_set.all()
    # 변경후 article.comments.all()
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name="comments")
    # 게시글이 삭제되면 코멘트도 사라지도록 on_delete 옵션을 넣는다.

    class Meta:
        '''
        역순으로 출력되는걸 방지
        '''
        ordering = ['-pk', ]


    def __str__(self):
        return f'<Article({self.article_id}): Comment({self.pk})--{self.content}'
        # <Article(1): Comment(1)--내용>


