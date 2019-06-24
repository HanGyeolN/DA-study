

```python
## 1. scikit-learn

## 2. pandas

## 3. 
```

참고
- https://blog.naver.com/beyondlegend/221355061983

### 전체 과정
1. 데이터셋 불러오기 - 나중엔 DB에서 불러오도록
2. 모델 선택
3. 학습
4. 검증
5. 사용


```python
# V1. 기본
from sklearn import svm, metrics
# metrics = 정답률 확인용

# 0. 훈련 데이터셋
train_data = [[0,0], [0,1],[1,0], [1,1]]
train_label = [0,1,1,0]
test_data = [[1,0], [0,0]]
test_label = [1,0]

# 1, Classifier 생성(선택) -> 머신러닝 알고리즘 선택
clf = svm.SVC(gamma='auto') # Classifier의 약자

# 2. 데이터로 학습 시키기
# XOR 문제 :
clf.fit(train_data, train_label) # ([훈련데이터], [정답])
# 이런 입력 데이터를 pandas에 저장해놓는걸 가장 많이함


# 3. 검증하기 - 정답률(신뢰도) 확인
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Accuracy: {0:.2f}%".format(score*100))

# 4. 예측하기
result = clf.predict([[0,0], [0,1], [1,0], [1,1]]) # ([예측할 데이터])
print(result)
```


```python
# V2. csv에서 데이터 불러오기
from sklearn import svm, metrics
import pandas as pd

# 0. 데이터 준비
csv = pd.read_csv("C:/BigData/iris/iris.csv")

train_data = csv.iloc[0:120,0:-1]
train_label = csv.iloc[0:120,[-1]]
test_data = csv.iloc[120:,0:-1]
test_label = csv.iloc[120:,[-1]]
t2 = csv.iloc[120:,-1]
print(type(test_label))
print(type(t2)) 

# 1. 알고리즘
clf = svm.SVC(gamma="auto")

# 2. 훈련
clf.fit(train_data, train_label)

# 3. 검증
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Acc: {0:.2f}%".format(score*100))

print(result)

# ==========================
# 이 위에까진 저장해놓고 쓰는 것

# 4 : 내꺼예측
result = clf.predict([[4.1, 3.3, 1.5, 0.2]])

print(result)
```

    <class 'pandas.core.frame.DataFrame'>
    <class 'pandas.core.series.Series'>



```python
# V3. scikit-learn 라이브러리 사용해서 데이터셋 쪼개기 
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
import pandas as pd

# 0. 데이터 준비
csv = pd.read_csv("C:/BigData/iris/iris.csv")

data = csv.iloc[:, 0:-1]
label = csv.iloc[:,[-1]]

train_data, test_data, train_label, test_label = train_test_split(data, label, train_size=0.3)

# 1. 알고리즘
clf = svm.SVC(gamma="auto")

# 2. 훈련
clf.fit(train_data, train_label)

# 3. 검증
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Acc: {0:.2f}%".format(score*100))

print(result)

# ==========================
# 이 위에까진 저장해놓고 쓰는 것

# 4 : 내꺼예측
result = clf.predict([[4.1, 3.3, 1.5, 0.2]])

print(result)
```

    Acc: 95.24%
    ['Setosa' 'Setosa' 'Virginica' 'Versicolor' 'Virginica' 'Versicolor'
     'Versicolor' 'Versicolor' 'Setosa' 'Versicolor' 'Virginica' 'Virginica'
     'Versicolor' 'Virginica' 'Setosa' 'Virginica' 'Virginica' 'Setosa'
     'Virginica' 'Virginica' 'Versicolor' 'Versicolor' 'Setosa' 'Versicolor'
     'Virginica' 'Virginica' 'Versicolor' 'Versicolor' 'Versicolor'
     'Versicolor' 'Virginica' 'Virginica' 'Virginica' 'Virginica' 'Versicolor'
     'Versicolor' 'Versicolor' 'Virginica' 'Versicolor' 'Setosa' 'Setosa'
     'Virginica' 'Setosa' 'Virginica' 'Setosa' 'Versicolor' 'Versicolor'
     'Setosa' 'Virginica' 'Versicolor' 'Virginica' 'Setosa' 'Versicolor'
     'Setosa' 'Virginica' 'Setosa' 'Versicolor' 'Virginica' 'Virginica'
     'Versicolor' 'Setosa' 'Setosa' 'Setosa' 'Versicolor' 'Setosa' 'Virginica'
     'Setosa' 'Setosa' 'Setosa' 'Virginica' 'Versicolor' 'Virginica'
     'Virginica' 'Versicolor' 'Versicolor' 'Setosa' 'Virginica' 'Versicolor'
     'Setosa' 'Versicolor' 'Virginica' 'Virginica' 'Virginica' 'Setosa'
     'Versicolor' 'Virginica' 'Versicolor' 'Versicolor' 'Versicolor'
     'Versicolor' 'Virginica' 'Versicolor' 'Versicolor' 'Setosa' 'Virginica'
     'Versicolor' 'Virginica' 'Versicolor' 'Versicolor' 'Versicolor' 'Setosa'
     'Setosa' 'Setosa' 'Setosa' 'Versicolor']
    ['Setosa']


    C:\ProgramData\Anaconda3\lib\site-packages\sklearn\model_selection\_split.py:2179: FutureWarning: From version 0.21, test_size will always complement train_size unless both are specified.
      FutureWarning)
    C:\ProgramData\Anaconda3\lib\site-packages\sklearn\utils\validation.py:761: DataConversionWarning: A column-vector y was passed when a 1d array was expected. Please change the shape of y to (n_samples, ), for example using ravel().
      y = column_or_1d(y, warn=True)


