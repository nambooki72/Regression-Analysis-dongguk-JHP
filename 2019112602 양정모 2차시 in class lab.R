version 4.5.2 (2025-10-31 ucrt) -- "[Not] Part in a Rumble"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64

R은 자유 소프트웨어이며, 어떠한 형태의 보증없이 배포됩니다.
또한, 일정한 조건하에서 이것을 재배포 할 수 있습니다.
배포와 관련된 상세한 내용은 'license()' 또는 'licence()'을 통하여 확인할 수 있습니다.

R은 많은 기여자들이 참여하는 공동프로젝트입니다.
'contributors()'라고 입력하시면 이에 대한 더 많은 정보를 확인하실 수 있습니다.
그리고, R 또는 R 패키지들을 출판물에 인용하는 방법에 대해서는 'citation()'을 통해 확인하시길 부탁드립니다.

'demo()'를 입력하신다면 몇가지 데모를 보실 수 있으며, 'help()'를 입력하시면 온라인 도움말을 이용하실 수 있습니다.
또한, 'help.start()'의 입력을 통하여 HTML 브라우저에 의한 도움말을 사용하실수 있습니다
R의 종료를 원하시면 'q()'을 입력해주세요.

[Workspace loaded from ~/.RData]

> seq(10,100,length.out=20)
[1]  10.00000  14.73684  19.47368  24.21053  28.94737
[6]  33.68421  38.42105  43.15789  47.89474  52.63158
[11]  57.36842  62.10526  66.84211  71.57895  76.31579
[16]  81.05263  85.78947  90.52632  95.26316 100.00000
> rep(c("Group1", "Group2"), 10)
[1] "Group1" "Group2" "Group1" "Group2" "Group1" "Group2"
[7] "Group1" "Group2" "Group1" "Group2" "Group1" "Group2"
[13] "Group1" "Group2" "Group1" "Group2" "Group1" "Group2"
[19] "Group1" "Group2"
> getwd()
[1] "C:/Users/Admin/OneDrive/문서"
> setwd("C:\Users\Admin\OneDrive\바탕 화면\2026년 1학기\회귀해석")
에러: '\U' used without hex digits in character string (<input>:1:11)

> setwd("C:|Users|Admin|OneDrive|바탕 화면|2026년 1학기|회귀해석")
setwd("C:|Users|Admin|OneDrive|바탕 화면|2026년 1학기|회귀해석")에서 다음과 같은 에러가 발생했습니다: 
  작업디렉토리를 변경할 수 없습니다

> setwd("C:\\Users\\Admin\\OneDrive\\바탕 화면\\2026년 1학기\\회귀해석")
> getwd()
[1] "C:/Users/Admin/OneDrive/바탕 화면/2026년 1학기/회귀해석"
> load("r 파일들 연습용\\heights.RData")
> head(heights)
Mheight Dheight
1    59.7    55.1
2    58.2    56.5
3    60.6    56.0
4    60.7    56.8
5    61.8    56.0
6    55.5    57.9
> tail(hegiths)
에러: 객체 'hegiths'를 찾을 수 없습니다

> tail(heights)
Mheight Dheight
1370    69.5    70.4
1371    69.1    70.1
1372    65.0    71.6
1373    66.3    71.4
1374    70.8    71.0
1375    63.0    73.1
> par(mfrow=c(2,1))
> plot(heights$mother, heights$daughter, pch=23, col="blue", xlab="Mother heights", ylab="Daughter heights", main="Mother vs Daughter heights")
plot.window(...)에서 다음과 같은 에러가 발생했습니다: 유한한 값들만이 'xlim'에 사용될 수 있습니다
추가정보: 경고메시지(들):
  1: min(x)에서: min에 전달되는 인자들 중 누락이 있어 Inf를 반환합니다
2: max(x)에서: max에 전달되는 인자들 중 누락이 있어 -Inf를 반환합니다
3: min(x)에서: min에 전달되는 인자들 중 누락이 있어 Inf를 반환합니다
4: max(x)에서: max에 전달되는 인자들 중 누락이 있어 -Inf를 반환합니다

