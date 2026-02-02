from django.db import models

from .startup_model import Startup

class Task(models.Model):
    STATUS_CHOICES = [
        ('open', 'Open'),
        ('assigned', 'Assigned'),
        ('completed', 'Completed'),
    ]
    task_id = models.AutoField(primary_key=True)
    startup_id = models.ForeignKey(
        Startup,
        on_delete=models.CASCADE,
        db_column='startup_id',
        related_name='tasks'
    )
    title = models.CharField(max_length=200)
    description = models.TextField(null=True, blank=True)
    required_skills = models.TextField(null=True, blank=True)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='open'
    )
    is_active = models.CharField(max_length=1, default='Y')

    class Meta:
        db_table = "Tasks"

    def __str__(self):
        return self.title
