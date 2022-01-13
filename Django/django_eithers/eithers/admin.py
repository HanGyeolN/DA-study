from django.contrib import admin
from .models import Question, Answer

class QuestionAdmin(admin.ModelAdmin):
    list_display = ('title', 'issue_a', 'issue_b', 'image_a', 'image_b')

class AnswerAdmin(admin.ModelAdmin):
    list_display = ('question_id', 'pick', 'comment')

# Register your models here.
admin.site.register(Question, QuestionAdmin)
admin.site.register(Answer, AnswerAdmin)
