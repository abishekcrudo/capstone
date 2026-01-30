from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from ..orm_models.user_model import User
from ..serializers import UserSerializer, UserSignupSerializer
from ..views.student_view import create_student_for_user
from ..views.startup_view import create_startup_for_user

#test endpoint
@api_view(['GET'])
def hello_api(request):
    return Response({
        "message": "Hello, Django API 🚀"
    })

#get user data based on user_id
@api_view(['POST'])
def get_user_by_id(request):
    user_id = request.data.get('user_id')

    if not user_id:
        return Response(
            {"error": "user_id is required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    try:
        user = User.objects.get(user_id=user_id)
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)

    except User.DoesNotExist:
        return Response(
            {"error": "User not found"},
            status=status.HTTP_404_NOT_FOUND
        )

#create user  
@api_view(['POST'])
def signup_user(request):
    user_id = request.data.get('user_id')

    #Check if user_id already exists
    if User.objects.filter(user_id=user_id).exists():
        return Response(
            {"error": "User with this user_id already exists"},
            status=status.HTTP_400_BAD_REQUEST
        )

    #Create user
    serializer = UserSignupSerializer(data=request.data)

    if serializer.is_valid():
        user = serializer.save()
        if request.data.get('role') == "student":
            create_student_for_user(user)
        elif request.data.get('role') == "startup":
            create_startup_for_user(user)
        return Response(
            {"message": "User created successfully"},
            status=status.HTTP_201_CREATED
        )

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

