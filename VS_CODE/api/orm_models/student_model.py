from django.db import models
from api.orm_models.user_model import User

class Student(models.Model):
    student_id = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        db_column='student_id'
    )
    resume_path = models.CharField(max_length=255, null=True, blank=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, default=0.00)
    verified_status = models.BooleanField(default=False)

    class Meta:
        db_table = 'Students'
        managed = False

    def __str__(self):
        return f"Student ID: {self.student_id}"