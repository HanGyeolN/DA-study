
# ComputerVision 2



## 요약

### 마우스로 이동하기

- 이동에서 값을 입력받았던걸, 마우스로 입력받아서 똑같이 옮기면 된다.

  

  

  

### 포워딩 백워딩

- 포워딩 : in에서 보내기
- 백워딩: out쪽에서 데려오기
- 연산속도 줄이기
- 축소 연산시 for문을 inputSize로 돌릴지 outputSize로 돌릴지 고민



### 홀 문제

- 좌표 변경시 값이 비는곳을 채워야한다.



### 축소 이슈


- 맥스풀링, 평균값넣기 등으로 해결해야한다.



### Interpolation (보간법)

- Bi Linear Interpolation
- 이런 개선된 확대 방법 알고리즘을 개발해야 하니까 
- 기존 영상처리에서 딥러닝을 이용해서 해야한다.



### 회전 이슈

- 홀문제 : 포워딩해서 생긴 문제 [백워딩을 써야한다]
- 원점문제



### 속도이슈[파이썬에서 성능개선] 

- 한점씩 찍으니 느리다.
- 메모리에 찍어놓고, 한방에 찍으면 빠름
- ㄴ [버퍼기법], C++에서 사용, 하드웨어에 가까워진다.
- ㄴ 이렇게하면 상용과 가깝게 할 수있다.

```python
# displayImage() 에서 변경
rgbStr = '' 전체 필섹의 문자열을 저장할 버퍼
```

- C++로 GPU에서 바로 받아오면 더 빠르게 가능.
- 파이썬 프로파일링 사용
- [프로파일링](https://www.google.com/search?rlz=1C1SQJL_koKR846KR846&ei=TKgBXdODFOWwmAXCqY-oCw&q=파이썬+프로파일링&oq=파이썬+프로파일링&gs_l=psy-ab.3..0.4796.5690..5816...2.0..1.116.734.0j7......0....1..gws-wiz.......0i7i30j0i13.bqomDA_bKVA)



#### 영상 편집시엔 histogram을 계속 확인해 가면서 하는게 맞다.

### Contrast Stretching(명암대비 스트레칭)

- 펼친다.
- ![1560403804438](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1560403804438.png)
- End in 스트레칭
- min , max가 아닌 histogram에서 적은애들
- ![560403772964](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1560403772964.png)

가장 좋다고 알려진 알고리즘은 평활화 알고리즘이다.

- 객체추적등에 실시간으로 평활화를 사용할 수있다.
- 어두운데서 객체 추출의 성능이 올라가거나 한다.



- input은 훼손시키면 안됨
- 팁) in -> float -> int ->out
- 엠보싱 경우 연산후 어두워지기때문에 다시 밝게 처리를 해줘야한다.(마스크 합이 0 = 가중치가 0)
- 보통 중간값을 더해준다.(선택사항)



1. 회전: 역방향+중심으로 회전
   - 선택: 회전 + 영상확대
   - 선택: 회전 + 영상확대 + 양선형 보간
2. 필터링
   - 블러링
   - 샤프닝
   - 경계선검출
   - 가우시안 필터링
   - 고주파
   - 저주파
   - 엣지검출 : 5개 이상
   - 선택 : LoG DoG 엣지검출
   - 선택 : 다중 블러링 : 값을 입력받아 마스크의 크기를 가변적으로 (3,5,7,...)







```python
from tkinter import *
from tkinter.simpledialog import *
from tkinter.filedialog import *
import os
import math
import os.path
import matplotlib.pyplot as plt
```


