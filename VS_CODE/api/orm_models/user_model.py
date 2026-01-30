from django.db import models

class User(models.Model):
    ROLE_CHOICES = [
        ('student', 'Student'),
        ('startup', 'Startup'),
        ('admin', 'Admin'),
    ]

    user_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    email = models.EmailField(max_length=150, unique=True)
    password = models.CharField(max_length=255)
    role = models.CharField(
        max_length=20,
        choices=ROLE_CHOICES
    )
    class Meta:
        db_table = 'Users'
        managed = False

    def __str__(self):
        return f"{self.name} ({self.role})"