### MNIST DATA

훈련 데이터 갯수에 따른 정확도


```python
# V1. MNist binary 데이터 읽어서 CSV로 만들기
import struct
def to_csv(name, maxdata):
    lbl_f = open("mnist/" + name + "-labels.idx1-ubyte", "rb")
    img_f = open("mnist/" + name + "-images.idx3-ubyte", "rb")
    csv_f = open("mnist/" + name + ".csv", "w", encoding="utf-8")

    mag, lbl_count = struct.unpack(">II", lbl_f.read(8))
    mag, img_count = struct.unpack(">II", img_f.read(8))
    rows, cols = struct.unpack(">II", img_f.read(8))
    pixels = rows * cols

    res = []
    for idx in range(lbl_count):
        if idx > maxdata:
            break
        label = struct.unpack("B", lbl_f.read(1))[0]
        bdata = img_f.read(pixels)
        sdata = list(map(lambda n: str(n), bdata))
        csv_f.write(str(label)+",")
        csv_f.write(",".join(sdata)+"\r\n")

    csv_f.close()
    lbl_f.close()
    img_f.close()

# 시간 체크
import time
start = time.time()
#to_csv("train", 70000) # 원하는 개수를 적는다. 최대 6만 이므로 6만보다 크면 모두 처리됨.
to_csv("t10k", 10000)

end = (time.time()-start)
print( "{0:.2f}".format(end ), ' 초 소요됨.')

```

    2.10  초 소요됨.



```python
# V2. MNIST CSV 불러오기
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
import pandas as pd

def changeValue(lst):
    return [float(v) / 255 for v in lst]
```


