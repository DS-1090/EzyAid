from django.db import models

class deptCounts(models.Model):
    Department = models.CharField(max_length=100,  primary_key=True)
    count = models.IntegerField()

    def __str__(self):
        return self.name
    class Meta:
        db_table = 'deptCounts'  


class applicantCounts(models.Model):
    Category = models.CharField(max_length=100,  primary_key=True)
    count = models.IntegerField()

    def __str__(self):
        return self.name
    
    class Meta:
        db_table = 'applicantCounts'  
    


class yearCounts(models.Model):
    Year = models.CharField(max_length=100,  primary_key=True)
    count = models.IntegerField()

    def __str__(self):
        return self.name
    class Meta:
        db_table = 'yearCounts'  
    


class SchemeDirectory(models.Model):
    id = models.AutoField(primary_key=True)
    scheme_name = models.TextField()
    open_date = models.TextField(null=True, blank=True)
    state = models.TextField(null=True, blank=True)
    implementing_agency = models.TextField(null=True, blank=True)
    category = models.TextField(null=True, blank=True)
    subcategory = models.TextField(null=True, blank=True)
    tags = models.TextField(null=True, blank=True)
    brief_description = models.TextField(null=True, blank=True)
    detailed_description = models.TextField(null=True, blank=True)
    benefits = models.TextField(null=True, blank=True)
    exclusions = models.TextField(null=True, blank=True)
    eligibility_criteria = models.TextField(null=True, blank=True)
    application_process = models.TextField(null=True, blank=True)
    documents_required = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.scheme_name
    class Meta:
        db_table = 'schemeDirectory'  
