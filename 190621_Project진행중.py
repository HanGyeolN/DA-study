import sys
from PyQt5.QtWidgets import *
from PyQt5 import uic
from PyQt5.QtGui import *
import numpy as np
import PIL
# pip install pillow numpy PyQt5 
# Anaconda/Library/bin/qt_designer.exe
# ui파일 저장경로

# Issue 1. QT 디자인 

UIPath = "C:/BigData/qt_design_test.ui"

form_class = uic.loadUiType(UIPath)[0]

class MyWindow(QMainWindow, form_class):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.actionOpenImage.triggered.connect(self.openFile)
        self.actionBrightnessControl.triggered.connect(self.brightnessControl)
        

    def openFile(self):
        # 이미지파일 경로 받기
        filename =  QFileDialog.getOpenFileName()
        print(filename)

        # 이미지파일 -> QPixmap
        self.pixmap = QPixmap(filename[0])
        print(self.pixmap)

        width = self.pixmap.width()
        height = self.pixmap.height()
        print(width, height)

        # QPixmap -> QImage : 픽셀값 받아오기
        img = self.pixmap.toImage()

        # 실습처럼 input Image에 numpy 배열로 넣기
        channel = 3
        self.inputImage = np.zeros((channel,width,height))

        for r in range(height):
            for c in range(width):
                val = img.pixel(r,c)
                # pixmap -> image -> pixel -> rgb
                colors = QColor(val).getRgbF()
                
                for RGB in range(channel):
                    self.inputImage[RGB,r,c] = int(colors[RGB]*255)
                
                #print ("(%s,%s) = %s" % (r, c, inputImage[:,r,c]))
        #############################################################

        # label에 pixmap 출력
        self.label.setPixmap(self.pixmap)
        
    # 메뉴 - 밝기조절 알고리즘
    def brightnessControl(self):
        # 1. 얼마나 조절할지 입력받기
        print(np.mean(self.inputImage))
        intValue = QInputDialog.getInt(self,"test", "brightness")
        print(intValue)

        # 2. 브로드캐스팅
        self.outputImage = self.inputImage + intValue[0]

        # 3. 예외처리
        self.outputImage = np.where(self.outputImage > 255, 255, np.where(self.outputImage < 0 , 0, self.outputImage))
        
        print(np.mean(self.inputImage))
        print(self.inputImage)

        # 4. output Pixmap 생성
        width = self.pixmap.width()
        height = self.pixmap.height()
        
        color = QColor()
        outputPixmap = QImage()
        for r in range(height):
            for c in range(widht):
                # rgb -> pixel -> image -> pixmap
                color.setRgbF(self.outputImage[0][r][c]/255, self.outputImage[1][r][c]/255, self.outputImage[2][r][c]/255)
                outputPixmap.setPixelColor(r, c, color)
#########################3 여기 수정중 ###########



                val = img.pixel(r,c)
                colors = QColor(val).getRgbF()
                
                for RGB in range(channel):
                    self.inputImage[RGB,r,c] = int(colors[RGB]*255)
        
        

        self.label_4.setPixmap(pixmap)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    myWindow = MyWindow()
    myWindow.show()
    app.exec_()