```python
# 0. 데이터 준비
csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/train_1K.csv')
train_data =csv.iloc[:,1:].values
train_data = list(map(changeValue, train_data))
train_label = csv.iloc[:,0].values

csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/t10k_0.5K.csv')
test_data =csv.iloc[:,1:].values
test_data = list(map(changeValue, test_data))
test_label = csv.iloc[:,0].values

# 1. 알고리즘
clf = svm.NuSVC(gamma="auto")

# 2. 훈련
clf.fit(train_data, train_label)
# 이번버전은 label에 문자를 안받았음 
# predict에 0~1사이 값이 입력되어야한다.

# 3. 검증
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Acc: {0:.2f}%".format(score*100))

print(result)

# # 사진확인
# import matplotlib.pyplot as plt
# import numpy as np
# img = np.array(test_data[0]).reshape(28,28)
# plt.imshow(img, cmap='gray')
# plt.show()
```

    Acc: 84.40%
    [2 1 0 4 1 4 9 2 9 0 2 9 0 1 5 9 7 5 4 9 6 4 5 4 0 7 4 0 1 3 1 3 4 7 2 7 1
     2 1 1 7 4 1 3 5 1 2 4 4 6 3 5 5 2 0 4 1 9 5 7 8 9 2 7 9 2 4 3 0 7 0 2 7 1
     7 3 7 9 7 9 6 2 7 8 4 7 5 6 1 3 6 9 3 1 4 1 7 6 9 6 0 5 4 9 9 2 1 9 4 8 1
     3 9 7 4 4 4 9 7 5 4 7 6 7 9 0 5 8 5 6 6 5 7 8 1 0 1 6 4 6 7 3 1 7 1 8 2 0
     4 9 4 5 5 1 5 6 0 3 9 4 6 5 4 6 5 4 5 1 4 4 7 3 3 2 1 1 8 1 8 1 8 5 0 8 9
     2 5 0 1 1 1 0 9 0 1 1 6 4 2 3 6 1 1 1 3 9 5 2 9 4 9 9 1 9 0 3 5 5 5 7 2 2
     7 1 2 8 4 1 7 5 3 8 9 7 7 2 2 4 1 5 3 8 4 1 5 0 6 4 1 9 1 9 5 7 7 2 8 2 0
     8 1 7 7 9 1 8 1 5 0 3 0 1 9 9 4 1 8 2 1 2 9 7 5 9 2 6 4 1 5 4 2 9 2 0 4 0
     0 2 8 1 7 1 2 9 0 2 7 4 5 3 0 0 5 1 9 6 5 3 5 1 7 9 3 5 9 2 0 7 1 1 1 1 5
     3 3 9 7 0 6 5 4 1 3 8 1 0 8 1 7 1 5 0 6 1 8 5 1 7 9 4 6 7 1 5 0 6 5 6 3 7
     2 0 8 8 5 9 1 1 4 0 7 3 7 6 1 6 2 1 9 2 8 6 1 9 5 2 5 4 4 2 8 3 9 2 4 0 0
     3 1 7 7 3 7 9 7 1 9 2 1 4 2 9 2 0 4 9 1 4 8 1 8 4 4 9 7 8 3 7 6 0 0 3 5 8
     0 6 4 8 5 3 3 2 3 9 1 1 5 8 0 9 4 6 6 7 8 8 2 9 5 8 9 6 1 8 4 1 2 5 3 1 9
     7 7 4 0 9 9 9 1 0 5 2 3 7 2 9 1 0 6 3]



```python
# V3. 데이터를 전처리해서 훈련하기
# V2. MNIST CSV 불러오기
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
import pandas as pd
import math

def changeValue(lst):
    return [ math.ceil((float(v)-5) / 255) for v in lst] # 튜닝도 가능

csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/train_10K.csv')
train_data =csv.iloc[:,1:].values
train_data = list(map(changeValue, train_data))
train_label = csv.iloc[:,0].values

csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/t10k_0.5K.csv')
test_data =csv.iloc[:,1:].values
test_data = list(map(changeValue, test_data))
test_label = csv.iloc[:,0].values

# 1. 알고리즘
clf = svm.SVC(gamma="auto")

# 2. 훈련
clf.fit(train_data, train_label)
# 이번버전은 label에 문자를 안받았음 
# predict에 0~1사이 값이 입력되어야한다.

# 3. 검증
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Acc: {0:.2f}%".format(score*100))

print(result)
```




    SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
      decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
      max_iter=-1, probability=False, random_state=None, shrinking=True,
      tol=0.001, verbose=False)



### 모델 저장


```python
import joblib
joblib.dump(clf,'mnist_model_1K.dmp') # 파이썬에서만 사용 가능, 파일 통째로 저장. 
print("저장완료")
```

    저장완료


### 모델 로드


