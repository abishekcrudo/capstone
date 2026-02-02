from django.db import models
from ..orm_models.tasks_model import Task
from .student_model import Student
from .tasks_model import Task

class Application(models.Model):
    STATUS_CHOICES = [
        ('applied', 'Applied'),
        ('shortlisted', 'Shortlisted'),
        ('selected', 'Selected'),
        ('rejected', 'Rejected'),
    ]

    application_id = models.AutoField(primary_key=True)
    task = models.ForeignKey(
        Task,
        on_delete=models.CASCADE,
        related_name='applications'
    )
    student = models.ForeignKey(
        Student,
        on_delete=models.PROTECT,  # maps to NO ACTION
        related_name='applications'
    )
    match_score = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='applied'
    )

    class Meta:
        db_table = "Applications"
        unique_together = ('task', 'student')  # A student can apply only once per task

    def __str__(self):
        return f"Application {self.application_id} - Task {self.task_id} - Student {self.student_id}"
