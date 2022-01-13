from django.urls import path
from . import views

app_name = 'articles'

urlpatterns = [
    # 기존 url
    # path('', views.index, name="index"),
    # path('new/', views.new, name="new"),
    # path('create/', views.create, name="create"),
    # path('<int:pk>/', views.detail, name="detail"), # ex) /articles/1/
    # path('<int:pk>/delete/', views.delete, name="delete"),
    # path('<int:pk>/edit/', views.edit, name="edit"),
    # path('<int:pk>/update/', views.update, name="update"),

    # 변경 후 url
    path('', views.index, name="index"),
    path('create/', views.create, name="create"),
    path('<int:pk>/', views.detail, name="detail"),
    path('<int:pk>/delete/', views.delete, name="delete"),
    path('<int:pk>/update/', views.update, name="update"),
    path('<int:pk>/comment_create/', views.comment_create, name="comment_create"),
    path('<int:article_pk>/comments/<int:comment_pk>/delete', views.comments_delete, name="comments_delete"),

]