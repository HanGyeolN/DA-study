# CV 프로그램
from tkinter import *
from tkinter.simpledialog import *
from tkinter.filedialog import *
import math
import os
import os.path
import sqlite3
import csv
import xlrd
import xlwt
import xlsxwriter; import numpy as np
import time

####################
#### 함수 선언부 ####
####################
# 메모리를 할당해서 리스트(참조)를 반환하는 함수

# 숫자로 저장한 엑셀을 읽어서 영상으로 출력하기
def openExcel():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    loadFp = askopenfile(parent=None, mode="rt", filetypes=(("엑셀 파일", "*.xls;*.xlsx"), ("모든파일", "*.*")))

    if loadFp == '' or loadFp == None:
        return

    wb = xlrd.open_workbook(filename=loadFp.name)
    ws = wb.sheet_by_index(0)

    inH = ws.nrows
    inW = ws.ncols
    inImage = []
    inImage = malloc(inH, inW)

    for r in range(inH):
        inImage[r][:] = map(int,ws.row_values(r))

    equalImage()

def openExcelArt():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    loadFp = askopenfile(parent=None, mode="rt", filetypes=(("엑셀 파일", "*.xls;*.xlsx"), ("모든파일", "*.*")))

    if loadFp == '' or loadFp == None:
        return

    wb = xlrd.open_workbook(filename=loadFp.name)
    ws = wb.sheet_by_index(0)

    wb = xlsxwriter.Workbook(loadFp.name) # 워크북 열기
    ws = wb.add_worksheet(sheetName) # 워크시트 추가

    inH = ws.nrows
    inW = ws.ncols
    inImage = []
    inImage = malloc(inH, inW)

    for r in range(inH):
        inImage[r][:] = map(int, ws.row_values(r))

    equalImage()


def saveExcelArt():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    saveFp = asksaveasfile(parent=None, mode='wt', defaultextension=".xls",
                           filetypes=(("엑셀 파일", "*.xls"), ("모든파일", "*.*")))

    if saveFp == '' or saveFp == None:
        return
    xlsName = saveFp.name
    sheetName = os.path.basename(filename)

    # xlsxwriter 변경점
    wb = xlsxwriter.Workbook(xlsName) # 워크북 열기
    ws = wb.add_worksheet(sheetName) # 워크시트 추가

    ws.set_column(0,outW-1, 1.0) # 0부터 outW 열까지 길이 조절
    for i in range(outH): # 행 높이는 한개씩 조절해야해서 for문
        ws.set_row(i, 9.5)

    for r in range(outH):
        for c in range(outW):
            data = outImage[r][c] # data 값으로 배경색을 조절 #000000 ~ #FFFFFF

            if data>15:
                hexStr = '#' + hex(data)[2:]*3 # 헥사값은 0x로 시작하므로 그걸 뗀다.
            else:
                hexStr = '#' + ('0'+hex(data)[2:]) * 3 # 16 미만 값도 2글자로 맞춰야한다.

            # 셀 포맷을 준비
            cell_format = wb.add_format()
            cell_format.set_bg_color(hexStr)

            ws.write(r, c, '', cell_format) # 셀값은 안채우고 색만 채운다.

    wb.close()
    print("Excel Art. save OK")

def saveExcel():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    saveFp = asksaveasfile(parent=None, mode='wt', defaultextension=".xls",
                           filetypes=(("엑셀 파일", "*.xls"), ("모든파일", "*.*")))

    if saveFp == '' or saveFp == None:
        return
    xlsName = saveFp.name
    sheetName = os.path.basename(filename)
    wb = xlwt.Workbook() # 워크북 열기
    ws = wb.add_sheet(sheetName) # 워크시트 추가

    for r in range(outH):
        for c in range(outW):
            ws.write(r, c, outImage[r][c])

    wb.save(xlsName)
    print("Excel. save OK")