```python
#####################################
# 함수 선언부
# 메모리를 할당해서 리스트(레퍼런스)를 반환하는 함수
def malloc(h, w, initValue = 0):
    retMemory = []
    for _ in range(h):
        tmpList = []
        for _ in range(w):
            tmpList.append(initValue)
        retMemory.append(tmpList)
    return retMemory

def outmalloc(h, w):
    retMemory = []
    for _ in range(outH):
        tmpList = []
        for _ in range(outW):
            tmpList.append(0)
        retMemory.append(tmpList)
    return retMemory

# 파일을 메모리로 로딩하는 함수
def loadImage(fname):
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    # 이미지의 가로 세로 길이를 아는게 중요
    # 지금은 이미지가 정사각형이라고 가정하고, raw파일이므로 파일 크기로 길이를 알아낼 수 있다.
    #-- 
    fsize = os.path.getsize(fname)
    inH = inW = int(math.sqrt(fsize)) # 핵심코드 
    #-- 
    
    #-- inImage 메모리 확보에 누적되는것을 방지
    inImage = []
    inImage = malloc(inH,inW) # 함수분리
    
    # 파일을 메모리로
    # print(inH);    print(inW);    print(len(inImage));    print(len(inImage[0]))    
    with open(filename, 'rb') as rFp : # 1) rb : read binary
        for i in range(inH):
            for k in range(inW):
                inImage[i][k] = int(ord(rFp.read(1))) # byte형 -> 숫자 -> 정
                
    # print(inH, inW);    print(inImage[100][100]);    print(int(ord(inImage[80][10])))
    
# 파일을 선택해서 메모리로 로딩하는 함수
def openImage(): # 2) 함수화
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    filename = askopenfilename(parent=window,
                  filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    if filename == '' or filename == None:
        return
    loadImage(filename) # 함수분리
    equalImage()

import struct
def saveImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    saveFp = asksaveasfile(parent=window, mode='wb',
                          defaultextension="*.raw", filetypes=(("RAW 파일", "*.raw"), ("모든 파일", "*.*")))
    if saveFp == '' or saveFp == None :
        return
    for i in range(outH):
        for k in range(outW):
            saveFp.write(struct.pack('B',outImage[i][k])) # struct = 1Byte 단위로 넘겨주는 
    saveFp.close

def displayImage(): # outImage만 출력하니까 입력을 받지 않는다.
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    if canvas != None : # 예전에 실행한적이 있으면 캔버스를 초기화하고 다시 생성해야한다.
        canvas.destroy()
    # 화면 크기를 조절
    window.geometry(str(outH) + 'x' + str(outW))
    canvas = Canvas(window, height=outH, width=outW)
    paper = PhotoImage(height=outH, width=outW)
    canvas.create_image((outH//2, outW//2), image=paper, state='normal')
    
    # canvas에 보이게 하기위해서는 paper에 한점씩 찍어야한다.
    #for i in range(outH):
    #    for k in range(outW):
    #        r = g = b = outImage[i][k]
    #        paper.put("#%02x%02x%02x" % (r, g, b), (k, i)) # 
    
    rgbStr = '' # 전체 픽셀의 문자열을 저장
    for i in range(outH):
        tmpStr = ''
        for k in range(outW):
            r = g = b = outImage[i][k]
            tmpStr += ' #%02x%02x%02x' % (r,g,b)
        rgbStr += '{' + tmpStr + '} ' # 구분을 위해한칸 띄워야함. 중괄호 기준으로 행을 나눈다.
    paper.put(rgbStr)
    
    canvas.bind('<Button-1>', mouseClick)
    canvas.bind('<ButtonRelease-1>', mouseRelease)                
    canvas.pack(expand=1,anchor=CENTER)
     
    

# 1) rb : read binary, rt : read text
# 2) 20~30줄 넘어가면 함수를 분리한다.
```


