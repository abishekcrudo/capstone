from django.urls import path
from . import views

urlpatterns = [
    path("fetch-universities", views.fetch_and_store_universities),
    path("universities-by-domain", views.universities_by_domain),
]