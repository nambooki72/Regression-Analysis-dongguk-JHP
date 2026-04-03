# ============================================================
# Session 4: Transformations and Coefficient Precision
# ============================================================

rm(list=ls())
set.seed(123)

# ------------------------------------------------------------
# 1. 데이터 생성
n <- 20                 # 표본크기(sample size)
beta0 <- 2              # 진짜 절편(true intercept)
beta1 <- 3              # 진짜 기울기(true slope)
sigma <- 10             # 오차항의 표준편차(sd of error)

X <- runif(n, min = 0, max = 10)

eps <- rnorm(n, mean = 0, sd = sigma)

Y <- beta0 + beta1 * X + eps

dat <- data.frame(X = X, Y = Y)

head(dat)
str(dat)
summary(dat)

# ------------------------------------------------------------
# 2. 기본 산점도와 회귀직선 확인

plot(
  dat$X, dat$Y,
  pch = 19,                 
  main = "Simulated Data: Y = 2 + 3X + error",
  xlab = "X",
  ylab = "Y"
)

# ------------------------------------------------------------
# 3. lm()으로 단순선형회귀 적합
mod <- lm(Y ~ X, data = dat)

coef(mod)

coef(mod)
summary(mod)
abline(mod, col = "red", lwd = 2)

# ------------------------------------------------------------
# 4. 디자인 행렬(design matrix)과 분산-공분산 행렬 직접 계산

# model.matrix(mod):
# lm이 내부적으로 사용하는 디자인 행렬을 뽑아냅니다.
# 첫 번째 열은 절편을 위한 1들, 두 번째 열은 X 값입니다.
Xmat <- model.matrix(mod)

Xmat
dim(Xmat)

# 잔차(residual) = 관측값 - 적합값
resid_mod <- residuals(mod)

# SSE = sum of squared errors = 잔차제곱합
SSE <- sum(resid_mod^2)

# 자유도(df) = n - 2
# 단순선형회귀에서는 추정하는 모수가 절편, 기울기 두 개이므로 n - 2
df_error <- n - 2

# sigma_hat^2 = MSE = SSE / (n - 2)
sigma_hat2 <- SSE / df_error

# sigma_hat^2 = MSE = SSE / (n - 2)
sigma_hat2 <- SSE / df_error

# (X^T X)^(-1) 계산
XtX_inv <- solve(t(Xmat) %*% Xmat)

# beta_hat의 분산-공분산 행렬
vcov_manual <- XtX_inv * sigma_hat2

# 수동 계산한 분산-공분산 행렬 출력
vcov_manual


# R이 주는 공식 분산-공분산 행렬과 비교
vcov(mod)


# 두 값이 거의 같은지 확인
all.equal(vcov_manual, vcov(mod))

# ------------------------------------------------------------
# 5. 표준오차(Standard Error) 직접 계산
# 분산-공분산 행렬의 대각성분(diagonal)은 각 추정량의 분산입니다.
# 따라서 그 제곱근이 표준오차(SE)가 됩니다.
se_manual <- sqrt(diag(vcov_manual))
se_manual

# summary(mod)$coefficients 표에서 두 번째 열이 Std. Error 입니다.
summary(mod)$coefficients

# 비교를 위해 R의 SE만 뽑기
se_lm <- summary(mod)$coefficients[, "Std. Error"]
se_lm

# 두 결과 비교
all.equal(as.numeric(se_manual), as.numeric(se_lm))

# ------------------------------------------------------------
# 6. 절편과 기울기 추정량의 상관관계 계산

# 분산-공분산 행렬에서 공분산을 이용해 상관계수를 계산합니다.
# corr(beta0_hat, beta1_hat) = cov / (sd1 * sd2)

cov_b0_b1 <- vcov_manual[1, 2]
var_b0 <- vcov_manual[1, 1]
var_b1 <- vcov_manual[2, 2]

corr_b0_b1 <- cov_b0_b1 / sqrt(var_b0 * var_b1)
corr_b0_b1

# 참고로 R의 cov2cor()를 쓰면 공분산행렬을 상관행렬로 바꿀 수 있습니다.
cov2cor(vcov_manual)

# ------------------------------------------------------------
# 7. X를 상수 5로 중심화(centering by a fixed constant)

# X_center_5 = X - 5
# 이 경우 절편은 바뀌지만 기울기는 변하지 않습니다. :contentReference[oaicite:6]{index=6}
dat$X_c5 <- dat$X - 5

mod_c5 <- lm(Y ~ X_c5, data = dat)

coef(mod)
coef(mod_c5)

# 해석:
# 원래 Y = b0 + b1*X
# X_c5 = X - 5 이므로 X = X_c5 + 5
# 따라서
# Y = b0 + b1*(X_c5 + 5)
#   = (b0 + 5*b1) + b1*X_c5
# 즉, 절편은 b0 + 5*b1로 바뀌고 기울기는 동일해야 합니다.

# 실제 확인
coef(mod)[1] + 5 * coef(mod)[2]
coef(mod_c5)[1]

