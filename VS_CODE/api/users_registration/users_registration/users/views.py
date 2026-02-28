import json
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
from django.contrib.auth.hashers import make_password

from .models import User
from domain_search.models import TempUniversity  # import the domain table

@csrf_exempt
@require_POST
def signup(request):
    try:
        body = json.loads(request.body.decode("utf-8"))
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)

    email = (body.get("email") or "").strip().lower()
    password = body.get("password") or ""

    if not email or not password:
        return JsonResponse({"error": "email and password are required"}, status=400)

    # --- DOMAIN CHECK ---
    if "@" not in email:
        return JsonResponse({"error": "Invalid email format"}, status=400)

    domain = email.split("@", 1)[1].strip().lower()

    domain_exists = TempUniversity.objects.filter(domain__iexact=domain).exists()
    if not domain_exists:
        return JsonResponse(
            {"error": "Only students with a valid school email domain can register."},
            status=403
        )

    # Prevent duplicate emails
    if User.objects.filter(email=email).exists():
        return JsonResponse({"error": "Email already exists"}, status=409)

    # Create user
    user = User.objects.create(
        email=email,
        password_hash=make_password(password),
        is_active=True,
        is_email_verified=False,
        created_at=timezone.now(),
        updated_at=None,
    )

    return JsonResponse(
        {"message": "User created", "user_id": user.user_id, "email": user.email},
        status=201
    )