```python
############################################## 
# CV 알고리즘 함수 모음

# 1. 픽셀 연산
# 동일 영상 알고리즘
def equalImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    ## 주요코드
    outH = inH; outW = inW
    ##### 
    outImage = []
    outImage = malloc(outH,outW)
    
    #############
    # 핵심코드 
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = inImage[i][k]
            
    #
    #######
    displayImage()
    
# 밝게
def addImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    ## 주요코드
    ### 출력 크기 설정
    outH = inH; outW = inW
    ### 메모리할당
    outImage = [];    outImage = malloc(outH,outW)    
    #############
    # 핵심코드 
    value = askinteger("밝기 설정", "밝게 할 값: ", minvalue=1, maxvalue=255)
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = inImage[i][k] + value
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
    #
    #######
    displayImage()  

# 어둡게
def minusImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    

    value = askinteger("밝기 설정", "어둡게 할 값: ", minvalue=1, maxvalue=255)
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = inImage[i][k] - value
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
                
    displayImage()

# 곱하기
def multipleImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    

    value = askinteger("밝기 설정", "밝기 배수: ", minvalue=1, maxvalue=255)
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = round(inImage[i][k]*value)
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
                
    displayImage()
    
# 나누기
def divImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    

    value = askinteger("밝기 설정", "어둡기 배수: ", minvalue=1, maxvalue=255)
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = round(inImage[i][k]/value)
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
                
    displayImage()

# 반전
def reverseImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    

    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = 255 - inImage[i][k]
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
                
    displayImage()

# 바이너리
def binaryImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    

    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] > 128:
                outImage[i][k] = 255
            else:
                outImage[i][k] = 0                
    displayImage()    
# 감마
def gammaImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    
    
    gamma = askfloat("감마 설정", "감마 값: ", minvalue=0, maxvalue=255)

    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = round(inImage[i][k]/gamma)
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
    displayImage()

# 포스터라이즈
def posterizeImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    
    
    Q = askinteger("단계 설정", "경계값 수: ", minvalue=0, maxvalue=255)
    
    step = round(255/Q)
    
    for i in range(inH):
        for k in range(inW):
            
            outImage[i][k] = round((inImage[i][k]/Q)*255)
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
    displayImage()

# 스트레칭
def intensityContrastStretch():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    outImage = [];    outImage = malloc(outH,outW)    
    
    max = 0
    min = 255
    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] > max:
                max = inImage[i][k]
            elif inImage[i][k] < min:
                min = inImage[i][k]
                
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = round((inImage[i][k]-min)*(255/max))
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
    displayImage()

# 파라볼라 알고리즘
def paraImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    ## 주요코드
    outH = inH; outW = inW
    ##### 
    outImage = []
    outImage = malloc(outH,outW)
    
    #############
    # 핵심코드 
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = int(255 - 255 * math.pow(inImage[i][k]/128 -1, 2))
            if outImage[i][k] > 255:
                outImage[i][k] = 255
            elif outImage[i][k] < 0:
                outImage[i][k] = 0
            
    #######
    displayImage()
    
# 파라볼라+LUT 알고리즘
def paraImage_LUT():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    ## 주요코드
    outH = inH; outW = inW
    ##### 
    outImage = []
    outImage = malloc(outH,outW)
    
    LUT = [0 for _ in range(256)]
    for input in range(256):
        LUT[input] = int(255 - 255 * math.pow(input/128 -1, 2))
    #############
    # 핵심코드 
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = LUT[inImage[i][k]]
            
    #######
    displayImage()
```


