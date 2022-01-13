from django.shortcuts import render, redirect
from .models import Article, Comment

# Create your views here.
def index(request):

    print(request)
    print(request.path)
    print(request.method)
    print(request.headers)
    print(request.GET)
    print(request.POST)

    articles = Article.objects.all()
    context = {
        'articles': articles,
    }
    return render(request, 'articles/index.html', context)

# def new(request):
#     return render(request, 'articles/new.html')

def create(request):
    if request.method == "POST":
        title = request.POST.get("title")
        content = request.POST.get("content")
        article = Article.objects.create(title=title, content=content)
        return redirect('articles:detail', article.pk)
    else:
        return render(request, 'articles/new.html') 

def detail(request, pk):
    '''
    article의 모든 댓글 가져오기
    '''

    article = Article.objects.get(pk=pk)
    comments = article.comments.all()
    context = {'article': article,
               'comments':comments,
               }
    return render(request, 'articles/detail.html', context)

def delete(request, pk):
    article = Article.objects.get(pk=pk)
    if request.method == "POST":
        article.delete()
        return redirect('articles:index')
    else:
        return redirect(article)

# def edit(request, pk):
#     article = Article.objects.get(pk=pk)
#     context = {'article': article}
#     return render(request, 'articles/edit.html', context)

def update(request, pk):
    article = Article.objects.get(pk=pk)
    # update
    if request.method == "POST":
        title = request.POST.get("title")
        content = request.POST.get("content")
        article.title = title
        article.content = content
        article.save()
        return redirect("articles:detail", article.pk)
    # edit
    else:
        context = {'article': article}
        return render(request, 'articles/update.html', context)

def comment_create(request, pk):    
    article = Article.objects.get(pk=pk)

    if request.method == "POST":
        # form에서 넘어온 댓글 정보
        content = request.POST.get("content")
        
        # 댓글 생성 -> 저장 -> 리턴
        comment = Comment()
        comment.content = content
        comment.article = article
        comment.save()

        return redirect(article)
    else:
        # return redirect("articles:detail", article.pk)
        
        # get_absolute_url 함수 이용
        return redirect(article)
    
def comments_delete(request, article_pk, comment_pk):
    if request.method == "POST":
        comment = Comment.objects.get(pk=comment_pk)
        comment.delete()
        return redirect('articles:detail', article_pk)
    else:
        return redirect('articles:detail', article_pk)