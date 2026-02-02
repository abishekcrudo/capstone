from django.db import models
from .user_model import User   # adjust import if User is elsewhere

class Startup(models.Model):
    startup = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        db_column='startup_id'
    )
    company_name = models.CharField(max_length=255, db_column='company_name')

    class Meta:
        db_table = 'Startups'
        managed = False

    
