from django.contrib import admin
from .models import Article

# Register your models here.
# admin 사이트에서 보기위해 등록을 해준다.
class ArticleAdmin(admin.ModelAdmin):
    list_display = ('pk', 'title', 'content', 'created_at', 'updated_at')
    list_filter = ('created_at', )
    

admin.site.register(Article, ArticleAdmin)