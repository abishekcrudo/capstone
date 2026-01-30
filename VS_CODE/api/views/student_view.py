from ..orm_models.student_model import Student

def create_student_for_user(user):
    """
    Creates a Student record for the given User
    """
    Student.objects.create(
        student_id=user,          # OneToOneField to User
        resume_path=None,
        rating=0.00,
        verified_status=False
    )
