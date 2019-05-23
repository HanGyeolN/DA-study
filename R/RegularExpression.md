# Regular Expression

* regex, regexp



#### Split

```R
> mysentence<-"Learning R is so interesting"
> strsplit(mysentence, split=" ")
[[1]]
[1] "Learning"    "R"           "is"          "so"          "interesting"

strsplit(rWikiPara[[1]], split="\\. ") -> rWikiSent
strsplit(rWikiSent[[1]], split=" ") -> rWikiWord
strsplit(rWikiWord[[1]], split="") -> rWikiLett
```

* 문자열 쪼개기



#### Collapse

```R
> a<-c("a","b")
> a
[1] "a" "b"
> paste(a,collapse = "")
[1] "ab"
```

* 문자열 합치기

## regexpr

```R
> gregexpr('ing', mySent)
[[1]]
[1]  6 25
attr(,"match.length")
[1] 3 3
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
```

* 특정 문자열 찾기
* 특정 문자열이 시작되는 attributes가 들어있는 index를 반환한다.

#### 문자열의 시작과 끝 찾기

```R
loc.begin<-as.vector(regexpr('ing',mySent))
loc.length<-attr(regexpr('ing',mySent),"match.length")
loc.end<-loc.begin+loc.length-1
```







