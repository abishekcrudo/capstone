from django.urls import path

from api.views.applications_view import ApplicationDetailView, ApplicationListView
from api.views.rating_view import get_ratings
from .views.users_view import UserDetailView, hello_api, UserCreateView
from .views.tasks_view import get_tasks, create_task, delete_task

urlpatterns = [
    path('hello/', hello_api),
    path('users/<int:user_id>/', UserDetailView.as_view(), name='user-detail'),
    path('users/', UserCreateView.as_view(), name='user-create'),
    path('tasks/', get_tasks, name='get-tasks'),
    path('ratings/', get_ratings, name='get-ratings'),
    path('tasks/create/', create_task, name='create-task'),
    path('tasks/delete/', delete_task, name='delete-task'),
    path('applications/', ApplicationListView.as_view(), name='application-list'),
    path('applications/<int:application_id>/', ApplicationDetailView.as_view(), name='application-detail'),
]
