R Notebook
================

length는 list의 길이를 반환한다.

seq(5,10)은 int vector를 반환하는데 as.list(seq(5,10))은 list로 변환해준다

list의 값을 참조할땐 대괄호 두개를 써야한다.

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidytext)
library(tidyr)
a<-list(1,2,3)
e<-as.list(seq(5,10))

e[[5]]<-99
e
```

    ## [[1]]
    ## [1] 5
    ## 
    ## [[2]]
    ## [1] 6
    ## 
    ## [[3]]
    ## [1] 7
    ## 
    ## [[4]]
    ## [1] 8
    ## 
    ## [[5]]
    ## [1] 99
    ## 
    ## [[6]]
    ## [1] 10

list에서 특정 자료를 삭제할땐 NULL을 집어 넣어주면 된다.

``` r
c<-as.list(seq(1,3))
c
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 2
    ## 
    ## [[3]]
    ## [1] 3

``` r
c[[1]]<-NULL
c
```

    ## [[1]]
    ## [1] 2
    ## 
    ## [[2]]
    ## [1] 3

subset을 이용해 특정 범위에 있는 자료를 가져 올 수 있다.

``` r
d<-as.list(seq(20))
d[10:15]
```

    ## [[1]]
    ## [1] 10
    ## 
    ## [[2]]
    ## [1] 11
    ## 
    ## [[3]]
    ## [1] 12
    ## 
    ## [[4]]
    ## [1] 13
    ## 
    ## [[5]]
    ## [1] 14
    ## 
    ## [[6]]
    ## [1] 15

``` r
a<-c(1,2,3)
```

``` r
a<-c(1,2,3)
length(a)
```

    ## [1] 3

``` r
dim(a)
```

    ## NULL

vector Indexing

``` r
a[1:2]
```

    ## [1] 1 2

``` r
a[1]
```

    ## [1] 1

``` r
a[[1]]
```

    ## [1] 1

``` r
a<-rbind(1:4,6:9)
a
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    6    7    8    9

8을 참조하여 출력

``` r
a[]
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    6    7    8    9

``` r
a[1,]
```

    ## [1] 1 2 3 4

``` r
a[,2]
```

    ## [1] 2 7

``` r
a[2,2:4]
```

    ## [1] 7 8 9

``` r
a[1:2,3:4]
```

    ##      [,1] [,2]
    ## [1,]    3    4
    ## [2,]    8    9

``` r
a[2,3]
```

    ## [1] 8

``` r
a[[2,3]]
```

    ## [1] 8

특정요소 제거하기

``` r
a<-1:10
a
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
a[-5]
```

    ## [1]  1  2  3  4  6  7  8  9 10

``` r
a[-1]
```

    ## [1]  2  3  4  5  6  7  8  9 10

``` r
a
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
b<-a[-7:-9]
```

TF를 이용한 참조방식

``` r
bl<-c(T,F,T,T)
k<-1:4
k[bl] 
```

    ## [1] 1 3 4

변수 초기화시 유용한 함수

``` r
k<-k*10
k
```

    ## [1] 10 20 30 40

``` r
rep(NA,10)
```

    ##  [1] NA NA NA NA NA NA NA NA NA NA

``` r
seq(0,100,length.out = 4)
```

    ## [1]   0.00000  33.33333  66.66667 100.00000

``` r
set.seed(1)
# normal distribution
rnorm(10) # 가우시안 정규분포를 따르는 난수 
```

    ##  [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078 -0.8204684
    ##  [7]  0.4874291  0.7383247  0.5757814 -0.3053884

``` r
# 
runif(10) # 구간을 나누어서 균등하게 분포/ 균등분포
```

    ##  [1] 0.93470523 0.21214252 0.65167377 0.12555510 0.26722067 0.38611409
    ##  [7] 0.01339033 0.38238796 0.86969085 0.34034900

``` r
matrix(rnorm(10),c(2,5))
```

    ##             [,1]      [,2]      [,3]       [,4]       [,5]
    ## [1,] -0.04493361 0.9438362 0.5939013 0.78213630 -1.9893517
    ## [2,] -0.01619026 0.8212212 0.9189774 0.07456498  0.6198257

시간측정 proc.time() : R에서 시간 측정할때 사용 (cpu가 걸리는 시간)

``` r
x<-1:10000
y<-10001:20000
startTime<-proc.time()
z<-rep(0,10000)
for (i in 1:10000){
  z[i]<-x[i]+y[i]
}
endTime<-proc.time()

endTime-startTime
```

    ##    user  system elapsed 
    ##    0.01    0.00    0.01

a==b 요소끼리비교 all(a==b) 배열전체 비교

