# Tip 코드



#### 이미지를 Blob 형식으로 바꾸기

1. 픽셀 -> 바이트

```
# f.read()는 파일의 내용 전체를 문자열로 리턴한다.
# f.read(1) -> 한개의 바이트 [문자] 

# outImage -> 리스트
# outImage[][] -> 0~255 사이 정수

# outImage[][] 정수 -> chr() 문자 ->

# https://wikidocs.net/26 점프투 파이썬

ord() : 문자 -> 아스키코드(정수)
아스키코드 = 0~127 = 7bit

그림 = 1픽셀 = 0~255 = 1byte


```





#### 확장자를 기준으로 파일이름을 나눈다. 

```python
import os
for dirName, subDirList, fnames in os.walk("C:/images/"):
    for fname in fnames:
        if os.path.splitext(fname)[1].upper()==".GIF": 
            print(os.path.join(dirName,fname))
```

```
C:/images/image(BigSize)\Renoir1024.gif
C:/images/image(BigSize)\Renoir2048.gif
C:/images/image(BigSize)\Renoir4096.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat01_128.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat02_128.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat03_128.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat04_128.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat05_128.gif
C:/images/Pet_GIF\Pet_GIF(128x128)\cat06_128.gif
```



#### 지정한 폴더 아래의 디렉토리들과 파일들을 모두 가져온다.

```python
import os
for dirName, subDirList, fnames in os.walk("C:/images/"):
    for fname in fnames:
        os.path.join(dirName,fname)
print("dir", dirName)
print("sub", subDirList)
print("fil", fnames)
```

```
dir C:/images/Pet_RAW\Pet_RAW(64x64)
sub []
fil ['cat01_64.raw', 'cat02_64.raw', 'cat03_64.raw', 'cat04_64.raw']
```



#### 기본 파일 입출력

- 텍스트 파일 읽기 쓰기

```
inFp = open("C:/windows/win.ini", "rt") 
outFp = open("C:/windows/new_win.ini", "w")

# 2. 파일 읽기
while True:
    inStr = inFp.readline() # readlines()
    if not inStr:
        break
    outFp.writelines(inStr) 

# 3. 파일 닫기
inFp.close()
outFp.close()
```

- 바이너리 파일 읽기 쓰기



#### DB 연동

```python
IP_ADDR = '192.168.56.110'; USER_NAME = 'root'; USER_PASS = '1234'
DB_NAME = 'BigData_DB'; CHAR_SET = 'utf8'

con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
cur = con.cursor()

tupleData = (binData,)
    cur.execute(sql, tupleData)
    con.commit()
    cur.close()
    con.close()
    print(sql)   
    sql = "INSERT INTO rawImage_TBL(raw_id , raw_height , raw_width"
    sql += ", raw_fname , raw_update , raw_uploader, raw_avg , raw_data) "
    sql += " VALUES(NULL," + str(height) + "," + str(width) + ",'"
    sql += fname + "','" + upDate +"','" + upUser + "',0 , "
    sql += " %s )"
    tupleData = (binData,)
    cur.execute(sql, tupleData)
    con.commit()
    cur.close()
    con.close()
    print(sql)

with open(fullname, 'rb') as rfp :
        binData = rfp.read()
        
fullPath = tempfile.gettempdir() + '/' + fname
with open(fullPath, 'wb') as wfp : # 파일 자동 닫기
        wfp.write(binData)
    
```



```
IP_ADDR = '192.168.56.110'; USER_NAME = 'root'; USER_PASS = '1234'
DB_NAME = 'BigData_DB'; CHAR_SET = 'utf8'

def selectFile() :
    edt1.delete(0,END)
    filename = askopenfilename(parent=window,
                               filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    if filename == '' or filename == None:
        return
    edt1.insert(0, str(filename))

import datetime
def uploadData() :
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()

    fullname = edt1.get()
    with open(fullname, 'rb') as rfp :
        binData = rfp.read()
    fname = os.path.basename(fullname)
    fsize = os.path.getsize(fullname)
    height = width = int(math.sqrt(fsize))
    now = datetime.datetime.now()
    upDate = now.strftime('%Y-%m-%d')
    upUser = USER_NAME
    sql = "INSERT INTO rawImage_TBL(raw_id , raw_height , raw_width"
    sql += ", raw_fname , raw_update , raw_uploader, raw_avg , raw_data) "
    sql += " VALUES(NULL," + str(height) + "," + str(width) + ",'"
    sql += fname + "','" + upDate +"','" + upUser + "',0 , "
    sql += " %s )"
    tupleData = (binData,)
    cur.execute(sql, tupleData)
    con.commit()
    cur.close()
    con.close()
    print(sql)

def downloadData() :
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()
    sql = "SELECT raw_fname, raw_data FROM rawImage_TBL WHERE raw_id = "
    idx = askinteger("다운로드", "idx :")
    sql += str(idx)
    
    cur.execute(sql)
    fname, binData = cur.fetchone()

    fullPath = tempfile.gettempdir() + '/' + fname
    with open(fullPath, 'wb') as wfp :
        wfp.write(binData)
    print(fullPath)
    cur.close()
    con.close()
    print(sql)
   
#### 메인 코드부 ###
window = Tk()
window.geometry("500x200")
window.title("Raw --> DB Ver 0.02")

edt1 = Entry(window, width=50); edt1.pack()
btnFile = Button(window, text="파일선택", command=selectFile); btnFile.pack()
btnUpload = Button(window, text="업로드", command=uploadData); btnUpload.pack()
btnDownload = Button(window, text="다운로드", command=downloadData); btnDownload.pack()

window.mainloop()

```





