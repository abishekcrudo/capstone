from ..orm_models.startup_model import Startup

def create_startup_for_user(user, company_name):
    """
    Creates a Startup record for the given User
    """
    print("Creating startup for user:", user.user_id)
    Startup.objects.create(
        startup=user,
        company_name=company_name
    )
