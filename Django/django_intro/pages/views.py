from django.shortcuts import render
import math
import random
from datetime import datetime

# Create your views here.
def index(request):
    return render(request, 'pages/index.html')

def introduce(request, name, age):
    context = {
        'name':name,
        'age':age
    }
    return render(request, 'pages/introduce.html', context)

def dinner(request):
    menu = ['짜장면', '햄버거' , '치킨', '초밥', '김밥']
    pick = random.choice(menu)
    context = {'pick':pick}
    return render(request, 'pages/dinner.html', context)

def image(request):
    return render(request, 'pages/image.html')

def hello(request, name):
    menu = ['짜장면', '햄버거' , '치킨', '초밥', '김밥']
    pick = random.choice(menu)
    context = {
        'name':name, 
        'pick':pick
        }
    return render(request, 'pages/hello.html', context)

def times(request, n1, n2):
    result = n1*n2
    context = {
        'result':result
    }
    return render(request, 'pages/times.html', context) 

def circle(request, r):
    result = math.pi*r*r
    context = {
        'result':result
    }
    return render(request, 'pages/circle.html', context)

# DTL
# html문서에 변수를 사용하는법
def template_language(request):
    menus = ['a', 'b', 'c', 'd']
    my_sentence = 'Life is short, you need python.'
    messages = ['apple', 'banana', 'cucumber', 'durian']
    datetimenow = datetime.now()
    empty_list = []
    context = {
        'menus': menus,
        'my_sentence': my_sentence,
        'messages': messages,
        'datetimenow': datetimenow,
        'empty_list': empty_list
    }
    return render(request, 'pages/template_language.html', context)

def isbirth(request):
    month = datetime.now().month
    day = datetime.now().day
    my_month = 10
    my_day = 24
    res = ""
    if month == my_month and day == my_day:
        res = "예"
    else:
        res = "아니오"

    context= {
        'res':res
    }
    return render(request, 'pages/isbirth.html', context)

def ispal(request, text):
    text_len = len(text)
    res = ""

    for i, char in enumerate(text):
        if i > text_len/2:
            break

        if char == text[-i-1]:
            res = "예"          
            continue

        else:
            res = "아니오"
            break
    

    # if text_len%2 == 0:
    #     if text[:text_len/2] == text[-1:-(text_len/2)-1:-1]:
    #         res = "예"
    #     else:
    #         res = "아니오"
    # else:
    #     if text[:int((text_len-1)/2)] == text[-1:int(-(text_len+1)/2):-1]:
    #         res = "예"
    #     else:
    #         res = "아니오"
    
    context = {
        'res':res
    }
    return render(request, 'pages/ispal.html', context)

