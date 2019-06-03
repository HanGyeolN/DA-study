Sentiment Analysis
================

## Exercise

#### 1\. Sentiment library

``` r
AFINN<-data.frame(get_sentiments("afinn"))

#hist(AFINN$score, xlim = c(-6,6), ylim = c(0,600), col="#30AADF", breaks=14)

oplex<-data.frame(get_sentiments("bing"))
table(oplex$sentiment)
```

    ## 
    ## negative positive 
    ##     4782     2006

``` r
emolex<-data.frame(get_sentiments("nrc"))
table(emolex$sentiment)
```

    ## 
    ##        anger anticipation      disgust         fear          joy 
    ##         1247          839         1058         1476          689 
    ##     negative     positive      sadness     surprise        trust 
    ##         3324         2312         1191          534         1231

``` r
emolex$word[emolex$sentiment=="anger"]
```

#### 2\. Join Exercise

``` r
#creating dataframe1
pd=data.frame(Name=c("Senthil","Senthil","Sam","Sam"),
              Month=c("Jan","Feb","Jan","Feb"),
              BS = c(141.2,139.3,135.2,160.1),
              BP = c(90,78,80,81))
print(pd)
```

    ##      Name Month    BS BP
    ## 1 Senthil   Jan 141.2 90
    ## 2 Senthil   Feb 139.3 78
    ## 3     Sam   Jan 135.2 80
    ## 4     Sam   Feb 160.1 81

``` r
#creating dataframe2
pd_new=data.frame(Name=c("Senthil","Ramesh","Sam"),Department=c("PSE","Data Analytics","PSE"))
print(pd_new) 
```

    ##      Name     Department
    ## 1 Senthil            PSE
    ## 2  Ramesh Data Analytics
    ## 3     Sam            PSE

#### 2-1. left\_join

  - 왼쪽을 base로 join한다

``` r
print(left_join(pd, pd_new, by="Name"))
```

    ## Warning: Column `Name` joining factors with different levels, coercing to
    ## character vector
    
    ##      Name Month    BS BP Department
    ## 1 Senthil   Jan 141.2 90        PSE
    ## 2 Senthil   Feb 139.3 78        PSE
    ## 3     Sam   Jan 135.2 80        PSE
    ## 4     Sam   Feb 160.1 81        PSE

``` r
print(right_join(pd,pd_new, by="Name"))
```

    ## Warning: Column `Name` joining factors with different levels, coercing to
    ## character vector
    
    ##      Name Month    BS BP     Department
    ## 1 Senthil   Jan 141.2 90            PSE
    ## 2 Senthil   Feb 139.3 78            PSE
    ## 3  Ramesh  <NA>    NA NA Data Analytics
    ## 4     Sam   Jan 135.2 80            PSE
    ## 5     Sam   Feb 160.1 81            PSE

``` r
print(inner_join(pd,pd_new, by="Name"))
```

    ## Warning: Column `Name` joining factors with different levels, coercing to
    ## character vector
    
    ##      Name Month    BS BP Department
    ## 1 Senthil   Jan 141.2 90        PSE
    ## 2 Senthil   Feb 139.3 78        PSE
    ## 3     Sam   Jan 135.2 80        PSE
    ## 4     Sam   Feb 160.1 81        PSE

# Sentiment Analysis

#### 1\. Load Corpus

``` r
my.text.location <- "C:/rwork/Data/papers/papers/"
mypaper <- VCorpus(DirSource(my.text.location))
#inspect(mypaper)

str(mypaper[[1]]) # structure 확인
```

    ## List of 2
    ##  $ content: chr "Does deliberative setting, online versus face-to-face, influence citizens' experiences? Are certain factors dif"| __truncated__
    ##  $ meta   :List of 7
    ##   ..$ author       : chr(0) 
    ##   ..$ datetimestamp: POSIXlt[1:1], format: "2019-05-28 06:12:46"
    ##   ..$ description  : chr(0) 
    ##   ..$ heading      : chr(0) 
    ##   ..$ id           : chr "p2009a.txt"
    ##   ..$ language     : chr "en"
    ##   ..$ origin       : chr(0) 
    ##   ..- attr(*, "class")= chr "TextDocumentMeta"
    ##  - attr(*, "class")= chr [1:2] "PlainTextDocument" "TextDocument"

