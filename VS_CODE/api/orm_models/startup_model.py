from django.db import models
from .user_model import User   # adjust import if User is elsewhere

class Startup(models.Model):
    startup = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        db_column='startup_id'
    )

    class Meta:
        db_table = 'Startups'
        managed = False   # 👈 existing SQL Server table

    