coef(mod)[2]
coef(mod_c5)[2]


# ------------------------------------------------------------
# 8. X를 평균으로 중심화(centering by mean of X)

xbar <- mean(dat$X)
dat$X_cmean <- dat$X - xbar

mod_cmean <- lm(Y ~ X_cmean, data = dat)

coef(mod)
coef(mod_cmean)

# 이 경우 절편은 "X가 평균일 때의 예측 Y값"이 됩니다.
# 즉 intercept = b0_hat + b1_hat * xbar
coef(mod)[1] + coef(mod)[2] * xbar
coef(mod_cmean)[1]

# 기울기는 그대로 유지
coef(mod)[2]
coef(mod_cmean)[2]

# 중심화 후 절편-기울기 추정량의 상관 확인
vcov_cmean <- vcov(mod_cmean)
cov2cor(vcov_cmean)

# 이론적으로는 평균 중심화하면 intercept와 slope의 상관이 0이 됩니다.
# 실제 컴퓨터 계산에서는 0 또는 0에 매우 가까운 값이 나옵니다.
corr_b0_b1_cmean <- cov2cor(vcov_cmean)[1, 2]
corr_b0_b1_cmean

# ------------------------------------------------------------
# 9. Y를 평균으로 중심화
ybar <- mean(dat$Y)
dat$Y_cmean <- dat$Y - ybar

# Y만 중심화하고 X는 원래대로 둔 회귀
mod_yc <- lm(Y_cmean ~ X, data = dat)

coef(mod)
coef(mod_yc)

# 이론:
# Y_cmean = Y - ybar
#         = (b0 + b1 X) - ybar
#         = (b0 - ybar) + b1 X
# 그런데 ybar = b0_hat + b1_hat*xbar (표본 적합 직선이 평균점을 지남)
# 따라서 새 절편은 -b1_hat * xbar 가 됩니다. 

# 확인
- coef(mod)[2] * mean(dat$X)
coef(mod_yc)[1]

# 기울기는 여전히 동일
coef(mod)[2]
coef(mod_yc)[2]

# ------------------------------------------------------------
# 10. X와 Y를 둘 다 평균 중심화

dat$Y_cmean <- dat$Y - mean(dat$Y)
dat$X_cmean <- dat$X - mean(dat$X)

mod_both_centered <- lm(Y_cmean ~ X_cmean, data = dat)

coef(mod_both_centered)

# 이론적으로 절편은 정확히 0
# (수치오차 때문에 0에 매우 가까운 작은 값일 수 있음)
coef(mod_both_centered)[1]

# 기울기는 그대로 유지
coef(mod_both_centered)[2]
coef(mod)[2]

# ------------------------------------------------------------
# 11. X와 Y를 표준화(standardization)

# 표준화:
# Z = (value - mean) / sd
# 평균 0, 표준편차 1이 되도록 바꿉니다. 

dat$X_std <- (dat$X - mean(dat$X)) / sd(dat$X)
dat$Y_std <- (dat$Y - mean(dat$Y)) / sd(dat$Y)

# 표준화 결과 확인
mean(dat$X_std)
sd(dat$X_std)
mean(dat$Y_std)
sd(dat$Y_std)

# 표준화된 변수로 회귀
mod_std <- lm(Y_std ~ X_std, data = dat)

summary(mod_std)
coef(mod_std)

# 절편은 0이어야 함 (또는 거의 0)
coef(mod_std)[1]

# ------------------------------------------------------------
# 12. 표준화 회귀 기울기 = 상관계수 확인

# 표준화 회귀에서 slope는 Pearson correlation과 같습니다.
r_xy <- cor(dat$X, dat$Y)
r_xy

coef(mod_std)[2]

# 두 값 비교
all.equal(as.numeric(coef(mod_std)[2]), as.numeric(r_xy))

# ------------------------------------------------------------
# 13. 표준화 기울기 변환 공식 확인

# 원래 회귀계수 b1_hat 에 대해
# b1_std = b1_hat * s_x / s_y
b1_hat <- coef(mod)[2]
sx <- sd(dat$X)
sy <- sd(dat$Y)

b1_std_from_formula <- b1_hat * sx / sy
b1_std_from_formula

coef(mod_std)[2]

all.equal(as.numeric(b1_std_from_formula), as.numeric(coef(mod_std)[2]))

cat("--------------------------------------------------\n")
cat("Original model coefficients:\n")
print(coef(mod))

cat("\nCorrelation between beta0_hat and beta1_hat (original):\n")
print(corr_b0_b1)

cat("\nCorrelation between beta0_hat and beta1_hat (X mean-centered):\n")
print(corr_b0_b1_cmean)

cat("\nCoefficient of model with both X and Y centered:\n")
print(coef(mod_both_centered))

cat("\nSlope of standardized regression:\n")
print(coef(mod_std)[2])

cat("\nPearson correlation cor(X, Y):\n")
print(r_xy)

cat("\nStandardized slope from formula b1 * sx / sy:\n")
print(b1_std_from_formula)

