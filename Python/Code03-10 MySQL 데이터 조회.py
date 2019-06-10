import pymysql

conn = pymysql.connect(host="192.168.56.108", user="root", password="1234", db="samsongdb", charset="utf8")
cur = conn.cursor()
#################
# 1. SELECT
# 1-1. 데이터 한번에 가져오기
sql = "SELECT * FROM userTable2"
cur.execute(sql)

rows = cur.fetchall()
# 원래는 한개씩 가져와야한다.

print(rows)


cur.close()
conn.close()
print('OK~')