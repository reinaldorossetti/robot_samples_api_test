import psycopg2
import csv
import os
from datetime import datetime

# Conexão com o banco de dados
conn = psycopg2.connect(
    host="localhost",
    port=5438,
    database="postgres",
    user="postgres",
    password="PASS2023.postgres"
)

cur = conn.cursor()
ROOT_DIR = os.path.abspath(os.curdir)
FULL_PATH = '{}/allure-results/data/suites.csv'.format(ROOT_DIR)
# Abre o arquivo CSV e lê cada linha
with open(FULL_PATH) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    next(csv_reader)
    for row in csv_reader:
        print(row)
        status = str(row[0])
        start_time = str(row[1])
        stop_time = str(row[2])
        duration_in_ms = str(row[3])
        parent_suite = row[4] if row[4] != "" else None
        suite = row[5]
        sub_suite = row[6] if row[6] != "" else None
        test_class = row[7] if row[7] != "" else None
        test_method = row[8] if row[8] != "" else None
        name = row[9] if row[9] != "" else None
        description = row[10] if row[10] != "" else None
        
        sql = """INSERT INTO automation_suites (status, start_time, stop_time, duration_in_ms, parent_suite, suite, sub_suite, test_class, test_method, name, description)
                 VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        values = (status, start_time, stop_time, duration_in_ms, parent_suite, suite, sub_suite, test_class, test_method, name, description)
        cur.execute(sql, values)
        
# Commit da transação e fechamento da conexão com o banco de dados
conn.commit()
cur.close()
conn.close()