``` r
mypaper[[1]][1] == mypaper[[1]]$content
```

    ## content 
    ##    TRUE

#### 2\. Vectorize Corpus

``` r
class(mypaper[[1]]$meta)
```

    ## [1] "TextDocumentMeta"

``` r
#str_length((mypaper[[1]][1])) = 24

mytxt<-rep(NA,24)
mytxt
```

    ##  [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ## [24] NA

``` r
for (i in 1:length(mypaper)){
  mytxt[i]<-as.character(mypaper[[i]][1])
}

mytxt[24]
```

    ## [1] "This study employs a cross-cultural perspective to examine how local audiences perceive and enjoy foreign dramas and how this psychological process differs depending on the cultural distance between the media and the viewing audience. Using a convenience sample of young Korean college students, this study, as predicted by cultural discount theory, shows that cultural distance decreases Korean audiences’ perceived identification with dramatic characters, which erodes their enjoyment of foreign dramas. Unlike cultural discount theory, however, cultural distance arouses Korean audiences’ perception of novelty, which heightens their enjoyment of foreign dramas. This study discusses the theoretical and practical implications of these findings, as well as their potential limitations."

#### 3\. Make tidytext

``` r
my.df.text<-data_frame(paper.id = 1:length(mypaper), 
                       doc = mytxt)
```

    ## Warning: `data_frame()` is deprecated, use `tibble()`.
    ## This warning is displayed once per session.

#### 4\. Split Word

``` r
my.df.text.word <-
  my.df.text %>% 
  unnest_tokens(word, doc) #doc을 word단위로
```

#### 5\. Join Sentiments & Word

``` r
print(class(my.df.text.word))
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
print(class(get_sentiments("bing")))
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
print(inner_join(my.df.text.word, get_sentiments("bing"), by="word"))
```

    ## # A tibble: 230 x 3
    ##    paper.id word        sentiment
    ##       <int> <chr>       <chr>    
    ##  1        1 influential positive 
    ##  2        1 enhanced    positive 
    ##  3        1 assure      positive 
    ##  4        2 harmful     negative 
    ##  5        2 effective   positive 
    ##  6        2 difficulty  negative 
    ##  7        2 correct     positive 
    ##  8        2 gain        positive 
    ##  9        2 easy        positive 
    ## 10        2 correct     positive 
    ## # ... with 220 more rows

#### 6\. Count Words & Make Pivot Table

``` r
print(my.df.text.word %>% 
        inner_join(get_sentiments("bing"), by="word") %>% 
        count(word, paper.id, sentiment) %>% 
        spread(sentiment, n, fill=0) ->
        myresult.sa)
```

    ## # A tibble: 164 x 4
    ##    word         paper.id negative positive
    ##    <chr>           <int>    <dbl>    <dbl>
    ##  1 achievements       10        0        1
    ##  2 advanced           11        0        1
    ##  3 affirmative         9        0        1
    ##  4 ambivalence         4        7        0
    ##  5 ambivalence         6        2        0
    ##  6 ambivalent         15        1        0
    ##  7 anger              23        3        0
    ##  8 anxious            15        1        0
    ##  9 assure              1        0        1
    ## 10 beneficial         13        0        1
    ## # ... with 154 more rows

#### 7\. Calculate Sentiment

``` r
myresult.sa %>% 
  group_by(paper.id) %>% 
  summarise(pos.sum = sum(positive),
            neg.sum = sum(negative),
            pos.sent = pos.sum-neg.sum)
```

    ## # A tibble: 23 x 4
    ##    paper.id pos.sum neg.sum pos.sent
    ##       <int>   <dbl>   <dbl>    <dbl>
    ##  1        1       3       0        3
    ##  2        2       5       3        2
    ##  3        3       3       2        1
    ##  4        4       6      16      -10
    ##  5        5       1       3       -2
    ##  6        6       1       6       -5
    ##  7        7       7       2        5
    ##  8        8       2       3       -1
    ##  9        9       7      11       -4
    ## 10       10      11       8        3
    ## # ... with 13 more rows

