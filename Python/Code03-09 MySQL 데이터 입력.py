import pymysql

# 1. port
# 2. id
# 3. pw
# 4. 인코딩방식
# tip) 삽업표준

####################
# 1. DB 생성(연결)
conn = pymysql.connect(host="192.168.56.108", user="root", password="1234", db="samsongdb", charset="utf8")
# tip) 위에 연결 방식이 기본

# 1-2. 연결 트럭 생성
cur = conn.cursor()


# sqlite3 -> DB가 없으면 자동생성, 있으면 자동열기
# 권장사항 : 문자열은 큰따옴표로

#####################
# 2. Table 생성
# 2-1. 쿼리문 제작
# sql = "CREATE TABLE userTable(userId INT, userName CHAR(5))"

# 2-1+. 테이블 자동생성/열기 코드
sql = "CREATE TABLE IF NOT EXISTS userTable2(userId INT, userName CHAR(5))"

# 2-2. 쿼리문 수행
cur.execute(sql)

######################
# 3. 데이터 입력
sql = "INSERT INTO userTable2 VALUES( 1, '홍길동')"
cur.execute(sql)
sql = "INSERT INTO userTable2 VALUES( 2, '이순신')"
cur.execute(sql)


######################
# 4. COMMIT
conn.commit()

# 6. DB 연결해제
cur.close()
conn.close()

print('OK~')
