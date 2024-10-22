red_and_black <-
function(k){
  set.seed(k)
  N <- nrow(class_roll) 
  class_roll$group <- 
    sample(1:N) %%
    2 %>%
    factor(levels = c(0, 1), labels = c("Red", "Black"))

## 학번
  class_roll$id_2 <-
    class_roll$id %>%
    substr(1, 4) %>%
    ifelse(as.numeric(.) <= 2018, "2018", .)
  X1 <- class_roll %$%
    table(.$group, .$id_2) %>%
    chisq.test(simulate.p.value = FALSE) %>%
    `[[`(1) %>%
    unname

## e-mail 서비스업체
  isp <- class_roll$email %>%
    strsplit("@", fixed = TRUE) %>%
    sapply("[", 2) %>%
    strsplit("[.]", fixed = FALSE) %>%
    sapply("[", 1)
  X4 <- isp %>%
    `%in%`(c("naver", "gmail")) %>%
    ifelse(isp, "기타서비스") %>%
    factor(levels = c("naver", "gmail", "기타서비스"),
           labels = c("네이버", "구글", "기타서비스")) %>%
    table(class_roll$group, .)  %>%
    chisq.test(simulate.p.value = FALSE) %>%
    `[[`(1) %>%
    unname

## 휴대폰번호의 분포
  cut_label <- paste(paste0(0:9, "000"), paste0(0:9, "999"), 
                     sep = "~")
  X5 <- class_roll$cell_no %>%
    substr(start = 8, stop = 11) %>%
    sapply(as.numeric) %>%
    cut(labels = cut_label, 
        breaks = seq(0, 10000, by = 1000)) %>%
    table(class_roll$group, .) %>%
    chisq.test(simulate.p.value = TRUE) %>%
    `[[`(1) %>%
    unname

## 성씨 분포
  f_name <- class_roll$name %>%
    substring(first = 1, last = 1) 
  X6 <- f_name %>%
    `%in%`(c("김", "이", "박", "최", "정")) %>%
    ifelse(f_name, "기타") %>%
    factor(levels = c("김", "이", "박", "최", "정", "기타")) %>%
    table(class_roll$group, .) %>%
    chisq.test(simulate.p.value = FALSE) %>%
    `[[`(1) %>%
    unname
  
## 단과대학
  X7 <- 
    class_roll %$%
    table(.$group, .$college) %>%
    chisq.test(simulate.p.value = FALSE) %>%
    `[[`(1) %>%
    unname

## Sum of Chi_Squares
#  Xsum <- X0 + X1 + X2 + X3 + X4 + X5 + X6 + X7
  Xsum <- X1 + X4 + X5 + X6 + X7
  Xsum

## Results
#  list(Values = c(X1, X2, X3, X4, X5, X6, X7), Xsum = Xsum)
}
