# Learning how to:
#  • compute the Petersen estimate
#  • compute the Schnabel estimate
#  • fit a Leslie depletion regression
#  • fit a DeLury depletion regression
#  • visualize the fitted relationships

#  1:Petersen estimator
M <- 340
C <- 2200
R <- 85
Nhat <- (M* C) / R
Nhat
# roughs tandard error
SE <- sqrt((M^2* C *(C-R)) / (R^3))
SE
# approximate 95% confidence interval
lower <- Nhat- 2*SE
upper <- Nhat+ 2*SE
c(Nhat = Nhat,SE = SE,lower = lower,upper = upper)
  
# 2: Schnabel estimator
Ct <- c(35,85, 120, 90)
Mt <- c(0,35, 115, 223)
Rt <- c(0,5, 12,20)
Nhat_schnabel <- sum(Ct*Mt) / sum(Rt)
Nhat_schnabel

# 3: Leslie method
# Leslie depletion method
catch <- c(300, 406, 172)
effort <- c(4, 6, 3)
cpue <- catch / effort
cumcatch <- c(0,cumsum(catch)[-length(catch)])
dat_leslie <- data.frame(catch, effort,cpue, cumcatch)
dat_leslie
fit_leslie <- lm(cpue~cumcatch, data = dat_leslie)
summary(fit_leslie)
intercept <- coef(fit_leslie)[1]
slope <- coef(fit_leslie)[2]
q <- -slope
N0 <- intercept / q
c(q = q, N0 = N0)

# 4:Plot for Leslie method
plot(dat_leslie$cumcatch, dat_leslie$cpue,
     pch = 19,
     xlab = "Cumulativecatch",
     ylab = "Catchperunit effort",
     main = "Lesliedepletionplot")
abline(fit_leslie,lwd = 2)

# 5:DeLury method
# DeLury depletion method
catch <- c(3000,4060,1720,3175)
effort <- c(40,60,30,60)
cpue <- catch / effort
cum_effort <- cumsum(c(0,effort[-length(effort)]))
log_cpue <- log(cpue)
dat_delury <- data.frame(catch, effort,cpue, cum_effort, log_cpue)
dat_delury
fit_delury <- lm(log_cpue~cum_effort, data = dat_delury)
summary(fit_delury)
intercept <- coef(fit_delury)[1]
slope <- coef(fit_delury)[2]
q <- -slope
N0 <- exp(intercept) / q
c(q = q, N0 = N0)

# 6:Plot for DeLury method
plot(dat_delury$cum_effort, dat_delury$log_cpue,
     pch = 19,
     xlab = "Cumulativeeffort",
     ylab = "log(CPUE)",
     main = "DeLurydepletionplot")
abline(fit_delury,lwd = 2)

# 7:Catch composition method
# Catch composition example
P1 <- 24 / 40
P2 <- 28 / 60
C <- 200
Cx <- 140
Nhat <- (Cx- P2 *C) / (P1- P2)
Nx <- P1*(Cx- P2*C) / (P1- P2)
Ny <- Nhat-Nx
c(N_total = Nhat, N_male = Nx, N_female = Ny)

#  8: A reusable Petersen function
petersen_est <- function(M, C,R){
  Nhat <- (M* C) / R
  SE <- sqrt((M^2*C *(C-R)) / (R^3))
  lower <- Nhat- 2*SE
  upper <- Nhat+ 2*SE
  data.frame(
    M = M,
    C = C,
    R = R,
    Nhat = Nhat,
    SE = SE,
    lower95 = lower,
    upper95 = upper
  )
}
petersen_est(M = 340, C =2200, R = 85)
             
#  9: A reusable Schnabel function
schnabel_est <- function(Ct, Mt,Rt) {
  if(length(Ct) != length(Mt)||length(Mt) != length(Rt)) {
    stop("Ct,Mt, andRtmusthavethe same length.")
  }
  Nhat <- sum(Ct * Mt) / sum(Rt)
  return(Nhat)
}
Ct <- c(35,85, 120, 90)
Mt <- c(0,35, 115, 223)
Rt <- c(0,5, 12,20)
schnabel_est(Ct, Mt, Rt)
47 / 52

# Interpretation of results
# When reporting fish population estimates, always state:
# • the method used
# • the assumptions made
# • the sampling design
# • the point estimate
# • the uncertainty, if available
# • practical limitations

# Common sources of bias:
# • loss of tags or marks
# • unequal catchability of marked and unmarked fish
# • non-random mixing
# • recruitment during the study
# • deaths or emigration of marked fish
# • inaccurate effort measurement
# • inaccurate catch composition data
# • violation of constant catchability in depletion models

# Key take-home messages:
# • Fish population estimation is central to fisheries science and management.
# • Different designs suit different biological and operational settings.
# • Mark-recapture methods are powerful but assumption-sensitive.
# • Depletion methods rely on changing CPUE as stocks are fished down.
# • VPA is particularly useful when catch-at-age data are available.
# • Method choice should always be guided by study design, assumptions, and data quality.