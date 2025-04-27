
from pyspark.sql import SparkSession
import pandas as pd
from pyspark.sql.functions import col,year
import pyspark as ps
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DateType


def fetchRecords():    

    spark = SparkSession.builder.appName("SparkToMySQL").config("spark.jars", "/opt/bitnami/spark/jars/mysql-connector-j-8.0.33.jar").getOrCreate()
    #spark = SparkSession.builder.appName("ProcessSchemes").getOrCreate() 

    df =  pd.read_excel('allschemes.xlsx')  
    df.drop(columns=["FAQs"], inplace=True)
    df = df.fillna("0")
    df['open_date'] = df['open_date'].astype(str) 

    print("Pandas Columns:", df.columns)

    schema = StructType([
        StructField("id", IntegerType(), False),
        StructField("scheme_name", StringType(), True),
        StructField("open_date", StringType(), True), 
        StructField("state", StringType(), True),
        StructField("implementing_agency", StringType(), True),
        StructField("category", StringType(), True),
        StructField("subcategory", StringType(), True),
        StructField("tags", StringType(), True),
        StructField("brief_description", StringType(), True),
        StructField("detailed_description", StringType(), True),
        StructField("benefits", StringType(), True),
        StructField("exclusions", StringType(), True),
        StructField("eligibility_criteria", StringType(), True),
        StructField("application_process", StringType(), True),
        StructField("documents_required", StringType(), True)
    ])

    df = spark.createDataFrame(df, schema=schema)
    #    df.show(1)

    #Applicant wise filtering
    #df.select("Tags").show()
    applicantWiseCounts = {
        "Woman": df.filter(col("tags").contains("Woman")).count(),
        "Child": df.filter(col("tags").contains("Child")).count(),
        "Disabled": df.filter((col("tags").contains("Disability")) | (col("tags").contains("Disable"))).count(),
        "Backward": df.filter((col("tags").contains("Backward")) | (col("tags").contains("Scheduled"))).count(),
        "Student": df.filter(col("tags").contains("Student")).count(),
        "Farmer": df.filter(col("tags").contains("Agriculture")).count()
    }
    print("Applicant Counts:", applicantWiseCounts)
    #  3 2 4 5 8 7
    schema = StructType([
        StructField("Category", StringType(), True),
        StructField("Count", IntegerType(), True)
    ])
    df_applicant_wise = spark.createDataFrame(list(applicantWiseCounts.items()), schema=schema)


    #Dept wise Filtering
    #df.select("Implementing Agency").show()
    #df.groupBy("Implementing Agency").count().show()
    DeptwiseMap = {row["implementing_agency"]: row["count"] for row in  df.groupBy("implementing_agency").count().collect()}
    print("Department Counts:",DeptwiseMap)
   
    DeptwiseMap.pop("0")
    schema = StructType([
    StructField("Department", StringType(), True),
    StructField("count", IntegerType(), True)
    ])
    df_dept_wise = spark.createDataFrame(list(DeptwiseMap.items()), schema=schema)

    #year wise filtering
    df_yr = df.withColumn("Year", year("open_date")).groupBy("Year").count()
    yearWisemap = {row["Year"]: row["count"] for row in df_yr.collect()}
    schema = StructType([
    StructField("Year", StringType(), True),
    StructField("count", IntegerType(), True)
    ])
    df_year_wise = spark.createDataFrame(list(yearWisemap.items()), schema=schema)

    print("Year Counts:",yearWisemap)
    
    
    ##Conn to MySQL DB
    df.write \
        .format("jdbc") \
        .option("url", "jdbc:mysql://mysql_ezyaid:3306/ezyaid") \
        .option("driver", "com.mysql.cj.jdbc.Driver") \
        .option("dbtable", "schemeDirectory") \
        .option("user", "root") \
        .option("password", "pass") \
        .mode("append") \
        .save()
    
    df_year_wise.write \
        .format("jdbc") \
        .option("url", "jdbc:mysql://mysql_ezyaid:3306/ezyaid") \
        .option("driver", "com.mysql.cj.jdbc.Driver") \
        .option("dbtable", "yearCounts") \
        .option("user", "root") \
        .option("password", "pass") \
        .mode("append") \
        .save()
    
    df_dept_wise.write \
        .format("jdbc") \
        .option("url", "jdbc:mysql://mysql_ezyaid:3306/ezyaid") \
        .option("driver", "com.mysql.cj.jdbc.Driver") \
        .option("dbtable", "deptCounts") \
        .option("user", "root") \
        .option("password", "pass") \
        .mode("append") \
        .save()
    

    df_applicant_wise.write \
        .format("jdbc") \
        .option("url", "jdbc:mysql://mysql_ezyaid:3306/ezyaid") \
        .option("driver", "com.mysql.cj.jdbc.Driver") \
        .option("dbtable", "applicantCounts") \
        .option("user", "root") \
        .option("password", "pass") \
        .mode("append") \
        .save()
    
    print(":) Data saved to MySQL! :)")

    
    