```python
#########################
# 기하처리 알고리즘
# 이동
def moveImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    # 출력 이미지 생성
    outH = inH; outW = inW
    outImage = [] ; outImage = malloc(outH,outW)
    
    # 이동값 입력: 상하 /좌우
    vertical = askinteger("단계 설정", "상(+) 하(-): ")
    horizontal = askinteger("단계 설정", "좌(-) 우(+): ")
    
    for i in range(inH):
        for k in range(inW):
            try:
                if i + vertical < 0 or k - horizontal < 0:
                    continue
                else:
                    outImage[i][k] = inImage[i+vertical][k-horizontal]
            except:
                pass
    displayImage()
    
    
# 이미지 축소
def scaleDownImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    #축소값 입력
    ds = askinteger("축소 설정", "축소배율(2/4/8/...): ")
    
    
    # 출력 이미지 메모리 생
    outH = inH//ds; outW = inW//ds
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    # 출력 이미지 생
    for i in range(outH):
        for k in range(outW):
            try:
                outImage[i][k] = inImage[i*ds][k*ds]
            except:
                pass
    displayImage()
    
# 이미지 축소 (평균값)
def scaleDownImageAvr():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    #축소값 입력
    ds = askinteger("축소 설정", "축소배율(2/4/8/...): ")    
    
    # 출력 이미지 메모리 생
    outH = inH//ds; outW = inW//ds
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    # 출력 이미지 생성
    for i in range(outH):
        for k in range(outW):
            
            avrPixel = 0
            for r in range(i*ds,i*ds+ds):
                for c in range(k*ds,k*ds+ds):
                    avrPixel = avrPixel + inImage[r][c]
            avrPixel = avrPixel/(ds*ds)
            avrPixel = round(avrPixel)
            if avrPixel < 0 :
                avrPixel = 0
            elif avrPixel > 255 :
                avrPixel = 255
            else:
                pass
                    
            outImage[i][k] = avrPixel
            
    displayImage()
    
# 이미지 확대
def scaleUpImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    #확대값 입력
    ds = askinteger("확대  설정", "확대배율(2/4): ")    
    
    # 출력 이미지 메모리 생성
    outH = inH*ds; outW = inW*ds
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    # 출력 이미지 생성
    for i in range(inH):
        for k in range(inW):
            r = ds*i
            c = ds*k
            for p in range(r,r+ds):
                outImage[p][c:c+ds] = [inImage[i][k]]*ds
            
    displayImage()

# Bi-Linear Interpolation(양선형 보간)
def scaleUpImageBLI():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    #확대값 입력
    scale = askinteger("확대  설정", "확대배율(2/4): ")    
    
    # 출력 이미지 메모리 생성
    outH = inH*scale; outW = inW*scale
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    rH, rW, iH, iW = [0]*4 # 실수 및 정수위치
    x, y = 0, 0 # 가중치: 실수와 정수의 차이값 
    C1, C2, C3, C4 = [0]*4 # 기준점: 결정 할 위치(N)의 상하좌우 픽셀
    
    # 포워딩 --> hole이 생김.
    for i in range(outH):
        for k in range(outW):
            rH = i / scale; rW = k / scale
            iH = int(rH); iW = int(rW)
            x = rW - iW
            y = rH - iH
            
            if 0 <= iH < inH-1 and 0 <= iW < inW-1:
                C1 = inImage[iH][iW]
                C2 = inImage[iH][iW+1]
                C3 = inImage[iH+1][iW+1]
                C4 = inImage[iH+1][iW]
                newValue = C1*(1-y)*(1-x) + C2*(1-y)*x + C3*x*y + C4*(1-x)*y
                outImage[i][k] = int(newValue)
    
    displayImage()

#이미지 회전 
def rotateImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    #각도 입력
    ds = askinteger("회전 설정", "회전각: ")  
    rad = math.radians(ds) # 라디안     
    cos = math.cos(rad)
    sin = math.sin(rad)
    x_center = round(inW/2)
    y_center = round(inH/2)
    
    # 출력 이미지 메모리 생성
    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)       
    
    # 출력 이미지 생성
    for i in range(inH):
        for k in range(inW):
            try:     
                new_x = cos*(i-y_center) + sin*(k-x_center)
                new_x = round(new_x) + x_center
                new_y = -sin*(i-y_center) + cos*(k-x_center)
                new_y = round(new_y) + y_center
                
                # if 0 <= new_x <:
                
                
                
                if new_x < 0 or new_y < 0:
                    continue
                else:
                    outImage[new_x][new_y] = inImage[i][k]
            except:
                pass
            
    displayImage()

# 드래그로 이미지 옮기기 ------------------
def dragImage():
    global panYN
    panYN = True
    canvas.configure(cursor='mouse')
    
def mouseClick(event):
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    # 다른 함수와 주고받아야한다
    global sx, sy, ex, ey, panYN
    
    # 
    if panYN == False:
        return
    
    # 초기점 좌표
    sx = event.x; sy = event.y
    
def mouseRelease(event):
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    global sx, sy, ex, ey, panYN
    if panYN == False:
        return
    ex = event.x; ey = event.y
    outH = inH; outW = inW
    outImage = [];    outImage = outmalloc(outH,outW)    
    
    # 이동할 거리
    mx = sx - ex; my = sy - ey
    for i in range(inH):
        for k in range(inW):
            if 0 <= i-my < outW and 0 <= k-mx < outH:
                outImage[i-my][k-mx] = inImage[i][k]
    panYN = False
    displayImage()
# -----------------------------------
```