```python
# V3. 데이터를 전처리해서 훈련하기
# V2. MNIST CSV 불러오기
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
import pandas as pd
import math

def changeValue(lst):
    return [ math.ceil((float(v)-5) / 255) for v in lst] # 튜닝도 가능

# csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/train_10K.csv')
# train_data =csv.iloc[:,1:].values
# train_data = list(map(changeValue, train_data))
# train_label = csv.iloc[:,0].values


csv = pd.read_csv('C:/Users/user/Desktop/GIT/mnist/t10k_0.5K.csv')
test_data =csv.iloc[:,1:].values
test_data = list(map(changeValue, test_data))
test_label = csv.iloc[:,0].values

# 1. 알고리즘
# clf = svm.SVC(gamma="auto")
clf = joblib.load('mnist_model_1K.dmp')

# 2. 훈련
# clf.fit(train_data, train_label)
# 이번버전은 label에 문자를 안받았음 
# predict에 0~1사이 값이 입력되어야한다.

# 3. 검증
result = clf.predict(test_data)
score = metrics.accuracy_score(result, test_label)
print("Acc: {0:.2f}%".format(score*100))

print(result)
```

    Acc: 93.40%
    [2 1 0 4 1 4 9 6 9 0 6 9 0 1 5 9 7 3 4 9 6 6 5 4 0 7 4 0 1 3 1 3 4 7 2 7 1
     2 1 1 7 4 2 3 5 1 2 4 4 6 3 5 5 6 0 4 1 9 5 7 8 9 3 7 4 2 4 3 0 7 0 2 7 1
     7 3 7 9 7 7 6 2 7 8 4 7 3 6 1 3 6 9 3 1 4 1 7 6 9 6 0 5 4 9 9 2 1 9 4 8 7
     3 9 7 4 4 4 9 2 5 4 7 6 7 9 0 5 8 5 6 6 5 7 8 1 0 1 6 4 6 7 3 1 7 1 8 2 0
     4 9 8 5 5 1 5 6 0 3 4 4 6 5 4 6 5 4 5 1 4 4 7 2 3 2 7 1 8 1 8 1 8 5 0 8 9
     2 5 0 1 1 1 0 9 0 5 1 6 4 2 3 6 1 1 1 3 9 5 2 9 4 5 9 3 9 0 3 5 5 5 7 2 2
     7 1 2 8 4 1 7 3 3 8 9 7 9 2 2 4 1 5 8 8 7 2 6 0 2 4 2 4 1 9 5 7 7 2 8 2 0
     8 5 7 7 9 1 8 1 8 0 3 0 1 9 9 4 1 8 2 1 2 9 7 5 9 2 6 4 1 5 4 2 9 2 0 4 0
     0 2 8 4 7 1 2 4 0 2 9 4 3 3 0 0 5 1 9 6 5 3 5 7 7 9 3 5 4 2 0 7 1 1 2 1 5
     3 3 9 7 8 6 3 4 1 3 8 1 0 5 1 7 1 5 0 6 1 8 5 1 7 9 4 6 7 2 5 0 6 5 6 3 7
     2 0 8 8 5 4 1 1 4 0 7 3 7 6 1 6 2 1 9 2 8 6 1 9 5 2 5 4 4 2 8 3 8 2 4 0 0
     3 1 7 7 3 7 9 7 1 9 2 1 4 2 9 2 0 4 9 1 4 8 1 8 4 5 9 8 8 3 7 6 0 0 3 0 8
     0 6 4 8 3 3 3 2 3 9 1 2 6 8 0 5 6 6 6 3 8 8 2 2 5 8 9 6 1 8 4 1 2 5 3 1 9
     7 5 4 0 8 9 9 1 0 5 2 3 7 8 9 4 0 6 3]


## GUI 활용 


