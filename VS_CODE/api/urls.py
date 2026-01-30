from django.urls import path
from .views.users_view import hello_api, signup_user
from .views.users_view import get_user_by_id

urlpatterns = [
    path('hello/', hello_api),
    path('get-user/', get_user_by_id, name='get-user'),
    path('create-user/', signup_user, name='create-user'),
]