```python
# --------------------
# 통계 기법 알고리즘
def calcAverage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    outH = inH; outW = inW
    inSum = 0
    outSum = 0
    inAvr = 0
    outAvr = 0
    
    for i in range(inH):
        for k in range(inW):
            inSum = inSum + inImage[i][k]
    inAvr = inSum/(inH*inW)
    
    for i in range(outH):
        for k in range(outW):
            outSum = outSum + outImage[i][k]
    outAvr = outSum/(outH*outW)
    
    text = "inImage 평균: " + str(inAvr) + "\noutImage 평균: " + str(outAvr)    
    messagebox.showinfo("픽셀 평균값", text)

# 히스토그램 출력
def histoImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename
    
    inCountList = [0]*256
    outCountList = [0]*256
    
    for i in range(inH):
        for k in range(inW):
            inCountList[inImage[i][k]] += 1
    
    for i in range(outH):
        for k in range(outW):
            outCountList[outImage[i][k]] += 1
            
    plt.plot(inCountList)
    plt.plot(outCountList,color='r')
    plt.show()

# 명암대비 스트레칭
def stretchImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename

    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    # 최대 최소 초기화시 이렇게
    maxVal = minVal = inImage[0][0] 
    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] < minVal:
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal:
                maxVal = inImage[i][k]
    for i in range(inH):
        for k in range(inW):
            outImage[i][k] = int(((inImage[i][k] - minVal) / (maxVal - minVal)) * 255)
    
    displayImage()

# 엔드인 스트레칭
def stretchImageEndIn():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename

    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)
        
    # 최대 최소 초기화시 이렇게
    # 픽셀의 최대 최소값
    maxVal = minVal = inImage[0][0] 
    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] < minVal:
                minVal = inImage[i][k]
            elif inImage[i][k] > maxVal:
                maxVal = inImage[i][k]
                
    minAdd = askinteger("최소", "-->", minvalue=0, maxvalue=255)
    maxAdd = askinteger("최대", "-->", minvalue=0, maxvalue=255)
    minVal = minAdd # 하위 Threshold
    maxVal = maxAdd # 상위 Threshold
    
    # 스트레칭
    for i in range(inH):
        for k in range(inW):
            old_pixel = inImage[i][k]
            new_pixel = 0
            low = minVal
            high = maxVal
            
            if old_pixel < low:
                new_pixel = 0
            elif low <= old_pixel <= high:
                new_pixel = int(((old_pixel-low) / (high - low)) * 255)
            else:
                new_pixel = 255
                
            outImage[i][k] = new_pixel
    
    displayImage()
    
    
# 히스토그램 평활화 기법
# 1. hist계산 2. hist 누적합 계산 3. 누적합 기반 정규화
def flatHistImage():
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename

    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)
    
    inHist = [0]*256
    # 1. hist 계산
    for i in range(inH):
        for k in range(inW):
            inHist[inImage[i][k]] += 1
    
    SinHist = [0]*256
    # 2. 누적합 계산
    val = 0
    for i in range(len(inHist)):
        val = val + inHist[i] 
        SinHist[i] = val
        
    maxVal = inImage[0][0]
    # 3. Max값 계산
    for i in range(inH):
        for k in range(inW):
            if inImage[i][k] > maxVal:
                maxVal = inImage[i][k]
                
    # 4. 누적합 기반 정규화
    totalPixelNum = inH*inW
    for i in range(outH):
        for k in range(outW):
            val = ( SinHist[inImage[i][k]] / totalPixelNum )*255
            if val < 0:
                val = 0
            elif val > 255:
                val = 255
            outImage[i][k] = int(val)
    
    displayImage()
    
```


