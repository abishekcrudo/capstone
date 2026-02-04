from django.shortcuts import get_object_or_404, render

from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from api.orm_models.student_model import Student
from api.orm_models.startup_model import Startup
from ..orm_models.user_model import User
from ..serializers import UserSerializer, LoginSerializer
from ..views.student_view import create_student_for_user
from ..views.startup_view import create_startup_for_user

#test endpoint
@api_view(['GET'])
def hello_api(request):
    return Response({
        "message": "Hello, Django API 🚀"
    })

class UserDetailView(APIView):
    def get(self, request, user_id=None):
        user = get_object_or_404(User, user_id=user_id)
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class UserCreateView(APIView):
    def post(self, request):
        user_serializer = UserSerializer(data=request.data)
        if user_serializer.is_valid():
            user = user_serializer.save()
            if user_serializer.validated_data.get('role') == 'student':
                create_student_for_user(user)
            elif user_serializer.validated_data.get('role') == 'startup':
                company_name = request.data.get('company_name', '')
                create_startup_for_user(user, company_name)
            return Response(user_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class UserLoginView(APIView):

    def post(self, request):
        print("Login request data:", request.data)  # Debugging line

        login_serializer = LoginSerializer(data=request.data)

        if not login_serializer.is_valid():
            return Response(login_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        email = login_serializer.validated_data['email']
        password = login_serializer.validated_data['password']

        # Check user
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({"error": "Invalid email or password"}, status=401)

        # ⚠️ Plain password check (use hashing in production)
        if user.password != password:
            return Response({"error": "Invalid email or password"}, status=401)

        # Serialize user data
        user_data = UserSerializer(user).data
        print("Authenticated user data:", user_data)  # Debugging line
        # Add role-based details
        role_data = {}

        if user.role == 'student':
            student = Student.objects.get(student_id_id=user)
            role_data["student_details"] = {
                "resume_path": student.resume_path,
                "rating": student.rating,
                "verified_status": student.verified_status
            }

        elif user.role == 'startup':
            print("Inside startup role")  # Debugging line
            startupObj = Startup.objects.get(startup=user)
            role_data["startup_details"] = {
                "company_name": startupObj.company_name
            }

        # Final response
        response_data = {
            "user": user_data,
            **role_data
        }

        return Response(response_data, status=status.HTTP_200_OK)

