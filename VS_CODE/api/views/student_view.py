from ..orm_models.student_model import Student

def create_student_for_user(user):
    Student.objects.create(
        student_id=user,
        resume_path=None,
        rating=0.00,
        verified_status=False
    )
