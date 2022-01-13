from django.db import models

def questions_image_path(instance, filename):    
    return 'questions/'

# Create your models here.
class Question(models.Model):
    title = models.CharField(max_length=50)
    issue_a = models.CharField(max_length=50)
    issue_b = models.CharField(max_length=50)
    image_a = models.ImageField(blank=True, upload_to=questions_image_path)
    image_b = models.ImageField(blank=True, upload_to=questions_image_path)

    def __str__(self):
        return f'{self.title} \n {self.issue_a}, {self.issue_b}'

class Answer(models.Model):
    question_id = models.IntegerField()
    pick = models.IntegerField()
    comment = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.question_id} \n {self.pick}, {self.comment}'
