# ============================================================
# Session 3 - Problem 1
# Hypothesis Testing and Model Diagnostics in SLR
# ============================================================

# ------------------------------------------------------------
# 0. 작업환경 정리
# ------------------------------------------------------------
# 기존에 만들어져 있던 객체들을 모두 지웁니다.

rm(list = ls())

# ------------------------------------------------------------
# 1. 난수 생성의 재현 가능성 확보
# ------------------------------------------------------------
# set.seed()를 쓰면 같은 난수가 다시 생성됩니다.
# 즉, 나중에 다시 실행해도 같은 X, 같은 Y가 나오므로
# 복습하거나 제출할 때 결과가 바뀌지 않아 편리합니다.
set.seed(123)

# ------------------------------------------------------------
# 2. 데이터 생성
# ------------------------------------------------------------
# 문제 조건:
# n = 20
# X ~ Uniform(0, 10)
# epsilon ~ Normal(0, 10^2)
# beta0 = 2, beta1 = 3

n <- 20           # 표본 크기
beta0 <- 2        # 절편(intercept)
beta1 <- 3        # 기울기(slope)
sigma <- 10       # 오차항의 표준편차 (분산이 아니라 표준편차)

# X를 U(0,10)에서 20개 생성
X <- runif(n = n, min = 0, max = 10)

# epsilon을 N(0, 10^2)에서 20개 생성
# rnorm()의 sd 인자는 표준편차이므로 10을 넣습니다.
epsilon <- rnorm(n = n, mean = 0, sd = sigma)

# Y = beta0 + beta1*X + epsilon
Y <- beta0 + beta1 * X + epsilon

# 생성된 데이터를 확인해 봅니다.
X
epsilon
Y

# ------------------------------------------------------------
# 3. 데이터프레임으로 정리
# ------------------------------------------------------------
# lm()에서 data= 형태를 쓰면 코드가 더 보기 좋고,
# 나중에 변수 관리하기도 편합니다.
dat <- data.frame(X = X, Y = Y)

dat
str(dat)
summary(dat)

# ------------------------------------------------------------
# 4. 산점도 먼저 확인
# ------------------------------------------------------------
# 회귀분석은 숫자만 보지 말고 그림도 같이 보는 습관이 중요합니다.
plot(dat$X, dat$Y,
     main = "Scatter Plot of Simulated Data",
     xlab = "X",
     ylab = "Y",
     pch = 19)

# ------------------------------------------------------------
# 5. 단순선형회귀모형 적합
# ------------------------------------------------------------
# Y = beta0 + beta1*X + error 형태의 모형을 적합합니다.
fit <- lm(Y ~ X, data = dat)

# 회귀직선을 산점도 위에 추가해 봅니다.
abline(fit, col = "red", lwd = 2)

# ------------------------------------------------------------
# 6. 회귀분석 결과 확인
# ------------------------------------------------------------
# summary()는 회귀계수 추정치, 표준오차, t값, p값 등을 보여줍니다.
fit_summary <- summary(fit)
fit_summary

# ------------------------------------------------------------
# 7. slope(beta1)에 대한 t-statistic과 p-value 추출
# ------------------------------------------------------------
# 회귀계수 표는 coefficients 안에 들어 있습니다.
fit_summary$coefficients

# coefficients 행렬의 구조:
# (Intercept) 행과 X 행이 있고,
# 각 열은 Estimate, Std. Error, t value, Pr(>|t|) 입니다.

# X의 t값(= beta1에 대한 t-statistic)
t_stat <- fit_summary$coefficients["X", "t value"]

# 양측검정 p-value
p_two_sided <- fit_summary$coefficients["X", "Pr(>|t|)"]


t_stat
p_two_sided

# ============================================================
# Session 3 - Problem 2
# Matrix Algebra for OLS Estimators
# ============================================================

# ------------------------------------------------------------
# 2.1 Design Matrix 만들기
# ------------------------------------------------------------
# 단순선형회귀:
# Y = beta0 + beta1*X + error
#
# 이를 행렬 형태로 쓰면
# y = X %*% beta + error
#
# 여기서 design matrix X는
# 첫 번째 열: 전부 1 (intercept column)
# 두 번째 열: 설명변수 X 값
#
# 즉, 각 행은 [1, Xi] 형태가 됩니다.

# 앞 문제에서 만든 dat를 그대로 사용
# dat$X, dat$Y 가 있다고 가정

# 방법 1: cbind()를 사용해서 직접 만들기
X_mat <- cbind(1, dat$X)

colnames(X_mat) <- c("Intercept", "X")

X_mat
dim(X_mat)        
head(X_mat)     

# ------------------------------------------------------------
# y 벡터도 행렬(열벡터) 형태로 준비
# ------------------------------------------------------------
y_mat <- as.matrix(dat$Y)

y_mat
dim(y_mat)
head(y_mat)

# ------------------------------------------------------------
# 2.2 OLS estimator를 직접 계산
# ------------------------------------------------------------
# 공식:
# beta_hat = (X'X)^(-1) X'y
#
# R에서:
# t(X_mat)         : 전치행렬 X'
# %*%              : 행렬곱
# solve(A)         : A의 역행렬

# Step 1: X'X 계산
XtX <- t(X_mat) %*% X_mat
XtX

# Step 2: (X'X)^(-1) 계산
XtX_inv <- solve(XtX)
XtX_inv

# Step 3: X'y 계산
Xty <- t(X_mat) %*% y_mat
Xty

# Step 4: 최종적으로 beta_hat 계산
beta_hat_manual <- XtX_inv %*% Xty
beta_hat_manual

rownames(beta_hat_manual) <- c("beta0_hat", "beta1_hat")
beta_hat_manual

# ------------------------------------------------------------
# 2.3 lm() 결과와 비교
# ------------------------------------------------------------
# 앞 문제에서 만든 회귀모형 fit를 사용
coef(fit)

beta_hat_lm <- as.matrix(coef(fit))
beta_hat_lm

rownames(beta_hat_lm) <- c("beta0_hat", "beta1_hat")
beta_hat_lm

# ------------------------------------------------------------
# 두 결과 비교
# ------------------------------------------------------------
# 직접 계산한 값과 lm()이 계산한 값이 사실상 같은지 확인합니다.
beta_hat_manual
beta_hat_lm

beta_hat_manual - beta_hat_lm

all.equal(beta_hat_manual, beta_hat_lm)

# ------------------------------------------------------------
# 결과를 문장 형태로 출력
# ------------------------------------------------------------
cat("--------------------------------------------------\n")
cat("Manual OLS estimation using matrix algebra\n")
cat("--------------------------------------------------\n")
cat("Estimated beta0 (manual) =", beta_hat_manual[1,1], "\n")
cat("Estimated beta1 (manual) =", beta_hat_manual[2,1], "\n\n")

cat("Estimated beta0 from coef(fit) =", beta_hat_lm[1,1], "\n")
cat("Estimated beta1 from coef(fit) =", beta_hat_lm[2,1], "\n\n")

cat("Difference between manual estimate and coef(fit):\n")
print(beta_hat_manual - beta_hat_lm)

cat("\nAre they essentially equal?\n")
print(all.equal(beta_hat_manual, beta_hat_lm))
cat("--------------------------------------------------\n")

