from django.db import models

from ..orm_models.tasks_model import Task
from ..orm_models.student_model import Student


class Rating(models.Model):
    rating_id = models.AutoField(primary_key=True)

    task = models.ForeignKey(
        Task,
        on_delete=models.CASCADE,
        db_column='task_id',
        related_name='ratings'
    )

    student = models.ForeignKey(
        Student,
        on_delete=models.PROTECT, 
        db_column='student_id',
        related_name='ratings'
    )

    score = models.IntegerField()
    feedback = models.TextField(null=True, blank=True)

    class Meta:
        db_table = "Ratings"
        unique_together = ('task', 'student')

    def __str__(self):
        return f"Rating {self.score} - Task {self.task_id} - Student {self.student_id}"
