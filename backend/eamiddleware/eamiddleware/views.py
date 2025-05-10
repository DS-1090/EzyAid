from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import deptCounts, applicantCounts, yearCounts, SchemeDirectory
from .serializers import DeptCountsSerializer, ApplicantCountsSerializer, YearCountsSerializer, SchemeDirectorySerializer
import redis
import json
from django.http import JsonResponse

@api_view(['GET'])
def getSchemes(request):
    scheme = SchemeDirectory.objects.all() 
    serializer = SchemeDirectorySerializer(scheme, many=True)  
    return Response(serializer.data)  

@api_view(['GET'])
def getDeptCounts(request):
    try:
        dept = deptCounts.objects.all() 
        serializer = DeptCountsSerializer(dept, many=True)  
        return Response(serializer.data, status=200)
    except:
        return Response({"error": "An error occurred while fetching department counts :()"}, status=500)

@api_view(['GET'])
def getApplicantCounts(request):
    applicant = applicantCounts.objects.all() 
    serializer = ApplicantCountsSerializer(applicant, many=True)  
    return Response(serializer.data)

@api_view(['GET'])
def getYearCounts(request):
    year = yearCounts.objects.all() 
    serializer = YearCountsSerializer(year, many=True)  
    return Response(serializer.data)

@api_view(['GET'])
def getNotifications(request):
    r =  redis.StrictRedis(host='redis_ezyaid', port=6379, db=0, decode_responses=True)
    keys = r.keys('schemeDirectory:*')  
    notifications = []
    
    for key in keys:
        hash_data = r.hgetall(key)
        
        notification = {
            "id": hash_data.get("id", ""),
            "scheme_name": hash_data.get("scheme_name", ""),
            "open_date": hash_data.get("open_date", ""),
            "state": hash_data.get("state", ""),
            "implementing_agency": hash_data.get("implementing_agency", ""),
            "category": hash_data.get("category", ""),
            "subcategory": hash_data.get("subcategory", ""),
            "tags": hash_data.get("tags", ""),
            "brief_description": hash_data.get("brief_description", ""),
            "detailed_description": hash_data.get("detailed_description", ""),
            "benefits": hash_data.get("benefits", ""),
            "exclusions": hash_data.get("exclusions", ""),
            "eligibility_criteria": hash_data.get("eligibility_criteria", ""),
            "application_process": hash_data.get("application_process", ""),
            "documents_required": hash_data.get("documents_required", "")
        }
        
        notifications.append(notification)
    
    return JsonResponse({"notifications": notifications})
        
    # keys = r.keys('schemeDirectory:*')
    # logs = []
    # redis_client =
    # aqi_data = redis_client.get("Somajiguda, Hyderabad, India")
    
  

    # for key in keys:
    #     raw_data = r.get(key)
    #     if raw_data:
    #         try:
    #             log_entry = json.loads(raw_data)
    #             logs.append({
    #                 "scheme_name": log_entry.get("sc", {}).get("table"),
    #                 "op": log_entry.get("op"),
    #                 "data": log_entry.get("after") or log_entry.get("before")
    #             })
    #         except json.JSONDecodeError:
    #             continue

    # return JsonResponse({"logs": logs})
