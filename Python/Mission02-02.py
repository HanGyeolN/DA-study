import pymysql

employeeId = 0
employeeName = ""
employeeYear = 0

if __name__ == '__main__':
    conn = pymysql.connect(host="192.168.56.104",port=3306, user="root", password="1234", db="mission3",
                           charset="utf8")
    cur = conn.cursor()

    sql = "SELECT * FROM employeeTable"
    cur.execute(sql)

    print("사번", "이름", "입사연도")
    print("======================")

    while True:
        data = cur.fetchone()
        if data == None:
            break
        print(data[0], data[1], data[2])


    conn.commit()

    cur.close()
    conn.close()