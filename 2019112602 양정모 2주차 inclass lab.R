rm(ls=list())
rm(list()=ls)
rm(list=ls())
set.seed(123)
mu<-2
n<-300
n_iter<-1000
x<-runif(n,min=-3,max=7)
mean(x)
sd(x)
xbar<-mean(x)
s<-sd(x)
se<-s/sqrt(n)
t_crit<-qt(0.975,df=n-1)
lower<-xbar-t_crit*se
upper<-xbar+t_crit*se
cat("Sample mean =", xbar, "\n")
cat("Sample SD =", s, "\n")
cat("SE =", se, "\n")
cat("95% CI = (", lower, ",", upper,") \n")
covered<-(lower<=mu)&(mu<=upper)
covered
covered_vec<-logical(n_iter)
for (i in 1:n_iter){
  x<-runif(mu,min=-3,max=7)
  xbar<-mean(x)
  s<-sd(x)
  se<-s/sqrt(n)
  t_crit<-qt(0.975,df=n-1)
  lower<-xbar-t_crit*se
  upper<-xbar+t_crit*se
  covered_vec[i]<-(lower<=mu)&(mu<=upper)
}
head(covered_vec)
coverage<-mean(covered_vec)
coverage
for (i in 1:n_iter){
  x<-runif(n,min=-3,max=7)
  xbar<-mean(x)
  s<-sd(x)
  se<-s/sqrt(n)
  t_crit<-qt(0.975,df=n-1)
  lower<-xbar-t_crit*se
  upper<-xbar+t_crit*se
  covered_vec[i]<-(lower<=mu)&(mu<=upper)
}
coverage<-mean(covered_vec)
coverage
# 2번 문제 시작
xbar_vec<-numeric(n_iter)
for(i in 1:n_iter){
  x<-runif(n,min=-3,max=7)
  xbar<-mean(x)
  xbar_vec[i]<-xbar
}
head(xbar_vec)
hist(xbar_vec,
     main="Sampling Distribution of Sample Mean",
     xlab="Sample Mean")
abline(v=mu, col="red"m lwd=2)
abline(v=mu, col="red",lwd=2)
hist(xbar_vec,
     breaks = 40,
     col = "lightblue",
     border = "white",
     main = "Sampling Distribution of Sample Mean",
     xlab = "Sample Mean")

abline(v = mu, col = "red", lwd = 2)
#empirical var
var(xbar_vec)
emp_var<-var(xbar_vec)
emp_var
theo_var<-((7+3)^2/12)/n
theo_var
cat("Empirical variance of sample means =", emp_var, "\n")
cat("Theoretical variance of sample mean =", theo_var, "\n")
emp_mean<-mean(xbar_vec)
emp_mean
bias<-emp_mean-mu
bias
abs_bias<-abs(bias)
abs_bias
rel_bias<-bias/mu
rel_bias
mse<-mean((xbar_vec-mu)^2)
mse
rmse<-sqrt(mse)
rmse
rrmse<-rmse/abs(mu)
bias_sq_plus_var <- bias^2 + emp_var
bias_sq_plus_var
mse
sigma2<-2
xbar_vec<-numeric(n_iter)
covered_vec<-logical(n_iter)
for (i in 1:n_iter){
  x<-rnorm(n,mean=mu,sd=sigma2)
  xbar<-mean(x)
  s<-sd(x)
  se<-s/sqrt(n)
  t_crit<-qt(0.975,df=n-1)
  lower<-xbar-t_crit*se
  upper<-xbar+t_crit*se
  covered_vec[i]<-(lower<=mu)&(mu<=upper)
  xbar_vec[i]<-xbar
}
coverage<-mean(covered_vec)
emp_mean<-mean(xbar_vec)
emp_var<-var(xbar_vec)
bias<-emp_mean-mu
mse<-mean((xbar_vec - mu)^2)
hist(xbar_vec,
     breaks = 30,
     main = "Sampling Distribution (Normal)",
     xlab = "Sample Mean",
     col = "lightblue")

abline(v = mu, col = "red", lwd = 2)