def saveCSV():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    saveFp = asksaveasfile(parent=None, mode='wt', defaultextension=".csv", filetypes=(("csv파일", "*.csv"), ("모든파일", "*.*")))
    with open(saveFp.name, mode='w', newline='') as wFp:
        writer = csv.writer(wFp)

        temp_row = ""
        for r in range(outH):
            for c in range(outW):
                temp_row = (str(r), str(c), str(outImage[r][c]))
                writer.writerow(temp_row)

def loadCSV():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    loadFp = askopenfile(parent=None, mode="rt", filetypes=(("csv파일", "*.csv"), ("모든파일", "*.*")))

    with open(loadFp.name) as rfp:
        print("오픈: ",loadFp.name)
        reader = csv.reader(rfp)

        reader = list(reader)
        length = len(reader)

        inH = inW = int(math.sqrt(length))

        inImage = malloc(inH, inW)
        print("길이", inH, inW)

        for val in reader:
            inImage[int(val[0])][int(val[1])] = int(val[2])

    print(inImage[0][0])
    equalImage()

def saveSqlite():
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW

    con = sqlite3.connect("bigdataDB")
    cur = con.cursor()

    sql = "CREATE TABLE IF NOT EXISTS rawImage_TBL(raw_id INT, raw_fname CHAR(50))"
    cur.execute(sql)
    sql = "INSERT INTO rawImage_TBL VALUES (1,'test.raw')"
    cur.execute(sql)

    cur.close()
    con.close()
    print('savesqlite')

def loadSqlite():
    con = sqlite3.connect("bigdataDB")
    cur = con.cursor()

    sql = "SELECT * FROM rawImage_TBL"
    cur.execute(sql)

    datas = cur.fetchall()
    print(datas)
    print("load sqlite")
    cur.close()
    con.close()

def malloc(h, w,initValue=0, dataType=np.uint8) :
    retMemory = np.zeros((h,w), dtype=dataType)
    retMemory += initValue
    return retMemory


# 파일을 메모리로 로딩하는 함수
def loadImage(fname) :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    fsize = os.path.getsize(fname) # 파일의 크기(바이트)
    inH = inW = int(math.sqrt(fsize)) # 핵심 코드
    ## 입력영상 메모리 확보 ##
    inImage=[]
    inImage=np.fromfile(fname, dtype=np.uint8)
    inImage=inImage.reshape(inH,inW)