```python
from tkinter import *
from tkinter.simpledialog import *
from tkinter.filedialog import *
import math
import os
import os.path
from PIL import Image, ImageFilter, ImageEnhance, ImageOps
import time
import matplotlib.pyplot as plt
import numpy as np
from sklearn import svm, metrics
from sklearn.model_selection import train_test_split
import pandas as pd
import math
import joblib


def changeValue(lst):
    return [ math.ceil((float(v)-5) / 255) for v in lst] # 튜닝도 가능

def studyCSV():
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    
    # 훈련용 csv파일 불러오기 (mnist)
    filename = askopenfilename(parent=window,
                               filetypes=(("csv 파일", "*.csv"), ("모든 파일", "*.*")))
    if filename == '' or filename == None:
        return
    
    csv = pd.read_csv(filename)
    train_data =csv.iloc[:,1:].values
    train_data = list(map(changeValue, train_data))
    train_label = csv.iloc[:,0].values

    # 훈련
    clf = svm.SVC(gamma="auto")
    clf.fit(train_data, train_label)
    
    status.configure(text="훈련성공")
    
def loadDump():
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    filename = askopenfilename(parent=window,
                               filetypes=(("dmp 파일", "*.dmp"), ("모든 파일", "*.*")))
    if filename == '' or filename == None:
        return
    
    clf = joblib.load(filename)
    print(filename)

def saveDump():
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    saveFp = asksaveasfile(parent = window, mode='wb', defaultextension='.', filetypes=(("dmp 파일", "*.dmp"),("모든파일", "*.*")))
    if saveFp == "" or saveFp == None:
        return
    joblib.dump(clf,saveFp)
    status.configure(text="저장성공")
    
def testScore():
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    
    filename = askopenfilename(parent=window,
                               filetypes=(("csv 파일", "*.csv"), ("모든 파일", "*.*")))
    if filename == '' or filename == None:
        return
    
    csv = pd.read_csv(filename)
    test_data = csv.iloc[:,1:].values
    test_data = list(map(changeValue, test_data))
    test_label = csv.iloc[:,0].values    
    
    result = clf.predict(test_data)
    score = metrics.accuracy_score(result, test_label)
    status.configure(text="정답률{0:.2f}%".format(score*100))

def predictMouse():
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    if clf == None:
        status.configure(text='모델부터 생성')    
    
    VIEW_X, VIEW_Y = 280, 280
    canvas = Canvas(window, height=VIEW_X, width = VIEW_Y, bg='black')
    paper = PhotoImage(height=VIEW_X, width=VIEW_Y)
    canvas.create_image((VIEW_Y//2, VIEW_X//2), image=paper, state='normal')
    
    canvas.pack(expand=1, anchor=CENTER)
    status.configure(text='')
    
    # 마우스 이벤트
    canvas.bind('<Button-3>', rightMouseClick)
    canvas.bind('<Button-2>', midMouseClick) 
    canvas.bind('<Button-1>', leftMouseClick) 
    canvas.bind('<B1-Motion>', leftMouseMove) 
    canvas.bind('<ButtonRelease-1>', leftMouseDrop) 
    canvas.configure(cursor='mouse')
    
def rightMouseClick(event):
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    global leftMousePressYN
    inImage = malloc(280,280)
    # paper --> inImage로 가져오기
    for i in range(280):
        for k in range(280):
            pixel = paper.get(k,i) # return (r, g, b)
            if pixel[0] == 0 :
                inImage[i][k] = 0
            else:
                inImage[i][k] = 1
    # 280 -> 28 축소
    outImage = []
    outImage = malloc(28,28)
    scale = 10
    for i in range(28):
        for k in range(28):
            outImage[i][k] = inImage[i * scale][k * scale]
    # 2차원 -> 1차원
    my_data = []
    for i in range(28):
        for k in range(28):
            my_data.append(outImage[i][k])
    # 예측하기 
    result = clf.predict([my_data])
    status.configure(text=str(result[0]))

    
def malloc(h, w, initValue=0):
    retMemory = np.array([[initValue]*w]*h)
    return retMemory
    
def midMouseClick(event):
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    global leftMousePressYN
    outH, outW = 280, 280
    step = 1
    rgbStr = ''
    for i in np.arange(0, outH, step):
        tmpStr = ''
        for k in np.arange(0, outW, step):
            i = int(i);
            k = int(k)
            r, g, b = 0,0,0
            tmpStr += ' #%02x%02x%02x' % (r, g, b)
        rgbStr += '{' + tmpStr + '} '
    paper.put(rgbStr)

leftMousePressYN = False # 마우스 눌린상태 확인을 위한 플래그
def leftMouseClick(event): 
    global leftMousePressYN
    leftMousePressYN = True
    
def leftMouseMove(event):
    global csv, train_data, train_labe, test_data, test_label, clf
    global inImage, outImage, inH, inW, outH, outW, window, canvas, paper
    global leftMousePressYN
    if leftMousePressYN == False:
        return
    x = event.x
    y = event.y
    # 주위 40x40개를 찍는다.
    for i in range(-22, 22, 1):
        for k in range(-22, 22, 1):
            if 0 <= x+i < 280 and 0 <= y+k < 280:
                paper.put("#%02x%02x%02x" % (255,255,255), (x+i, y+k))
            
    

def leftMouseDrop(event):
    global leftMousePressYN
    leftMousePressYN = False

####################
#### 전역변수 선언부 ####
####################
R, G, B = 0, 1, 2
inImage, outImage = [], []  # 3차원 리스트(배열)
inH, inW, outH, outW = [0] * 4
window, canvas, paper = None, None, None
filename = ""
VIEW_X, VIEW_Y = 512, 512  # 화면에 보일 크기 (출력용)
## ML관련 전역변수
csv, train_data, train_labe, test_data, test_label, clf = [None]*6



####################
#### 메인 코드부 ####
####################
window = Tk()
window.geometry("500x500")
window.title("머신러닝 툴 (mnist) ver 2.0")

status = Label(window, text='필요할때 써먹기', bd=1, relief=SUNKEN, anchor=W)
status.pack(side=BOTTOM, fill=X)


## 마우스 이벤트

mainMenu = Menu(window)
window.config(menu=mainMenu)

fileMenu = Menu(mainMenu)
mainMenu.add_cascade(label="학습시키기", menu=fileMenu)    
fileMenu.add_command(label="CSV 파일로 새로학습", command=studyCSV)                    
fileMenu.add_separator()
fileMenu.add_command(label="학습된 모델 가져오기", command=loadDump)
fileMenu.add_command(label="정확도 확인하기", command=testScore)
fileMenu.add_command(label="학습된 모델 저장하기", command=saveDump)

predictMenu = Menu(mainMenu)
mainMenu.add_cascade(label="예측하기", menu=predictMenu)
predictMenu.add_command(label="그림 파일 불러오기", command=None)
predictMenu.add_command(label="마우스로 그리기", command=predictMouse)
#comVisionMenu1.add_command(label="반전하기", command=revImageColor)
#comVisionMenu1.add_command(label="파라볼라", command=paraImageColor)
#comVisionMenu1.add_separator()
window.mainloop()
```

