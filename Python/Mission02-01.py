# MySQL에 연결

import pymysql

employeeId = 0
employeeName = ""
employeeYear = 0

if __name__ == '__main__':
    conn = pymysql.connect(host="192.168.56.104",port=3306, user="root", password="1234", db="mission3",
                           charset="utf8")
    cur = conn.cursor()

    sql = "CREATE TABLE IF NOT EXISTS employeeTable(employeeId INT, employeeName CHAR(5), employeeYear SMALLINT)"
    #cur.execute(sql)

    while True:

        employeeId = int(input(" 사번 --> "))
        if employeeId == 0:
            break
        employeeName = input(" 이름 --> ")
        employeeYear = int(input(" 입사연도 --> "))

        sql = "INSERT INTO employeeTable VALUES (%d,\'%s\',%d)" % (employeeId, employeeName, employeeYear)
        cur.execute(sql)


    conn.commit()

    cur.close()
    conn.close()