# 파일을 선택해서 메모리로 로딩하는 함수
def openImage() :
    global window, canvas, paper, filename, inImage, outImage,inH, inW, outH, outW
    filename = askopenfilename(parent=window,
                filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    if filename == '' or filename == None :
        return
    start = time.time()
    loadImage(filename)
    equalImage()
    print(time.time()-start)

import struct
def saveImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    saveFp = asksaveasfile(parent=window, mode='wb',
        defaultextension='*.raw', filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    print(saveFp, type(saveFp))
    if saveFp == '' or saveFp == None :
        return
    for i in range(outH) :
        for k in range(outW) :
            saveFp.write(struct.pack('B', outImage[i][k]))
    saveFp.close()

def displayImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    global VIEW_X, VIEW_Y
    if canvas != None : # 예전에 실행한 적이 있다.
        canvas.destroy()

    ## 고정된 화면 크기
    if outH <= VIEW_Y or outW <= VIEW_X :
        VIEW_X = outW
        VIEW_Y = outH
        step = 1
    else :
        VIEW_X = 512
        VIEW_Y = 512
        step = outW / VIEW_X

    window.geometry(str(int(VIEW_Y*1.2)) + 'x' + str(int(VIEW_X*1.2)))  # 벽
    canvas = Canvas(window, height=VIEW_Y, width=VIEW_X)
    paper = PhotoImage(height=VIEW_Y, width=VIEW_X)
    canvas.create_image((VIEW_Y // 2, VIEW_X // 2), image=paper, state='normal')


    ## 화면 크기를 조절
    # window.geometry(str(outH) + 'x' + str(outW)) # 벽
    # canvas = Canvas(window, height=outH, width=outW) # 보드
    # paper = PhotoImage(height=outH, width=outW) # 빈 종이
    # canvas.create_image((outH//2, outW//2), image=paper, state='normal')
    # ## 출력영상 --> 화면에 한점씩 찍자.
    # for i in range(outH) :
    #     for k in range(outW) :
    #         r = g = b = outImage[i][k]
    #         paper.put("#%02x%02x%02x" % (r, g, b), (k, i))
    ## 성능 개선

    rgbStr = '' # 전체 픽셀의 문자열을 저장
    for i in np.arange(0,outH, step) :
        tmpStr = ''
        for k in np.arange(0,outW, step) :
            i = int(i); k = int(k)
            r = g = b = outImage[i][k]
            tmpStr += ' #%02x%02x%02x' % (r,g,b)
        rgbStr += '{' + tmpStr + '} '
    paper.put(rgbStr)

    canvas.bind('<Button-1>', mouseClick)
    canvas.bind('<ButtonRelease-1>', mouseDrop)
    canvas.pack(expand=1, anchor=CENTER)
    status.configure(text='이미지 정보:' + str(outW) + 'x' + str(outH))

###############################################
##### 컴퓨터 비전(영상처리) 알고리즘 함수 모음 #####
###############################################
# 동일영상 알고리즘
def  equalImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    outH = inH;  outW = inW;
    outImage = inImage.copy()

    displayImage()

# 동일영상 알고리즘
def  addImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    value = askinteger("밝게/어둡게", "값-->", minvalue=-255, maxvalue=255)

    start = time.time()
    inImage = inImage.astype(np.int16)

    outImage = inImage + value
    outImage = np.where(outImage > 255, 255, outImage)
    outImage = np.where(outImage < 0, 0, outImage)

    # 이터레이터 생성 (순회용)
    # iterator = np.nditer(outImage, flags=['multi_index'], op_flags=['readwrite'])
        
    # ** 이터레이터 기본 구문 # 훨씬 느리다.
    #while not iterator.finished:
    #    idx = iterator.multi_index
    #    if outImage[idx] > 255:
    #        outImage[idx] = 255
    #    elif outImage[idx] < 0:
    #        outImage[idx] = 0
    #   iterator.iternext()    

    seconds = time.time() - start
    print("밝기 연산속도:", time.time()-start)    
    displayImage()
    status.configure(text=status.cget("text") + "\t\t 시간(초):" + "{0:.2f}".format(seconds))

# 반전영상 알고리즘
def  revImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    start = time.time()
    outImage = 255 - inImage
    print("반전 속도:", time.time()-start)
    displayImage()

# 이진화 알고리즘
def  bwImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    start = time.time()

    avg = inImage.mean()
    print("T:",avg)
    outImage = np.where(inImage > avg, 255, 0)
    print("걸린시간:", time.time()-start)
    displayImage()

# 파라볼라 알고리즘 with LUT
def  paraImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    start = time.time()
    
    LUT = (255 - 255*(np.arange(256)/128 -1)*(np.arange(256)/128 - 1))
    LUT = LUT.astype(np.uint8)
    
    outImage = LUT[inImage]
    print("걸린시간:", time.time()-start)

    displayImage()

# 상하반전 알고리즘
def  upDownImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    start = time.time()
    outImage = inImage[:][::-1]

    print("걸린시간:", time.time()-start)
    displayImage()

# 화면이동 알고리즘
def moveImage() :
    global panYN
    panYN = True
    canvas.configure(cursor='mouse')

def mouseClick(event) :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    global sx,sy,ex,ey, panYN
    if panYN == False :
        return
    sx = event.x; sy = event.y

def mouseDrop(event) :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    global sx, sy, ex, ey, panYN
    if panYN == False :
        return
    ex = event.x;    ey = event.y
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    
    start = time.time()

    mx = sx - ex; my = sy - ey
    
    temp = np.zeros((3*outH,3*outW), dtype=np.uint8)
    temp[outH:2*outH,inW:2*outW] = inImage
    outImage = temp[outH+my:2*outH+my,outW+mx:2*outW+mx]

    panYN = False
    print("걸린시간:", time.time()-start)
    displayImage()

# 영상 축소 알고리즘
def  zoomOutImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    scale = askinteger("축소", "값-->", minvalue=2, maxvalue=16)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH//scale;  outW = inW//scale;
    start = time.time()

    outImage = inImage[::scale,::scale]

    print("걸린시간:", time.time()-start)

    displayImage()


# 영상 축소 알고리즘 (평균변환)
def  zoomOutImage2() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    scale = askinteger("축소", "값-->", minvalue=2, maxvalue=16)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH//scale;  outW = inW//scale;
    outImage = np.zeros((outH,outW),dtype=np.uint8)
    start = time.time()
    
    for r in range(0,inH-scale+1,scale):
        for c in range(0,inW-scale+1,scale):
            outImage[r//scale,c//scale] = inImage[r:r+scale,c:c+scale].mean()

    print("걸린시간:", time.time()-start)
    displayImage()

# 영상 확대 알고리즘
def  zoomInImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    scale = askinteger("확대", "값-->", minvalue=2, maxvalue=8)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH*scale;  outW = inW*scale;
    outImage = np.zeros((outH,outW),dtype=np.uint8)
    start = time.time()
    
    outImage = inImage[::1/scale, ::1/scale]
    print("걸린시간:", time.time()-start)
    displayImage()

# 영상 확대 알고리즘 (양선형 보간)
def  zoomInImage2() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    scale = askinteger("확대", "값-->", minvalue=2, maxvalue=8)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH*scale;  outW = inW*scale;
    ###### 메모리 할당 ################
    start = time.time()
    outImage = np.zeros((outH,outW),dtype=np.uint8)

    rH, rW, iH, iW = [0] * 4 # 실수위치 및 정수위치
    x, y = 0, 0 # 실수와 정수의 차이값
    C1,C2,C3,C4 = [0] * 4 # 결정할 위치(N)의 상하좌우 픽셀
    for i in range(outH) :
        for k in range(outW) :
            rH = i / scale ; rW = k / scale
            iH = int(rH) ;  iW = int(rW)
            x = rW - iW; y = rH - iH
            if 0 <= iH < inH-1 and 0 <= iW < inW-1 :
                C1 = inImage[iH][iW]
                C2 = inImage[iH][iW+1]
                C3 = inImage[iH+1][iW+1]
                C4 = inImage[iH+1][iW]
                newValue = C1*(1-y)*(1-x) + C2*(1-y)* x+ C3*y*x + C4*y*(1-x)
                outImage[i][k] = int(newValue)

    print("걸린시간:", time.time()-start)
    displayImage()

# 영상 회전 알고리즘
def  rotateImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    angle = askinteger("회전", "값-->", minvalue=1, maxvalue=360)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    start = time.time()

    outImage = np.zeros((outH,outW), dtype=np.uint8)
    radian = angle * math.pi / 180

    for i in range(inH) :
        for k in range(inW) :
            xs = i ; ys = k;
            xd = int(math.cos(radian) * xs - math.sin(radian) * ys)
            yd = int(math.sin(radian) * xs + math.cos(radian) * ys)
            outImage
            if 0<= xd < inH and 0 <= yd < inW :
                outImage[xd][yd] = inImage[i][k]

    print("걸린시간:", time.time()-start)
    displayImage()

# 영상 회전 알고리즘 - 중심, 역방향
def  rotateImage2() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    angle = askinteger("회전", "값-->", minvalue=1, maxvalue=360)
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    outImage = np.zeros((outH,outW), dtype=np.uint8)
    start = time.time()
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    radian = angle * math.pi / 180
    cx = inW//2; cy = inH//2
    for i in range(outH) :
        for k in range(outW) :
            xs = i ; ys = k;
            xd = int(math.cos(radian) * (xs-cx) - math.sin(radian) * (ys-cy)) + cx
            yd = int(math.sin(radian) * (xs-cx) + math.cos(radian) * (ys-cy)) + cy
            if 0<= xd < outH and 0 <= yd < outW :
                outImage[xs][ys] = inImage[xd][yd]
            else :
                outImage[xs][ys] = 255
    print("걸린시간:", time.time()-start)
    displayImage()

# 히스토그램
import matplotlib.pyplot as plt
def  histoImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    start = time.time()
    inCountArray = np.zeros(256)
    outCountArray = np.zeros(256)
    

    for i in range(inH) :
        for k in range(inW) :
            inCountArray[inImage[i][k]] += 1

    for i in range(outH) :
        for k in range(outW) :
            outCountArray[outImage[i][k]] += 1
    
    print("걸린시간:", time.time()-start)
    plt.plot(inCountArray)
    plt.plot(outCountArray)
    plt.show()

def  histoImage2() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    outCountList = [0] * 256
    normalCountList = [0] * 256
    # 빈도수 계산
    for i in range(outH) :
        for k in range(outW) :
            outCountList[outImage[i][k]] += 1
    maxVal = max(outCountList); minVal = min(outCountList)
    High = 256
    # 정규화 = (카운트값 - 최소값) * High / (최대값 - 최소값)
    for i in range(len(outCountList)) :
        normalCountList[i] = (outCountList[i] - minVal) * High  / (maxVal-minVal)
    ## 서브 윈도창 생성 후 출력
    subWindow = Toplevel(window)
    subWindow.geometry('256x256')
    subCanvas = Canvas(subWindow, width=256, height=256)
    subPaper = PhotoImage(width=256, height=256)
    subCanvas.create_image((256//2, 256//2), image=subPaper, state='normal')

    for i in range(len(normalCountList)) :
        for k in range(int(normalCountList[i])) :
            data= 0
            subPaper.put('#%02x%02x%02x' % (data, data, data), (i, 255-k))
    subCanvas.pack(expand=1, anchor=CENTER)
    subWindow.mainloop()


# 스트레칭 알고리즘
def  stretchImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    maxVal = minVal = inImage[0][0]
    for i in range(inH) :
        for k in range(inW) :
            if inImage[i][k] < minVal :
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal :
                maxVal = inImage[i][k]
    for i in range(inH) :
        for k in range(inW) :
            outImage[i][k] = int(((inImage[i][k] - minVal) / (maxVal - minVal)) * 255)

    displayImage()


# 스트레칭 알고리즘
def  endinImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    maxVal = minVal = inImage[0][0]
    for i in range(inH) :
        for k in range(inW) :
            if inImage[i][k] < minVal :
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal :
                maxVal = inImage[i][k]

    minAdd = askinteger("최소", "최소에서추가-->", minvalue=0, maxvalue=255)
    maxAdd = askinteger("최대", "최대에서감소-->", minvalue=0, maxvalue=255)
    #
    minVal += minAdd
    maxVal -= maxAdd

    for i in range(inH) :
        for k in range(inW) :
            value = int(((inImage[i][k] - minVal) / (maxVal - minVal)) * 255)
            if value < 0 :
                value = 0
            elif value > 255 :
                value = 255
            outImage[i][k] = value

    displayImage()


# 평활화 알고리즘
def  equalizeImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    histo = [0] * 256; sumHisto = [0]*256; normalHisto = [0] * 256
    ## 히스토그램
    for i in range(inH) :
        for k in range(inW) :
            histo[inImage[i][k]] += 1
    ## 누적히스토그램
    sValue = 0
    for i in range(len(histo)) :
        sValue += histo[i]
        sumHisto[i] = sValue
    ## 정규화 누적 히스토그램
    for i in range(len(sumHisto)):
        normalHisto[i] = int(sumHisto[i] / (inW*inH) * 255)
    ## 영상처리
    for i in range(inH) :
        for k in range(inW) :
            outImage[i][k] = normalHisto[inImage[i][k]]
    displayImage()

## 엠보싱 처리
def  embossImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    MSIZE = 3
    mask = [ [-1, 0, 0],
             [ 0, 0, 0],
             [ 0, 0, 1] ]
    ## 임시 입력영상 메모리 확보
    tmpInImage = malloc(inH+MSIZE-1, inW+MSIZE-1, 127)
    tmpOutImage = malloc(outH, outW)
    ## 원 입력 --> 임시 입력
    for i in range(inH) :
        for k in range(inW) :
            tmpInImage[i+MSIZE//2][k+MSIZE//2] = inImage[i][k]
    ## 회선연산
    for i in range(MSIZE//2, inH + MSIZE//2) :
        for k in range(MSIZE//2, inW + MSIZE//2) :
            # 각 점을 처리.
            S = 0.0
            for m in range(0, MSIZE) :
                for n in range(0, MSIZE) :
                    S += mask[m][n]*tmpInImage[i+m-MSIZE//2][k+n-MSIZE//2]
            tmpOutImage[i-MSIZE//2][k-MSIZE//2] = S
    ## 127 더하기 (선택)
    for i in range(outH) :
        for k in range(outW) :
            tmpOutImage[i][k] += 127
    ## 임시 출력 --> 원 출력
    for i in range(outH):
        for k in range(outW):
            value = tmpOutImage[i][k]
            if value > 255 :
                value = 255
            elif value < 0 :
                value = 0
            outImage[i][k] = int(value)

    displayImage()

# 모핑 알고리즘
def  morphImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    ## 중요! 코드. 출력영상 크기 결정 ##
    outH = inH;  outW = inW;
    ## 추가 영상 선택
    filename2 = askopenfilename(parent=window,
                               filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    if filename2 == '' or filename2 == None:
        return

    fsize = os.path.getsize(filename2)  # 파일의 크기(바이트)
    inH2 = inW2 = int(math.sqrt(fsize))  # 핵심 코드
    ## 입력영상 메모리 확보 ##
    inImage2 = []
    inImage2 = malloc(inH2, inW2)
    # 파일 --> 메모리
    with open(filename2, 'rb') as rFp:
        for i in range(inH2):
            for k in range(inW2):
                inImage2[i][k] = int(ord(rFp.read(1)))
    ###### 메모리 할당 ################
    outImage = [];    outImage = malloc(outH, outW)
    ####### 진짜 컴퓨터 비전 알고리즘 #####
    #w1 = askinteger("원영상 가중치", "가중치(%)->", minvalue=0, maxvalue=100)
    #w2 = 1- (w1/100);    w1 = 1-w2

    import threading
    import time
    def morpFunc() :
        w1 = 1;        w2 = 0
        for _ in range(20) :
            for i in range(inH) :
                for k in range(inW) :
                    newValue = int(inImage[i][k]*w1 + inImage2[i][k]*w2)
                    if newValue > 255 :
                        newValue = 255
                    elif newValue < 0 :
                        newValue = 0
                    outImage[i][k] =newValue
            displayImage()
            w1 -= 0.05;        w2 += 0.05
            time.sleep(0.5)

    threading.Thread(target=morpFunc).start()

## 임시 경로에 outImage를 저장하기.
import random
def saveTempImage() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    import tempfile
    saveFp = tempfile.gettempdir() + "/" + str(random.randint(10000, 99999)) + ".raw"
    if saveFp == '' or saveFp == None :
        return
    print(saveFp)
    saveFp = open(saveFp, mode='wb')
    for i in range(outH) :
        for k in range(outW) :
            saveFp.write(struct.pack('B', outImage[i][k]))
    saveFp.close()
    return saveFp

def findStat(fname) :
    # 파일 열고, 읽기.
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
    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] < minVal:
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal:
                maxVal = inImage[i][k]
    return avg, maxVal, minVal

import pymysql
IP_ADDR = '192.168.56.111'; USER_NAME = 'root'; USER_PASS = '1234'
DB_NAME = 'BigData_DB'; CHAR_SET = 'utf8'
def saveMysql() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()

    try:
        sql = '''
                CREATE TABLE rawImage_TBL (
                raw_id INT AUTO_INCREMENT PRIMARY KEY,
                raw_fname VARCHAR(30),
                raw_extname CHAR(5),
                raw_height SMALLINT, raw_width SMALLINT,
                raw_avg  TINYINT UNSIGNED , 
                raw_max  TINYINT UNSIGNED,  raw_min  TINYINT UNSIGNED,
                raw_data LONGBLOB);
            '''
        cur.execute(sql)
    except:
        pass

    ## outImage를 임시 폴더에 저장하고, 이걸 fullname으로 전달.
    fullname = saveTempImage()
    fullname = fullname.name
    with open(fullname, 'rb') as rfp:
        binData = rfp.read()

    fname, extname = os.path.basename(fullname).split(".")
    fsize = os.path.getsize(fullname)
    height = width = int(math.sqrt(fsize))
    avgVal, maxVal, minValue = findStat(fullname)  # 평균,최대,최소
    sql = "INSERT INTO rawImage_TBL(raw_id , raw_fname,raw_extname,"
    sql += "raw_height,raw_width,raw_avg,raw_max,raw_min,raw_data) "
    sql += " VALUES(NULL,'" + fname + "','" + extname + "',"
    sql += str(height) + "," + str(width) + ","
    sql += str(avgVal) + "," + str(maxVal) + "," + str(minValue)
    sql += ", %s )"
    tupleData = (binData,)
    cur.execute(sql, tupleData)
    con.commit()
    cur.close()
    con.close()
    os.remove(fullname)
    print("업로드 OK -->" + fullname)


def loadMysql() :
    global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
    con = pymysql.connect(host=IP_ADDR, user=USER_NAME, password=USER_PASS,
                          db=DB_NAME, charset=CHAR_SET)
    cur = con.cursor()
    sql = "SELECT raw_id, raw_fname, raw_extname, raw_height, raw_width "
    sql += "FROM rawImage_TBL"
    cur.execute(sql)

    queryList = cur.fetchall()
    rowList = [ ':'.join(map(str,row)) for row in queryList]
    import tempfile
    def selectRecord( ) :
        global window, canvas, paper, filename, inImage, outImage, inH, inW, outH, outW
        selIndex = listbox.curselection()[0]
        subWindow.destroy()
        raw_id = queryList[selIndex][0]
        sql = "SELECT raw_fname, raw_extname, raw_data FROM rawImage_TBL "
        sql += "WHERE raw_id = " + str(raw_id)
        cur.execute(sql)
        fname, extname, binData = cur.fetchone()

        fullPath = tempfile.gettempdir() + '/' + fname + "." + extname
        with open(fullPath, 'wb') as wfp:
            wfp.write(binData)
        cur.close()
        con.close()

        loadImage(fullPath)
        equalImage()

    ## 서브 윈도에 목록 출력하기.
    subWindow = Toplevel(window)
    listbox = Listbox(subWindow)
    button = Button(subWindow, text='선택', command = selectRecord)

    for rowStr in rowList :
        listbox.insert(END, rowStr)

    listbox.pack(expand=1, anchor=CENTER)
    button.pack()
    subWindow.mainloop()


    cur.close()
    con.close()

####################
#### 전역변수 선언부 ####
####################
inImage, outImage = [], [] ; inH, inW, outH, outW = [0] * 4
window, canvas, paper = None, None, None
filename = ""
panYN = False
sx,sy,ex,ey = [0] * 4
VIEW_X, VIEW_Y = 512, 512 # 화면에 보일 크기 (출력용)
####################
#### 메인 코드부 ####
####################
window = Tk()
window.geometry("500x500")
window.title("컴퓨터 비전(딥러닝 기법) ver 0.05")

status = Label(window, text='이미지 정보:', bd=1, relief=SUNKEN, anchor=W)
status.pack(side=BOTTOM, fill=X)

## 마우스 이벤트


mainMenu = Menu(window)
window.config(menu=mainMenu)

fileMenu = Menu(mainMenu)
mainMenu.add_cascade(label="파일", menu=fileMenu)
fileMenu.add_command(label="파일 열기", command=openImage)
fileMenu.add_separator()
fileMenu.add_command(label="파일 저장", command=saveImage)

comVisionMenu1 = Menu(mainMenu)
mainMenu.add_cascade(label="화소점 처리", menu=comVisionMenu1)
comVisionMenu1.add_command(label="덧셈/뺄셈", command=addImage)
comVisionMenu1.add_command(label="반전하기", command=revImage)
comVisionMenu1.add_command(label="파라볼라", command=paraImage)
comVisionMenu1.add_separator()
comVisionMenu1.add_command(label="모핑", command=morphImage)

comVisionMenu2 = Menu(mainMenu)
mainMenu.add_cascade(label="통계", menu=comVisionMenu2)
comVisionMenu2.add_command(label="이진화", command=bwImage)
comVisionMenu2.add_command(label="축소(평균변환)", command=zoomOutImage2)
comVisionMenu2.add_command(label="확대(양선형보간)", command=zoomInImage2)
comVisionMenu2.add_separator()
comVisionMenu2.add_command(label="히스토그램", command=histoImage)
comVisionMenu2.add_command(label="히스토그램(내꺼)", command=histoImage2)
comVisionMenu2.add_command(label="명암대비", command=stretchImage)
comVisionMenu2.add_command(label="End-In탐색", command=endinImage)
comVisionMenu2.add_command(label="평활화", command=equalizeImage)

comVisionMenu3 = Menu(mainMenu)
mainMenu.add_cascade(label="기하학 처리", menu=comVisionMenu3)
comVisionMenu3.add_command(label="상하반전", command=upDownImage)
comVisionMenu3.add_command(label="이동", command=moveImage)
comVisionMenu3.add_command(label="축소", command=zoomOutImage)
comVisionMenu3.add_command(label="확대", command=zoomInImage)
comVisionMenu3.add_command(label="회전1", command=rotateImage)
comVisionMenu3.add_command(label="회전2(중심,역방향)", command=rotateImage2)

comVisionMenu4 = Menu(mainMenu)
mainMenu.add_cascade(label="화소영역 처리", menu=comVisionMenu4)
comVisionMenu4.add_command(label="엠보싱", command=embossImage)

comVisionMenu5 = Menu(mainMenu)
mainMenu.add_cascade(label="데이터베이스 입출력", menu=comVisionMenu5)
comVisionMenu5.add_command(label="MySQL에서 불러오기", command=loadMysql)
comVisionMenu5.add_command(label="MySQL에 저장하기", command=saveMysql)
comVisionMenu5.add_command(label="SQLite에서 불러오기", command=loadSqlite)
comVisionMenu5.add_command(label="SQLite에 저장하기", command=saveSqlite)

comVisionMenu6 = Menu(mainMenu)
mainMenu.add_cascade(label="기타 입출력", men=comVisionMenu6)
comVisionMenu6.add_command(label="CSV열기", command=loadCSV)
comVisionMenu6.add_command(label="CSV저장", command=saveCSV)
comVisionMenu6.add_separator()
comVisionMenu6.add_command(label="Excel열기", command=openExcel)
comVisionMenu6.add_command(label="Excel저장", command=saveExcel)
comVisionMenu6.add_command(label="엑셀 아트로 저장", command=saveExcelArt)


window.mainloop()