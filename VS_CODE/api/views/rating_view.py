from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from ..orm_models.rating_model import Rating
from ..serializers import RatingSerializer


@api_view(['GET'])
def get_ratings(request):
    rating_id = request.query_params.get('rating_id')
    task_id = request.query_params.get('task_id')
    student_id = request.query_params.get('student_id')

    # Case 1: Get specific rating
    if rating_id:
        try:
            rating = Rating.objects.get(rating_id=rating_id)
            serializer = RatingSerializer(rating)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Rating.DoesNotExist:
            return Response(
                {"error": "Rating not found"},
                status=status.HTTP_404_NOT_FOUND
            )

    # Case 2: Ratings by task
    if task_id:
        ratings = Rating.objects.filter(task_id=task_id)
        serializer = RatingSerializer(ratings, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    # Case 3: Ratings by student
    if student_id:
        ratings = Rating.objects.filter(student_id=student_id)
        serializer = RatingSerializer(ratings, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    # Case 4: All ratings
    ratings = Rating.objects.all()
    serializer = RatingSerializer(ratings, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)
