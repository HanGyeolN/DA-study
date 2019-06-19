import pymysql

# DB 정보 
DB_IP = "192.168.56.112"
DB_ID = "root"
DB_PW = "1234"
DB_CHARSET = "utf8"
DB_PORT = "3306"
DB_NAME = "test_db"
tableName = "test_tbl_02" 

def makeSql(tableName, valueList=[], mode=0):    
    if mode == "CREATE TABLE":
        sql = "CREATE TABLE IF NOT EXISTS "+tableName+"(id INT, juminbunho VARCHAR(20), email VARCHAR(40))"
        print("SQL :", sql)
        return sql

    elif mode == "INSERT":
        sql = "INSERT INTO " +tableName+" VALUES ("
        for value in valueList:
            if type(value) == int or type(value) == float:
                sql += str(value)
                sql += ", "
            elif type(value) == str:
                sql = sql + "'" + value + "'"
                sql += ", "
        sql = sql[0:-2]
        sql += ")"
        print("SQL :", sql)
        return sql
    
    else:
        print("mode error")
        return 

def pushDB():
    con = pymysql.connect(host=DB_IP,user=DB_ID, password=DB_PW, db=DB_NAME,charset=DB_CHARSET)
    cur = con.cursor()
    
    # table 생성
    sql = makeSql(tableName, mode="CREATE TABLE")
    cur.execute(sql)

    # 데이터 입력
    while True:
        temp_id = input("id(숫자): ")
        if temp_id == "":
            break
        juminbunho = input("주민번호: ")
        email = input("이메일: ")
        valueList = [int(temp_id), juminbunho, email]

        sql = makeSql(tableName,valueList, mode="INSERT")
        cur.execute(sql)
    

    con.commit()
    cur.close()
    con.close()

def getDB():
    con = pymysql.connect(host=DB_IP,user=DB_ID, password=DB_PW, db=DB_NAME,charset=DB_CHARSET)
    cur = con.cursor()
    
    sql = "SELECT * FROM "+tableName
    cur.execute(sql)

    print("\n아이디".ljust(7), "주민번호".ljust(16), "이메일".ljust(17))
    print("---------------------------------------")
    while True:
        row = cur.fetchone()
        if row is None:
            break
        print(str(row[0]).ljust(10), row[1].ljust(20), row[2].ljust(20))

    cur.close()
    con.close()


if __name__ == "__main__":
    while True:
        
        sel = input("\n데이터 저장[1] 데이터 조회[2] 종료[3] : ")
        sel = int(sel)

        if sel == 1:
            pushDB()
        elif sel == 2:
            getDB()
        else:
            break


        

    
        
    
    


    