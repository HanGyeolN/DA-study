from tkinter import *
from tkinter.simpledialog import *
from tkinter.filedialog import *
import math
import os
import os.path
import pymysql
####################
#### 전역 변수부 ####
####################
IP_ADDR = '192.168.56.111'; USER_NAME = 'root'; USER_PASS = '1234'
DB_NAME = 'BigData_DB'; CHAR_SET = 'utf8'
####################
#### 함수부 ####
####################
def selectFolder() :
    global rawFileList # 가져가는게 좋다.

    foldername = askdirectory(parent=window)

    if foldername == '' or foldername == None:
        return
    edt1.insert(0, str(foldername))

    # 파일 목록 뽑기
    rawFileList = []
    for dirName, subDirList, fnames in os.walk(foldername):
        for fname in fnames:
            filename, extname = os.path.basename(fname).split(".")
            if extname.upper().strip() == 'RAW': # strip 필수
                rawFileList.append(os.path.join(dirName, fname))
    
def malloc(h, w, initValue=0) :
    retMemory= []
    for _ in range(h) :
        tmpList = []
        for _ in range(w) :
            tmpList.append(initValue)
        retMemory.append(tmpList)
    return retMemory

def findStat(fname):
    fsize = os.path.getsize(fname) # 파일의 크기(바이트)
    inH = inW = int(math.sqrt(fsize)) # 핵심 코드
    ## 입력영상 메모리 확보 ##
    inImage=[]
    inImage=malloc(inH,inW)
    # 파일 --> 메모리
    with open(fname, 'rb') as rFp:
        for i in range(inH) :
            for k in range(inW) :
                inImage[i][k] = int(ord(rFp.read(1)))
    
    sum = 0

    for i in range(inH) :
        for k in range(inW) :
            sum += inImage[i][k]
    avg = sum // (inW * inH)
        
    maxVal = minVal = inImage[0][0]
    for i in range(inH) :
        for k in range(inW) :
            if inImage[i][k] < minVal :
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal :
                maxVal = inImage[i][k]

    return avg, maxVal, minVal



import datetime
def uploadData() :
    global rawFileList
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()

    try: # IF NOT이 없는 SQL도 있기 때문에, 호환성때문에 try를 사용.***
        sql = '''
            CREATE TABLE rawImage_TBL2 (
            raw_id INT AUTO_INCREMENT PRIMARY KEY,
            raw_fname VARCHAR(30),
            raw_extname CHAR(5),
            raw_height SMALLINT, raw_width SMALLINT,
            raw_avg TINYINT UNSIGNED,
            raw_max TINYINT UNSIGNED, raw_min TINYINT UNSIGNED,
            raw_data LONGBLOB);
        '''
        cur.execute(sql)
    except:
        pass
    
    # 커밋시 너무 많이 한번에 commit하면 DB가 죽는 경우가 있다.
    # 적으면 한개씩 하는게 좋다.
    for fullname in rawFileList: 
        with open(fullname, 'rb') as rfp :
            binData = rfp.read()


        fname, extname = os.path.basename(fullname).split(".")
        fsize = os.path.getsize(fullname)
        height = width = int(math.sqrt(fsize))

        avgVal, maxVal, minVal = findStat(fullname) # 평균 최대 최소

       
        sql = "INSERT INTO rawImage_TBL(raw_id , raw_fname,raw_extname,"
        sql += "raw_height,raw_width,raw_avg,raw_max,raw_min,raw_data) "
        sql += " VALUES(NULL,'" + fname + "','" + extname +"',"
        sql += str(height) + "," + str(width) + ","
        sql += str(avgVal)+ "," + str(maxVal) + "," + str(minVal)
        sql += ", %s )"
        tupleData = (binData,)
        
        cur.execute(sql, tupleData)
        con.commit()
        
        print("upload ok : ", fullname)

    cur.close()
    con.close()

import tempfile

def downloadData() :
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()
    sql = "SELECT raw_fname, raw_data FROM rawImage_TBL WHERE raw_id = 1"
    cur.execute(sql)
    fname, binData = cur.fetchone()

    fullPath = tempfile.gettempdir() + '/' + fname
    with open(fullPath, 'wb') as wfp :
        wfp.write(binData)
    print(fullPath)
    cur.close()
    con.close()
    print(sql)
####################
#### 메인 코드부 ####
####################
window = Tk()
window.geometry("500x200")
window.title("Raw --> DB Ver 0.02")

edt1 = Entry(window, width=50); edt1.pack()
btnFile = Button(window, text="파일선택", command=selectFolder); btnFile.pack()
btnUpload = Button(window, text="업로드", command=uploadData); btnUpload.pack()

btnDownload = Button(window, text="다운로드", command=downloadData); btnDownload.pack()


window.mainloop()
