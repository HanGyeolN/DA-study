from django.shortcuts import render, redirect
from .models import Question, Answer

# Create your views here.
def index(request):
    return render(request, 'eithers/index.html')

def new(request): 
    pass

def detail(request):
    pass

def answer_create(request):
    pass

def answer_delete(request):
    pass

def random(request):
    pass