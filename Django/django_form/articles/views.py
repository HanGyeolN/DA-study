from django.shortcuts import render, redirect, get_object_or_404
from .models import Article, Comment
from .forms import ArticleForm, CommentForm
from django.views.decorators.http import require_POST
# Create your views here.
def index(request):
    articles = Article.objects.all()
    context = {'articles':articles}
    return render(request, 'articles/index.html', context)

def create(request):
    if request.method == "POST":
        # 폼 인스턴스를 생성하고 요청에 의한 데이터로 채운다 (바인딩)
        form = ArticleForm(request.POST)

        # 유효성 검사 is_valid() : True or False 유효한 form인지 확인
        if form.is_valid():
            title = form.cleaned_data.get("title")
            content = form.cleaned_data.get("content")
            article = Article(title = title, content=content)
            article.save()

        # title = request.POST.get("title")
        # content = request.POST.get("content")
        # article = Article(title=title, content=content)
        # article.save()
            return redirect("articles:index")
    else:
        form = ArticleForm()
        context = {'form': form}
        
    return render(request, 'articles/create.html', context)

def detail(request, article_pk):
    # article = Article.objects.get(pk=article_pk)
    article = get_object_or_404(Article, pk=article_pk)

    # get_object_or_404()와 똑같은 역할
    # try:
    #     article = Article.objects.get(pk=article_pk)
    # except Article.DoesNotExist:
    #     # from django.http import Http404
    #     raise Http404("No article matches the given query.")

    context = {
        # article을 통해 comment를 참조하는것을 추천한다. 
        'article':article,

        # 아래 부분은 detail.html에서 comments를 사용하는 경우
        # 'comment_form':comment_form,
        # 'comments':comments
    }
    return render(request, 'articles/detail.html', context)

# 이 데코레이터는 POST만 받고 아니면 405 
@require_POST 
def delete(request, article_pk):
    article = get_object_or_404(Article, pk=article_pk)
    article.delete()
    return redirect("articles:index")

@require_POST
def comments_create(request, article_pk):
    article = get_object_or_404(Article, pk=article_pk)
    comment_form = CommentForm(request.POST)
    if comment_form.is_valid():
        comment=comment_form.save(commit=False)
        comment.article = article
        comment.save()
        return redirect("articles:detial", article_pk)

@require_POST
def comments_delete(request, article_pk, comment_pk):
    comment = get_object_or_404(Comment, pk=comment_pk)
    comment.delete()
    # 지우고 나서 다시 해당 article로 돌려보내기 위해서 article_pk가 필요했던것
    return redirect("articles:detail", article_pk)
