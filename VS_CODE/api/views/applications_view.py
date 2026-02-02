# views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from ..orm_models.application_model import Application
from ..serializers import ApplicationSerializer
from django.shortcuts import get_object_or_404

class ApplicationListView(APIView):
    def get(self, request):
        task_id = request.query_params.get('task_id', None)  # None if not provided
       
        if task_id:
            # Filter by task_id if query param exists
            applications = Application.objects.filter(task_id=task_id)
            serializer = ApplicationSerializer(applications, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        
        applications = Application.objects.all()
        serializer = ApplicationSerializer(applications, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class ApplicationDetailView(APIView):
    def get(self, request, application_id=None):
        application = get_object_or_404(Application, application_id=application_id)
        serializer = ApplicationSerializer(application)
        return Response(serializer.data, status=status.HTTP_200_OK)
