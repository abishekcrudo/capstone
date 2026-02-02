from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from ..orm_models.tasks_model import Task
from ..serializers import TaskSerializer


@api_view(['GET'])
def get_tasks(request):
    task_id = request.query_params.get('task_id')
    startup_id = request.query_params.get('startup_id')

    # Case 1: task_id provided → return single task
    if task_id:
        try:
            task = Task.objects.get(task_id=task_id)
            serializer = TaskSerializer(task)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Task.DoesNotExist:
            return Response(
                {"error": "Task not found, No task with the provided task_id exists."},
                status=status.HTTP_404_NOT_FOUND
            )

    # Case 2: startup_id provided → return tasks for startup
    if startup_id:
        tasks = Task.objects.filter(startup_id=startup_id)
        serializer = TaskSerializer(tasks, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    # Case 3: no params → return all tasks
    tasks = Task.objects.all()
    serializer = TaskSerializer(tasks, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def create_task(request):
    serializer = TaskSerializer(data=request.data)

    if serializer.is_valid():
        task = serializer.save()
        return Response(
            {
                "message": "Task created successfully",
                "task_id": task.task_id
            },
            status=status.HTTP_201_CREATED
        )

    return Response(
        serializer.errors,
        status=status.HTTP_400_BAD_REQUEST
    )

@api_view(['POST'])
def delete_task(request):
    task_id = request.data.get('task_id')
    startup_id = request.data.get('startup_id')
    action = request.data.get('action')

    if not task_id or not startup_id or not action:
        return Response(
            {"error": "task_id, startup_id, and action are required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    try:
        task = Task.objects.get(task_id=task_id)
    except Task.DoesNotExist:
        return Response(
            {"error": "Task not found"},
            status=status.HTTP_404_NOT_FOUND
        )

    if task.startup_id_id != int(startup_id):
        return Response(
            {"error": "You are not authorized to perform this action"},
            status=status.HTTP_403_FORBIDDEN
        )

    if action == "soft_delete":
        if task.is_active == 'N':
            return Response(
                {"message": "Task already soft deleted"},
                status=status.HTTP_200_OK
            )

        task.is_active = 'N'
        task.save()
        return Response(
            {"message": "Task soft deleted successfully"},
            status=status.HTTP_200_OK
        )

    elif action == "retrieve":
        if task.is_active == 'Y':
            return Response(
                {"message": "Task is already active"},
                status=status.HTTP_200_OK
            )

        task.is_active = 'Y'
        task.save()
        return Response(
            {"message": "Task restored successfully"},
            status=status.HTTP_200_OK
        )

    elif action == "hard_delete":
        task.delete()
        return Response(
            {"message": "Task permanently deleted"},
            status=status.HTTP_200_OK
        )

    else:
        return Response(
            {"error": "Invalid action. Use soft_delete, hard_delete, or retrieve"},
            status=status.HTTP_400_BAD_REQUEST
        )