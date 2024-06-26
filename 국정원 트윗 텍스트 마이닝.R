#20173147 이명진   

# 국정원 트윗 텍스트 마이닝 
#데이터 준비하기

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
library(stringr) 
library(wordcloud) 
library(RColorBrewer)
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.8.0_171/")
# 데이터 로드
twitter <- read.csv("twitter.csv",       
                    header = T,             
                    stringsAsFactors = F,          
                    fileEncoding = "UTF-8") 

# 변수명 수정
twitter <- rename(twitter,              
                  no = 번호,             
                  id = 계정이름,           
                  date = 작성일,           
                  tw = 내용) 

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ") 

head(twitter$tw)

#단어 빈도표 만들기 
# 트윗에서 명사추출
nouns <- extractNoun(twitter$tw) 

# 추출한 명사 list 를 문자열 벡터로 변환 , 단어별 빈도표 생성
wordcount <- table(unlist(nouns)) 

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F) 

# 변수명 수정
df_word <- rename(df_word,                   word = Var1,                   freq = Freq) 

#두 글자 이상으로 된 단어 추출, 빈도 상위 20개 단어 추출 
# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2) 

# 상위 20 개 추출
top20 <- df_word %>%   arrange(desc(freq)) %>%   head(20)

top20

#단어 빈도 막대 그래프 만들기 
library(ggplot2) 

order <- arrange(top20, freq)$word               # 빈도 순서 변수 생성


ggplot(data = top20, aes(x = word, y = freq)) +   ylim(0, 2500) +   geom_col() +   coord_flip() +   scale_x_discrete(limit = order) +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시

#워드 클라우드 만들기 
pal <- brewer.pal(8,"Dark2")       # 색상 목록 생성
set.seed(1234)                     # 난수 고정


wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록

#색깔 바꾸기 
pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정


wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록

############################################################# 국정원 자료 워드 클라우드 끝...