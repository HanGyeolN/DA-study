from django.shortcuts import render, redirect
from .models import Movie
# Create your views here.
def index(request):
    movies = Movie.objects.all()
    context = {
        'movies': movies,
    }
    return render(request, 'recommend/index.html', context)

def new(request):
    return render(request, 'recommend/new.html')

def create(request):
    if request.method == "POST":
        title = request.POST.get("title")
        title_en = request.POST.get("title_en")
        audience = request.POST.get("audience")
        open_date = request.POST.get("open_date")
        genre = request.POST.get("genre")
        watch_grade = request.POST.get("watch_grade")
        score = request.POST.get("score")
        poster_url = request.POST.get("poster_url")
        description = request.POST.get("description") 
        
        movie = Movie.objects.create(title = title,
                                     title_en = title_en,
                                     audience = audience,
                                     open_date = open_date,
                                     genre = genre,
                                     watch_grade = watch_grade,
                                     score = score,
                                     poster_url= poster_url,
                                     description = description)

        
        return redirect('recommend:index')
    
    else:
        return render(request, 'recommend/create.html')

def detail(request, pk):
    movie = Movie.objects.get(pk=pk)
    context = {
        'movie':movie
    }
    return render(request, 'recommend/detail.html', context)

def update(request, pk):
    movie = Movie.objects.get(pk=pk)
    if request.method == "POST":
        title = request.POST.get("title") or movie.title
        title_en = request.POST.get("title_en") or movie.title_en
        audience = request.POST.get("audience") or movie.audience
        open_date = request.POST.get("open_date") 
        genre = request.POST.get("genre")
        watch_grade = request.POST.get("watch_grade")
        score = request.POST.get("score")
        poster_url = request.POST.get("poster_url")
        description = request.POST.get("description") 
        
        movie.title = title
        movie.title_en = title_en
        movie.audience = audience
        movie.open_date = open_date
        movie.genre = genre
        movie.watch_grade = watch_grade
        movie.score = score
        movie.poster_url= poster_url
        movie.description = description

        movie.save()

        return redirect("recommend:detail", movie.pk)
    else:
        context = {'movie': movie}
        return render(request, 'recommend/update.html', context)
    
def delete(request, pk):
    movie = Movie.objects.get(pk=pk)
    if request.method == "POST":
        movie.delete()
        return redirect('recommend:index')
    else:
        return redirect(movie)