```python
#############################
# 이미지 필터링

def maskingImage(mask):
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename

    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)
    
    # 마스크 생성
    MSIZE = 3
    
    ## 임시 입력영상 메모리 확보
    tmpInImage = malloc(inH + MSIZE -1, inW + MSIZE -1, 127) # 필터 경계처리
    tmpOutImage = outmalloc(outH, outW)
    
    # 임시 입력 만들어두기
    mp = MSIZE//2
    for i in range(inH):
        for k in range(inW):
            tmpInImage[i+mp][k+mp] = inImage[i][k]
            
    # 마스킹    
    for i in range(mp, inH + mp):
        for k in range(mp, inW + mp):
            
            S = 0.0
            for m in range(0,MSIZE):
                for n in range(0,MSIZE):
                    S += mask[m][n]*tmpInImage[i-mp+m][k-mp+n] 
            tmpOutImage[i-mp][k-mp] = S
    
    # 밝기 처리 : 블러링은 x
    #for i in range(outH):
    #    for k in range(outW):
    #        tmpOutImage[i][k] += 127 
    
    # 원출력으로 넘기기
    for i in range(outH):
        for k in range(outW):
            value = tmpOutImage[i][k]
            if value > 255:
                value = 255
            elif value < 0:
                value = 0
            outImage[i][k] = int(value)
    
    displayImage()

def edgingImage(mask1, mask2):
    global inImage, outImage ,inH, inW, outH, outW, window, canvas, paper, filename

    outH = inH; outW = inW
    outImage = [] ; outImage = outmalloc(outH,outW)
    
    # 마스크 생성
    MSIZE = 3
    
    ## 임시 입력영상 메모리 확보
    tmpInImage = malloc(inH + MSIZE -1, inW + MSIZE -1, 127) # 필터 경계처리
    
    tmpOutImage_v = outmalloc(outH, outW)
    tmpOutImage_h = outmalloc(outH, outW)
    
    # 임시 입력 만들어두기
    mp = MSIZE//2
    for i in range(inH):
        for k in range(inW):
            tmpInImage[i+mp][k+mp] = inImage[i][k]
            
    # 마스킹    
    for i in range(mp, inH + mp):
        for k in range(mp, inW + mp):
            
            S = 0.0
            for m in range(0,MSIZE):
                for n in range(0,MSIZE):
                    S += mask1[m][n]*tmpInImage[i-mp+m][k-mp+n] 
            tmpOutImage_v[i-mp][k-mp] = S
            
    for i in range(mp, inH + mp):
        for k in range(mp, inW + mp):
            
            S = 0.0
            for m in range(0,MSIZE):
                for n in range(0,MSIZE):
                    S += mask2[m][n]*tmpInImage[i-mp+m][k-mp+n] 
            tmpOutImage_h[i-mp][k-mp] = S 
    
       
    # 원출력으로 넘기기
    for i in range(outH):
        for k in range(outW):
            v = tmpOutImage_v[i][k]
            h = tmpOutImage_h[i][k]
            value = math.sqrt(v*v + h*h)
            if value > 255:
                value = 255
            elif value < 0:
                value = 0
            outImage[i][k] = int(value)
    
    displayImage()
```


