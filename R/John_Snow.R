# John Snow(1813-1858)는 영국의 의사이자 역학의 선구자로, 런던에서 콜레라 발생 원인을 규명하고 퇴치에 중요한 기여를 한 인물입니다.
# 그의 업적은 공중보건, 역학, 그리고 지도 분석을 활용한 문제 해결의 선구적 사례로 평가받고 있습니다. 

#1. 패키지 설치 및 데이터 로드

# 설치
install.packages("HistData")

# 패키지 로드
library(HistData)

# 데이터 확인
data("Snow.deaths")
data("Snow.pumps")
data("Snow.polygons")


#2. 기본 데이터 구조 확인

str(Snow.deaths)  # 콜레라 사망자 데이터
str(Snow.pumps)   # 펌프 위치 데이터
str(Snow.polygons)  # 지역 경계 데이터

#3. 사망자와 펌프 위치 시각화

library(ggplot2)

# 사망자와 펌프 위치 플롯
ggplot() +
  geom_point(data = Snow.deaths, aes(x = x, y = y), color = "red", size = 1, alpha = 0.6) +
  geom_point(data = Snow.pumps, aes(x = x, y = y), color = "blue", size = 3) +
  labs(title = "1854년 런던 콜레라 사망자와 펌프 위치",
       x = "X 좌표", y = "Y 좌표") +
  theme_minimal()

#4. 지역 경계와 결합한 분석
# 지역 경계 데이터 준비
polygon_data <- as.data.frame(Snow.polygons)

# 시각화
ggplot() +
  geom_polygon(data = polygon_data, aes(x = x, y = y, group = group), fill = NA, color = "black") +
  geom_point(data = Snow.deaths, aes(x = x, y = y), color = "red", size = 1, alpha = 0.6) +
  geom_point(data = Snow.pumps, aes(x = x, y = y), color = "blue", size = 3) +
  labs(title = "1854년 런던 콜레라 사망자, 펌프 위치, 지역 경계",
       x = "X 좌표", y = "Y 좌표") +
  theme_minimal()
