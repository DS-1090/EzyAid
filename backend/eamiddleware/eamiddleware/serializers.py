from rest_framework import serializers
from .models import deptCounts, applicantCounts, yearCounts, SchemeDirectory

class DeptCountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = deptCounts
        fields = ['Department', 'count']


class ApplicantCountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = applicantCounts
        fields = ['Category', 'count']


class YearCountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = yearCounts
        fields = ['Year', 'count']


class SchemeDirectorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SchemeDirectory
        fields = '__all__'  