# 2. Pandas
### 중요 용어 2가지
- DataFrame : 한개의 Table
- Series : 한개의 column


```python
import pandas as pd
```


```python
df = pd.read_csv("C:/BigData/00Data1/csv/01_data.csv")

# Column 참조
#print(df.Name, type(df.Name))
#df.Name == df['Name'] # SELECT * FROM TABLE과 같다.
#df[ ['Name', 'Country'] ] # 2개 이상은 데이터프레임, 1개는 시리즈

# Row 참조
#df.loc[0] # 한개 - index
#df.loc[[0,3]] # 여러개 - index
#df.loc[2:5:1] # 여러개 - slicing
df.iloc[:,0:-1]
df.loc[:,0:]

# Group_by
#df.groupby('Country')['Age'].mean()
```


    ---------------------------------------------------------------------------
    
    TypeError                                 Traceback (most recent call last)
    
    <ipython-input-45-40b1c0841899> in <module>
         11 #df.loc[2:5:1] # 여러개 - slicing
         12 df.iloc[:,0:-1]
    ---> 13 df.loc[:,0:]
         14 
         15 # Group_by


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexing.py in __getitem__(self, key)
       1492             except (KeyError, IndexError, AttributeError):
       1493                 pass
    -> 1494             return self._getitem_tuple(key)
       1495         else:
       1496             # we by definition only have the 0th axis


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexing.py in _getitem_tuple(self, tup)
        886                 continue
        887 
    --> 888             retval = getattr(retval, self.name)._getitem_axis(key, axis=i)
        889 
        890         return retval


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexing.py in _getitem_axis(self, key, axis)
       1865         if isinstance(key, slice):
       1866             self._validate_key(key, axis)
    -> 1867             return self._get_slice_axis(key, axis=axis)
       1868         elif com.is_bool_indexer(key):
       1869             return self._getbool_axis(key, axis=axis)


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexing.py in _get_slice_axis(self, slice_obj, axis)
       1531         labels = obj._get_axis(axis)
       1532         indexer = labels.slice_indexer(slice_obj.start, slice_obj.stop,
    -> 1533                                        slice_obj.step, kind=self.name)
       1534 
       1535         if isinstance(indexer, slice):


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexes\base.py in slice_indexer(self, start, end, step, kind)
       4671         """
       4672         start_slice, end_slice = self.slice_locs(start, end, step=step,
    -> 4673                                                  kind=kind)
       4674 
       4675         # return a slice


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexes\base.py in slice_locs(self, start, end, step, kind)
       4870         start_slice = None
       4871         if start is not None:
    -> 4872             start_slice = self.get_slice_bound(start, 'left', kind)
       4873         if start_slice is None:
       4874             start_slice = 0


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexes\base.py in get_slice_bound(self, label, side, kind)
       4796         # For datetime indices label may be a string that has to be converted
       4797         # to datetime boundary according to its resolution.
    -> 4798         label = self._maybe_cast_slice_bound(label, side, kind)
       4799 
       4800         # we need to look up the label


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexes\base.py in _maybe_cast_slice_bound(self, label, side, kind)
       4748         # this is rejected (generally .loc gets you here)
       4749         elif is_integer(label):
    -> 4750             self._invalid_indexer('slice', label)
       4751 
       4752         return label


    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\indexes\base.py in _invalid_indexer(self, form, key)
       3065                         "indexers [{key}] of {kind}".format(
       3066                             form=form, klass=type(self), key=key,
    -> 3067                             kind=type(key)))
       3068 
       3069     # --------------------------------------------------------------------


    TypeError: cannot do slice indexing on <class 'pandas.core.indexes.base.Index'> with these indexers [0] of <class 'int'>