```python
###########################
# 전역변수 선언부
# inImage, inWidth, inHeight, outImage, outWidth, outHeight
# 이 6개 변수가 가장 중요하다.
inImage, outImage = [], [] ; inH, inW, outH, outW = [0]*4

window, canvas, paper = [None]*3 # 그리기위한 도구
# 캔버스나 윈도우 크기는 inH inW로 정해진다.

filename = "" # 저장을 위한 키

# m_: 멤버변수
# g_: 전역변수 
# 전역변수 이름을 전역변수임이 보이도록 지어주는게 좋다

########################################
# 메인 코드  부분
window = Tk()
window.geometry("500x500")
window.title("Computer Vision Ver 0.02")

mainMenu = Menu(window)
window.config(menu=mainMenu)

fileMenu = Menu(mainMenu)
mainMenu.add_cascade(label="파일", menu=fileMenu)
fileMenu.add_command(label="파일 열기", command=openImage)
fileMenu.add_command(label="파일 저장", command=saveImage)

comVisionMenu1 = Menu(mainMenu)
mainMenu.add_cascade(label="화소점 처리", menu=comVisionMenu1)
comVisionMenu1.add_command(label="밝게", command=addImage)
comVisionMenu1.add_command(label="어둡게", command=minusImage)
comVisionMenu1.add_command(label="곱셈", command=multipleImage)
comVisionMenu1.add_command(label="나눗셈", command=divImage)
comVisionMenu1.add_command(label="반전", command=reverseImage)
comVisionMenu1.add_command(label="이진화", command=binaryImage)
comVisionMenu1.add_command(label="Posterizing", command=posterizeImage)
comVisionMenu1.add_command(label="Gamma 보정", command=gammaImage)
comVisionMenu1.add_command(label="스트레칭", command=intensityContrastStretch)
comVisionMenu1.add_command(label="파라볼라", command=paraImage)
comVisionMenu1.add_command(label="파라볼라 LUT", command=paraImage_LUT)


comVisionMenu2 = Menu(mainMenu)
mainMenu.add_cascade(label="통계 처리", menu=comVisionMenu2)
comVisionMenu2.add_command(label="평균값", command=calcAverage)
comVisionMenu2.add_command(label="히스토그램", command=histoImage)
# 통계 기반으로 계산
comVisionMenu2.add_command(label="명암대비", command=stretchImage)
comVisionMenu2.add_command(label="엔드인스트레칭", command=stretchImageEndIn)
comVisionMenu2.add_command(label="평활화", command=flatHistImage)

comVisionMenu3 = Menu(mainMenu)
mainMenu.add_cascade(label="기하 처리", menu=comVisionMenu3)
comVisionMenu3.add_command(label="이동", command=moveImage)
comVisionMenu3.add_command(label="축소", command=scaleDownImage)
comVisionMenu3.add_command(label="축소(평균)", command=scaleDownImageAvr)
comVisionMenu3.add_command(label="확대", command=scaleUpImage)
comVisionMenu3.add_command(label="확대(BLI)", command=scaleUpImageBLI)
comVisionMenu3.add_command(label="회전", command=rotateImage)
comVisionMenu3.add_command(label="드래그이동", command=dragImage)

comVisionMenu4 = Menu(mainMenu)
mainMenu.add_cascade(label="필터링", menu=comVisionMenu4)
comVisionMenu4.add_command(label="엠보싱", command=lambda : maskingImage([-1, 0, 0], [ 0, 0, 0], [ 0, 0, 1]))
comVisionMenu4.add_command(label="블러링", command=lambda : maskingImage([[1/9,1/9,1/9],[1/9,1/9,1/9],[1/9,1/9,1/9]]))
comVisionMenu4.add_command(label="샤프닝", command=lambda : maskingImage([[-1, -1, -1], [-1, 9, -1], [-1, -1, -1]]))
comVisionMenu4.add_command(label="경계선검출", command=lambda: edgingImage([[-1, 0, 0],[0,1,0],[0,0,0]],[[0, 0, -1],[0,1,0],[0,0,0]]))
comVisionMenu4.add_command(label="가우시안필터링", command=lambda : maskingImage([[1/16, 1/8, 1/16], [1/8, 1/4, 1/8], [1/16, 1/8, 1/16]]))
comVisionMenu4.add_command(label="고주파", command=lambda : maskingImage([[-1/9, -1/9, -1/9], [-1/9, 8/9, -1/9], [-1/9, -1/9, -1/9]]))
comVisionMenu4.add_command(label="저주파", command=lambda : maskingImage([[1/9, 1/9, 1/9], [1/9, 1/9, 1/9], [1/9, 1/9, 1/9]]))
edgeDetectionMenu = Menu(comVisionMenu4)
comVisionMenu4.add_cascade(label="에지검출", menu=edgeDetectionMenu)
edgeDetectionMenu.add_command(label="수직", command=lambda : maskingImage([[-1, 0, 1],[-2,0,2],[-1,0,1]]))
edgeDetectionMenu.add_command(label="수평", command=lambda : maskingImage([[1, 2, 1],[0,0,0],[-1,-2,-1]]))
edgeDetectionMenu.add_command(label="라플라시안", command=lambda : maskingImage([[0, -1, 0],[-1,4,-1],[0,-1,0]]))
edgeDetectionMenu.add_command(label="소벨", command=lambda : edgingImage([[-1, 0, 1],[-2,0,2],[-1,0,1]],[[1, 2, 1],[0,0,0],[-1,-2,-1]]))
edgeDetectionMenu.add_command(label="Prewitt", command=lambda : edgingImage([[1, 0, -1],[1,0,-1],[1,0,-1]],[[1,1,1],[0,0,0],[-1,-1,-1]]))


window.mainloop()
```


```python

```

 1) 이진화나 Posterizing으로 영상의 크기를 많이 줄여서 처리하기도 한다.
 2) 연산량 이슈. 1024x1024 = 100만
 - LookUpTable 연산 : 미리 계산해서 테이블화 시킨다.
 - 실무에서 자주 사용, 