fetchRecords() 



'''
PS D:\MajorProject\sparkLearnings\spark_processing> docker ps

I have no name!@0fc02c7bf475:/opt/bitnami/spark$ cd ..
I have no name!@0fc02c7bf475:/opt/bitnami$ cd ..
I have no name!@0fc02c7bf475:/opt$ cd ..
I have no name!@0fc02c7bf475:/$ cd mnt/docs/spark_processing
I have no name!@0fc02c7bf475:/mnt/docs/spark_processing$ ls
all_schemes.csv  allschemes.xlsx  mysql-connector-j-8.0.33.jar  process_data.py
I have no name!@0fc02c7bf475:/mnt/docs/spark_processing$ mv mysql-connector-j-8.0.33.jar /opt/bitnami/spark/jars
I have no name!@0fc02c7bf475:/mnt/docs/spark_processing$ cd ..
I have no name!@0fc02c7bf475:/mnt/docs$ cd ..
I have no name!@0fc02c7bf475:/mnt$ cd ..
I have no name!@0fc02c7bf475:/$ cd /opt/bitnami/spark/jars 
I have no name!@0fc02c7bf475:/opt/bitnami/spark/jars$ ls'''

'''
OUTPUTTTTT
I have no name!@0fc02c7bf475:/mnt/docs/spark_processing$ python process_data.py
/mnt/docs/spark_processing/process_data.py:140: SyntaxWarning: invalid escape sequence '\M'

25/03/30 17:30:16 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Pandas Columns: Index(['id', 'scheme_name', 'open_date', 'State', 'implementing_agency',
       'category', 'subcategory', 'tags', 'brief_description',
       'detailed_description', 'benefits', 'exclusions',
       'eligibility_criteria', 'application_process', 'documents_required'],
      dtype='object')
Applicant Counts: {'Woman': 3, 'Child': 2, 'Disabled': 4, 'Backward': 5, 'Student': 8, 'Farmer': 7}
Department Counts: {'0': 44, 'Telangana Scheduled Castes Co-Operative Development Corporation Ltd.': 1, 'Minorities Welfare Department, Telangana': 2, 'Commissionerate Of Women Development & Child Welfare.': 1, 'Department Of Women Development And Child Welfare, Government Of Telangana': 1, 'Department Of Agriculture And Cooperation In Collaboration With The State Seed Development Corporation (SSDC)': 1, 'Forest Department Of The Government Of Telangana': 1, 'Backward Classes Welfare Department, Telangana': 1, 'Panchayat Raj And Rural Development Department.': 1, 'Backward Classes Welfare Department, Government Of Telangana': 1, 'Health, Medical And Family Welfare Department': 1, 'Indian Council Of Medical Research, Government Of India': 1, 'Banks': 1, 'Biotechnology Industry Research Assistance Council': 1, 'Federation Of Indian Chambers Of Commerce & Industry (FICCI), New Delhi': 1, 'Employees State Insurance Corporation': 1, 'Ministry Of Housing And Urban Affairs (MoHUA)': 1, 'Gram Panchayats (GPs)': 1, 'Regional/ Sub-regional Offices/ Training Centres Of The Board, Coir Board, Kochi': 1, 'Khadi And Village Industries Commission (KVIC)': 1, 'Zonal Railways And RPSF': 1, 'Indo French Centre For Promotion Of Advanced Research/Centre Franco-Indien Pour La Promotion De La Recherche AvancÃ©e': 1, 'Institutions Under The Ministry Of Culture, Government Of India': 1, 'National Health Authority (NHA)': 1, 'Post Office Branch Or A Designated Bank': 1, 'Regional Cancer Centre': 1, 'Common Service Centers': 1, 'Indian Council Of Agricultural Research': 3, 'Central/ State Handloom And Handicrafts Development Corporations': 1, 'University Grants Commission (UGC)': 2, 'Science And Engineering Research Board, Government Of India': 1}
Year Counts: {2015: 11, 2013: 2, 2016: 5, 2021: 2, 2023: 2, 2022: 1, 2014: 3, 2010: 1, 2018: 5, None: 33, 2011: 5, 2006: 1, 2008: 2, 2009: 2, 2007: 1, 2019: 1, 1981: 1}
+----+-----+
|Year|count|
+----+-----+
|2015|   11|
|2013|    2|
|2016|    5|
|2021|    2|
|2023|    2|
|2022|    1|
|2014|    3|
velopment Department.': 1, 'Backward Classes Welfare Department, Government Of Telangana': 1, 'Health, Medical And Family Welfare Department': 1, 'Indian Council Of Medical Research, Government Of India': 1, 'Banks': 1, 'Biotechnology Industry Research Assistance Council': 1, 'Federation Of Indian Chambers Of Commerce & Industry (FICCI), New Delhi': 1, 'Employees State Insurance Corporation': 1, 'Ministry Of Housing And Urban Affairs (MoHUA)': 1, 'Gram Panchayats (GPs)': 1, 'Regional/ Sub-regional Offices/ Training Centres Of The Board, Coir Board, Kochi': 1, 'Khadi And Village Industries Commission (KVIC)': 1, 'Zonal Railways And RPSF': 1, 'Indo French Centre For Promotion Of Advanced Research/Centre Franco-Indien Pour La Promotion De La Recherche AvancÃ©e': 1, 'Institutions Under The Ministry Of Culture, Government Of India': 1, 'National Health Authority (NHA)': 1, 'Post Office Branch Or A Designated Bank': 1, 'Regional Cancer Centre': 1, 'Common Service Centers': 1, 'Indian Council Of Agricultural Research': 3, 'Central/ State Handloom And Handicrafts Development Corporations': 1, 'University Grants Commission (UGC)': 2, 'Science And Engineering Research Board, Government Of India': 1}
Year Counts: {2015: 11, 2013: 2, 2016: 5, 2021: 2, 2023: 2, 2022: 1, 2014: 3, 2010: 1, 2018: 5, None: 33, 2011: 5, 2006: 1, 2008: 2, 2009: 2, 2007: 1, 2019: 1, 1981: 1}
+----+-----+
|Year|count|
+----+-----+
|2015|   11|
|2013|    2|
|2016|    5|
|2021|    2|
|2023|    2|
|2022|    1|
|2014|    3|
 Pour La Promotion De La Recherche AvancÃ©e': 1, 'Institutions Under The Ministry Of Culture, Government Of India': 1, 'National Health Authority (NHA)': 1, 'Post Office Branch Or A Designated Bank': 1, 'Regional Cancer Centre': 1, 'Common Service Centers': 1, 'Indian Council Of Agricultural Research': 3, 'Central/ State Handloom And Handicrafts Development Corporations': 1, 'University Grants Commission (UGC)': 2, 'Science And Engineering Research Board, Government Of India': 1}
Year Counts: {2015: 11, 2013: 2, 2016: 5, 2021: 2, 2023: 2, 2022: 1, 2014: 3, 2010: 1, 2018: 5, None: 33, 2011: 5, 2006: 1, 2008: 2, 2009: 2, 2007: 1, 2019: 1, 1981: 1}
+----+-----+
|Year|count|
+----+-----+
|2015|   11|
|2013|    2|
|2016|    5|
|2021|    2|
|2023|    2|
|2022|    1|
|2014|    3|
|2015|   11|
|2013|    2|
|2016|    5|
|2021|    2|
|2023|    2|
|2022|    1|
|2014|    3|
|2021|    2|
|2023|    2|
|2022|    1|
|2014|    3|
|2014|    3|
|2010|    1|
|2018|    5|
|NULL|   33|
|2011|    5|
|2006|    1|
|2008|    2|
|2009|    2|
|2007|    1|
|2019|    1|
|1981|    1|
+----+-----+

Year Counts: None
25/03/30 17:30:33 WARN SparkStringUtils: Truncated the string representation of a plan since it was too large. This behavior can be adjusted by setting 'spark.sql.debug.maxToStringFields'.
:) Data saved to MySQL! :)
I have no name!@0fc02c7bf475:/mnt/docs/spark_processing$
'''