> ls()
[1] "heights"
> str(heights)
'data.frame':	1375 obs. of  2 variables:
  $ Mheight: num  59.7 58.2 60.6 60.7 61.8 55.5 55.4 56.8 57.5 57.3 ...
$ Dheight: num  55.1 56.5 56 56.8 56 57.9 57.1 57.6 57.2 57.1 ...
> plot(heights$mother,
       +      heights$daughter,
       +      pch=23,
       +      col="blue",
       +      xlab="Mother heights",
       +      ylab="Daughter heights",
       +      main="Mother vs Daughter heights")
plot.window(...)에서 다음과 같은 에러가 발생했습니다: 유한한 값들만이 'xlim'에 사용될 수 있습니다
추가정보: 경고메시지(들):
  1: min(x)에서: min에 전달되는 인자들 중 누락이 있어 Inf를 반환합니다
2: max(x)에서: max에 전달되는 인자들 중 누락이 있어 -Inf를 반환합니다
3: min(x)에서: min에 전달되는 인자들 중 누락이 있어 Inf를 반환합니다
4: max(x)에서: max에 전달되는 인자들 중 누락이 있어 -Inf를 반환합니다

> str(heights)
'data.frame':	1375 obs. of  2 variables:
  $ Mheight: num  59.7 58.2 60.6 60.7 61.8 55.5 55.4 56.8 57.5 57.3 ...
$ Dheight: num  55.1 56.5 56 56.8 56 57.9 57.1 57.6 57.2 57.1 ...
> names(heights)
[1] "Mheight" "Dheight"
> head(heights)
Mheight Dheight
1    59.7    55.1
2    58.2    56.5
3    60.6    56.0
4    60.7    56.8
5    61.8    56.0
6    55.5    57.9
> plot(heights$Mheight, heights$Dheight, pch=23, col="blue", xlab="Mother Heights", ylab="Daughter Heights", main="Mother vs Daughter heights")
> abline(h=mean(heights$Dheight), col="red", lwd=2, lty=2)
> curve(dt(x,df=19), from=-4, to=4, main="t distribution (df=19)", xlab="t", ylab="Density")
> crit<-qt(0.975, df=19)
> x_left<-seq(-4, -crit, length.out=200)
> y_left<-dt(x_left,df=19)
> polygon(c(-4, x_left, -crit), c(0,y_left,0), col="lightblue", border=NA)
> x <- seq(-4, -tcrit, length=100)
에러: 객체 'tcrit'를 찾을 수 없습니다

> curve(dt(x, df=19),
        +       from=-4, to=4,
        +       xlab="t", ylab="Density",
        +       main="t distribution (df=19)")
> x_left <- seq(-4, -crit, length.out=200)
> x_left <- seq(-4, -crit, length.out=200)
> polygon(c(-4, x_left, -crit), c(0, y_left, 0),
          +         col="lightblue", border=NA)
> abline(v=c(-crit, crit), col="red", lty=2, lwd=2)
> pdf("Week1_Lab_Analysis.pdf")
> 
  > par(mfrow=c(2,1))
> 
  > # 그래프 1
  > plot(heights$Mheight, heights$Dheight,
         +      pch=23, col="blue",
         +      xlab="Mother heights",
         +      ylab="Daughter heights",
         +      main="Mother vs Daughter heights")
> 
  > abline(h=mean(heights$Dheight),
           +        col="red", lwd=2, lty=2)
> 
  > # 그래프 2
  > curve(dt(x,df=19), from=-4, to=4,
          +       xlab="t", ylab="Density",
          +       main="t distribution (df=19)")
> 
  > crit <- qt(0.975,19)
> 
  > x_left <- seq(-4,-crit,length.out=200)
> polygon(c(-4,x_left,-crit),
          +         c(0,dt(x_left,19),0),
          +         col="lightblue", border=NA)
> 
  > x_right <- seq(crit,4,length.out=200)
> polygon(c(crit,x_right,4),
          +         c(0,dt(x_right,19),0),
          +         col="lightblue", border=NA)