``` r
a<-c(0,1,2,3)
b<-c(4,2,1,0)
a==b
```

    ## [1] FALSE FALSE FALSE FALSE

``` r
all(a==b)
```

    ## [1] FALSE

natural function

``` r
exp(a)
```

    ## [1]  1.000000  2.718282  7.389056 20.085537

``` r
log(a)
```

    ## [1]      -Inf 0.0000000 0.6931472 1.0986123

Broad casting

``` r
x<-1:5
y<-rep(1,length(x))
x+y
```

    ## [1] 2 3 4 5 6

``` r
x+rep(2,5)
```

    ## [1] 3 4 5 6 7

``` r
x+2
```

    ## [1] 3 4 5 6 7

which.max -\> return index

``` r
x<-50:59
which.max(x)
```

    ## [1] 10

``` r
x<-matrix(c(10,20,10,20),nrow=2)


sum(x[1:2,1])
```

    ## [1] 30

``` r
set.seed(123)
df<-data.frame(k1=c("x","x","y","y","x"),
               k2=c("f","s","f","s","f"),
               d1=rnorm(5),
               d2=rnorm(5))
```

group\_by - summarise 는 같이 쓰이는게 일반적.

``` r
summarise(group_by(df, k1), myMean = mean(d1))
```

    ## # A tibble: 2 x 2
    ##   k1    myMean
    ##   <fct>  <dbl>
    ## 1 x     -0.220
    ## 2 y      0.815

``` r
summarise(group_by(df, k1,k2), myMean = mean(d1))
```

    ## # A tibble: 4 x 3
    ## # Groups:   k1 [2]
    ##   k1    k2     myMean
    ##   <fct> <fct>   <dbl>
    ## 1 x     f     -0.216 
    ## 2 x     s     -0.230 
    ## 3 y     f      1.56  
    ## 4 y     s      0.0705

tidyr package : 데이터를 깔끔하게 정리하는 도구 - spread() : pivot table

``` r
group_by(df, k1, k2) %>% 
  summarise(myMean = mean(d1)) ->
  exData01

exData01
```

    ## # A tibble: 4 x 3
    ## # Groups:   k1 [2]
    ##   k1    k2     myMean
    ##   <fct> <fct>   <dbl>
    ## 1 x     f     -0.216 
    ## 2 x     s     -0.230 
    ## 3 y     f      1.56  
    ## 4 y     s      0.0705

``` r
spread(exData01, k1, myMean)
```

    ## # A tibble: 2 x 3
    ##   k2         x      y
    ##   <fct>  <dbl>  <dbl>
    ## 1 f     -0.216 1.56  
    ## 2 s     -0.230 0.0705

``` r
spread(exData01, k2, myMean)
```

    ## # A tibble: 2 x 3
    ## # Groups:   k1 [2]
    ##   k1         f       s
    ##   <fct>  <dbl>   <dbl>
    ## 1 x     -0.216 -0.230 
    ## 2 y      1.56   0.0705

join, merge

merge : 두 프레임의 공통 key를 사용 join :

``` r
df1<-data.frame(k=c('b','b','a','c','a','a','b'),
                d1=0:6)
df2<-data.frame(k=c('a','b','d'),
                d2=0:2)
df1
```

    ##   k d1
    ## 1 b  0
    ## 2 b  1
    ## 3 a  2
    ## 4 c  3
    ## 5 a  4
    ## 6 a  5
    ## 7 b  6

``` r
df2
```

    ##   k d2
    ## 1 a  0
    ## 2 b  1
    ## 3 d  2

``` r
# 공통 key값을 기준으로 병합
merge(df1,df2) 
```

    ##   k d1 d2
    ## 1 a  2  0
    ## 2 a  4  0
    ## 3 a  5  0
    ## 4 b  0  1
    ## 5 b  1  1
    ## 6 b  6  1

``` r
# -> c,d는 공통값이 없어져서 사라짐

merge(df1,df2, all=T)
```

    ##   k d1 d2
    ## 1 a  2  0
    ## 2 a  4  0
    ## 3 a  5  0
    ## 4 b  0  1
    ## 5 b  1  1
    ## 6 b  6  1
    ## 7 c  3 NA
    ## 8 d NA  2

``` r
# -> 사라지지 않도록 옵션

merge(df1,df2, all.x=T)
```

    ##   k d1 d2
    ## 1 a  2  0
    ## 2 a  4  0
    ## 3 a  5  0
    ## 4 b  0  1
    ## 5 b  1  1
    ## 6 b  6  1
    ## 7 c  3 NA

``` r
# -> df1에 있는 모든 key를 나오게함 
```
