a <- c(3,2,1)

lgl_v <- c(T, F, TRUE, FALSE)
#알스크립트 작성영역
print('hi')
print('h20135')
#ctrl + enter
#ctrl + L
#History 탭 -> enter or Shift + enter

print('hi')
print('hi')
print('hi')
print('hi')

print('h2')
print('h2')
#알스크립트 작성영역
print('hi')

#help
#print {base} : 함수명{패키지명}
#install.packages("randomForest")

library(randomForest)

#NA:(값이 없음)

one<-70
two<-80
three<-90
four<-NA
#NA와 함께 연산하면 결과가 NA가 나오기 때문에 어떻게든 처리를 해 주어야 한다.

is.na(four)

#NULL : 변수가 초기화되지 않은 상태
#x<-NULL
# if(조건){
#  x<-TRUE
# }
# else{
#  x<-FALSE
# }

TRUE & FALSE

# & | ! 

# factor 자료형 : 카테고리 -> 데이터가 사전에 정해진 유형으로만 분류되는 경우. (ex, 학점)

gender<-factor(NA,c("m","f"))
#초기값 설정
#c함수 : 팩터안에 어떤 값이 들어 갈 수 있는지. 

