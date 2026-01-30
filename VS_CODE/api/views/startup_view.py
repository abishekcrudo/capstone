from ..orm_models.startup_model import Startup

def create_startup_for_user(user):
    """
    Creates a Startup record for the given User
    """
    Startup.objects.create(
        startup=user,           # OneToOneField → Users.user_id
    )