#### 8\. extra 파생변수 만들기

``` r
# 1. list.files로 논문 제목 받아오기 
print(myfilenames<-list.files(path=my.text.location, all.files = TRUE))
```

    ##  [1] "."          ".."         "p2009a.txt" "p2009b.txt" "p2010a.txt"
    ##  [6] "p2010b.txt" "p2010c.txt" "p2011a.txt" "p2011b.txt" "p2012a.txt"
    ## [11] "p2012b.txt" "p2013a.txt" "p2014a.txt" "p2014b.txt" "p2014c.txt"
    ## [16] "p2014d.txt" "p2014e.txt" "p2014f.txt" "p2014g.txt" "p2014h.txt"
    ## [21] "p2014i.txt" "p2014k.txt" "p2015a.txt" "p2015b.txt" "p2015c.txt"
    ## [26] "p2015d.txt"

``` r
paper.name<-myfilenames[3:26]

# 2. 논문 제목에서 년도 추출하기 
print(pub.year<-unlist(str_extract_all(paper.name,"[0-9]{1,}")))
```

    ##  [1] "2009" "2009" "2010" "2010" "2010" "2011" "2011" "2012" "2012" "2013"
    ## [11] "2014" "2014" "2014" "2014" "2014" "2014" "2014" "2014" "2014" "2014"
    ## [21] "2015" "2015" "2015" "2015"

``` r
# 3. 논문 제목과 년도 Join하기
paper.id<-1:24
print(pub.tear.df<-data.frame(paper.id, paper.name, pub.year))
```

    ##    paper.id paper.name pub.year
    ## 1         1 p2009a.txt     2009
    ## 2         2 p2009b.txt     2009
    ## 3         3 p2010a.txt     2010
    ## 4         4 p2010b.txt     2010
    ## 5         5 p2010c.txt     2010
    ## 6         6 p2011a.txt     2011
    ## 7         7 p2011b.txt     2011
    ## 8         8 p2012a.txt     2012
    ## 9         9 p2012b.txt     2012
    ## 10       10 p2013a.txt     2013
    ## 11       11 p2014a.txt     2014
    ## 12       12 p2014b.txt     2014
    ## 13       13 p2014c.txt     2014
    ## 14       14 p2014d.txt     2014
    ## 15       15 p2014e.txt     2014
    ## 16       16 p2014f.txt     2014
    ## 17       17 p2014g.txt     2014
    ## 18       18 p2014h.txt     2014
    ## 19       19 p2014i.txt     2014
    ## 20       20 p2014k.txt     2014
    ## 21       21 p2015a.txt     2015
    ## 22       22 p2015b.txt     2015
    ## 23       23 p2015c.txt     2015
    ## 24       24 p2015d.txt     2015

``` r
# 4. 원래 결과에 Join
print(myresult.sa %>% 
        inner_join(pub.tear.df, by="paper.id"))
```

    ## # A tibble: 164 x 6
    ##    word         paper.id negative positive paper.name pub.year
    ##    <chr>           <int>    <dbl>    <dbl> <fct>      <fct>   
    ##  1 achievements       10        0        1 p2013a.txt 2013    
    ##  2 advanced           11        0        1 p2014a.txt 2014    
    ##  3 affirmative         9        0        1 p2012b.txt 2012    
    ##  4 ambivalence         4        7        0 p2010b.txt 2010    
    ##  5 ambivalence         6        2        0 p2011a.txt 2011    
    ##  6 ambivalent         15        1        0 p2014e.txt 2014    
    ##  7 anger              23        3        0 p2015c.txt 2015    
    ##  8 anxious            15        1        0 p2014e.txt 2014    
    ##  9 assure              1        0        1 p2009a.txt 2009    
    ## 10 beneficial         13        0        1 p2014c.txt 2014    
    ## # ... with 154 more rows

베이지안 RNN CNN GAN

