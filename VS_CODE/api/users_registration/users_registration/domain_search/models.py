from django.db import models

class TempUniversity(models.Model):
    temp_id = models.AutoField(primary_key=True)
    country = models.CharField(max_length=100)
    university_name = models.CharField(max_length=255)
    domain = models.CharField(max_length=255, null=True, blank=True)
    web_page = models.CharField(max_length=500, null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "temp_universities"
        managed = False  # IMPORTANT: Django will not create/alter this table