> 
  > abline(v=c(-crit,crit), col="red", lty=2)
> 
  > dev.off()
RStudioGD 
2 
> history()
> subset_height<-heights[heights$Dheight>65,]
> subset_heights_sorted<-subset_heights[order(subset_heights$Mheight),]
에러: 객체 'subset_heights'를 찾을 수 없습니다

> subset_heights_sorted<-subset_height[order(subset_height$Mheight),]
> head(subset_heights_sorted)
Mheight Dheight
937     58.2    65.5
1092    58.6    66.9
942     59.0    65.4
943     59.0    65.1
1094    59.0    66.7
1233    59.0    67.6
> treated
에러: 객체 'treated'를 찾을 수 없습니다

> boxplot(treated, placebo,
          +         names = c("Treated", "Placebo"),
          +         col = c("lightblue", "lightpink"),
          +         main = "Blood Pressure Decrease by Group",
          +         ylab = "Decrease in Blood Pressure")
에러: 객체 'treated'를 찾을 수 없습니다

> treated<-c(1,2,3,4,5,6,7,8,9,10)
> placebo<-c(2,2,3,4,4,6,8,9,9,9,10)
> boxplot(treated, placebo,
          +         names = c("Treated", "Placebo"),
          +         col = c("lightblue", "lightpink"),
          +         main = "Blood Pressure Decrease by Group",
          +         ylab = "Decrease in Blood Pressure")
> n1<-length(treated)
> n2<-length(placebo)
> xbar1<-mean(treated)
> xbar2<-mean(placebo)
> s1sq<-var(treated)
> s2sp<-var(treated)
> sp2<-((n1-1)*s1sq + (n2-1)*s2sq)/(n1+n2-2)
에러: 객체 's2sq'를 찾을 수 없습니다

> sp2<-((n1-1)*s1sq + (n2-1)*s2sp)/(n1+n2-2)
> sp2
[1] 9.166667
> sp<-sqrt(sp2)
> t_stat<-(xbar1-xbar2)/(sp*sqrt(1/n1 + 1/n2))
> t_stat
[1] -0.3779645
> p_value <- 2 * (1 - pt(abs(t_stat), df = n1 + n2 - 2))
> p_value
[1] 0.7096465
> alpha <- 0.10
> t_crit <- qt(1 - alpha/2, df = n1 + n2 - 2)
> 
  > SE_diff <- sp * sqrt(1/n1 + 1/n2)
> diff_mean <- xbar1 - xbar2
> 
  > lower <- diff_mean - t_crit * SE_diff
> upper <- diff_mean + t_crit * SE_diff
> 
  > c(lower, upper)
[1] -2.787428  1.787428
> cat("n1 =", n1, "\n")
n1 = 10 
> cat("n2 =", n2, "\n")
n2 = 11 
> cat("mean treated =", xbar1, "\n")
mean treated = 5.5 
> cat("mean placebo =", xbar2, "\n")
mean placebo = 6 
> cat("var treated =", s1sq, "\n")
var treated = 9.166667 
> cat("var placebo =", s2sq, "\n")
에러: 객체 's2sq'를 찾을 수 없습니다

> cat("n1 =", n1, "\n")
n1 = 10 
> cat("n2 =", n2, "\n")
n2 = 11 
> cat("mean treated =", xbar1, "\n")
mean treated = 5.5 
> cat("mean placebo =", xbar2, "\n")
mean placebo = 6 
> cat("var treated =", s1sq, "\n")
var treated = 9.166667 
> cat("var placebo =", s2sp, "\n")
var placebo = 9.166667 
> cat("pooled variance =", sp2, "\n")
pooled variance = 9.166667 
> cat("t-statistic =", t_stat, "\n")
t-statistic = -0.3779645 
> cat("p-value =", p_value, "\n")
p-value = 0.7096465 
> cat("90% CI for mu_treated - mu_placebo = (", lower, ",", upper, ")\n")
90% CI for mu_treated - mu_placebo = ( -2.787428 , 1.787428 )
> 