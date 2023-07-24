#20173147 이명진  
install.packages("Sejong") 
install.packages("hash") 
install.packages("rJava") 
install.packages("tau") 
install.packages("RSQLite") 
install.packages("devtools")
install.packages("dplyr")
install.packages("KONLP")
install.packages("stringr") 
install.packages("wordcloud") 

library(KoNLP)
library(dplyr)

Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.8.0_171/")

useNIADic() 

#x<-read.csv(file.choose(),header=T) #경로 지정이 어려워 특정 파일을 열수없을 때 사용 ㄱ + 데이터 저장할 장ㅅ

# 데이터 불러오기
txt <- readLines("hiphop.txt") 
head(txt) 
# ## Warning in readLines("hiphop.txt"): incomplete final line found on ## 'hiphop.txt' 


library(stringr) 


# 특수문제 제거
txt <- str_replace_all(txt, "\\W", " ") 
txt

# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다") 
# 가사에서 명사추출
nouns <- extractNoun(txt) 

# 추출한 명사 list 를 문자열 벡터로 변환 , 단어별 빈도표 생성
wordcount <- table(unlist(nouns)) 

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F) 

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq) 

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2) 

top_20 <- df_word %>%   
  arrange(desc(freq)) %>%   
  head(20)


# 워드클라우드 만들기


# 패키지 로드
library(wordcloud) 
## Loading required package: RColorBrewer 
library(RColorBrewer)

#단어 색상 목록 만들기 
pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8 개 색상 추출

#워드 클라우드 생성

set.seed(1234)                   # 난수 고정
wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

#단어 색상 바꾸기 
pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정


wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,            # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(4, 0.3),       # 단어 크기 범위
          colors = pal)            # 색상 목록


########################################################### 힙합가사 텍스트 마이닝 끝...










