import sqlite3

conn = sqlite3.connect("samsongDB_python")
cur = conn.cursor()
#################
# 1. SELECT
# 1-1. 데이터 한번에 가져오기
sql = "SELECT * FROM userTable"
cur.execute(sql)

rows = cur.fetchall()
# 원래는 한개씩 가져와야한다.

for row in rows:
    print(row)


cur.close()
conn.close()
print('OK~')