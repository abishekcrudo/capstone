from django.shortcuts import render
import requests
from django.http import JsonResponse
from django.views.decorators.http import require_GET
from .models import TempUniversity

HIPOLABS_URL = "http://universities.hipolabs.com/search"

@require_GET
def fetch_and_store_universities(request):
    """
    GET /api/fetch-universities?country=Canada
    Pulls from Hipolabs and stores results in TempUniversity table.
    """
    country = request.GET.get("country")
    if not country:
        return JsonResponse({"error": "country is required"}, status=400)

    # External API call
    resp = requests.get(HIPOLABS_URL, params={"country": country}, timeout=15)
    resp.raise_for_status()
    data = resp.json()  # list of dicts

    # Clear old rows for this country to avoid duplicates
    TempUniversity.objects.filter(country=country).delete()

    to_create = []
    for item in data:
        uni_name = item.get("name")
        domains = item.get("domains") or []
        web_pages = item.get("web_pages") or []
        web_page = web_pages[0] if web_pages else None

        if not uni_name:
            continue

        # Store one row per domain (or one row with NULL if no domains)
        if not domains:
            to_create.append(
                TempUniversity(country=country, university_name=uni_name, domain=None, web_page=web_page)
            )
        else:
            for d in domains:
                to_create.append(
                    TempUniversity(country=country, university_name=uni_name, domain=d, web_page=web_page)
                )

    TempUniversity.objects.bulk_create(to_create)

    return JsonResponse({
        "country": country,
        "inserted_rows": len(to_create),
    })

@require_GET
def universities_by_domain(request):
    """
    GET /api/universities-by-domain?domain=utoronto.ca
    Returns rows from TempUniversity filtered by domain.
    """
    domain = request.GET.get("domain")
    if not domain:
        return JsonResponse({"error": "domain is required"}, status=400)

    qs = TempUniversity.objects.filter(domain=domain).values(
        "country", "university_name", "domain", "web_page", "created_at"
    ).order_by("university_name")

    return JsonResponse(list(qs), safe=False)