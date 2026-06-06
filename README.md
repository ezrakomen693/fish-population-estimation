# 🐟 Population Size Estimation in Fish Populations

> Classical mark-recapture and depletion methods implemented in R , from theory to practical fisheries management.


## 📖 Overview

This repository contains a well-documented R script implementing five classical methods for estimating fish population sizes, developed as part of **STA 2232: Ecological Sampling Techniques** at **Jomo Kenyatta University of Agriculture and Technology (JKUAT)**.

Population size estimation is central to fisheries science and wildlife management. Accurate estimates inform stocking decisions, harvest quotas, and conservation policy. This script covers the full pipeline , from closed-population mark-recapture estimates to open-population depletion regression , alongside reusable functions and a bias awareness guide.


## 🧰 Methods Implemented

| # | Method | Type | Key Output |
|---|--------|------|------------|
| 1 | **Petersen Estimator** | Mark-recapture (2-sample) | N̂, SE, 95% CI |
| 2 | **Schnabel Estimator** | Mark-recapture (multi-sample) | N̂ |
| 3 | **Leslie Depletion** | Depletion regression (CPUE ~ Cumulative Catch) | q, N₀ |
| 4 | **DeLury Depletion** | Depletion regression (log CPUE ~ Cumulative Effort) | q, N₀ |
| 5 | **Catch Composition** | Sex/class ratio method | N_total, N_male, N_female |


## 📂 Repository Structure

```
population-size-estimation-fish/
│
├── Population_Size_Estimation_in_Fish_Populations.R   # Main analysis script
└── README.md                                          # Project documentation
```


## 🔬 Method Details

### 1. Petersen Estimator (Lincoln-Petersen)

A closed-population, two-sample mark-recapture method.

**Formula:**

$$\hat{N} = \frac{M \times C}{R}$$

where:
- `M` = number of fish marked and released in sample 1  
- `C` = total fish captured in sample 2  
- `R` = number of marked fish recaptured in sample 2  

**Standard error:**

$$SE(\hat{N}) = \sqrt{\frac{M^2 \cdot C(C - R)}{R^3}}$$

**Key assumptions:** Population is closed (no births, deaths, emigration, or immigration); marks are not lost; marked fish mix randomly; each fish has equal catchability.


### 2. Schnabel Estimator

An extension of Petersen to multiple sampling occasions, improving precision by accumulating mark information across surveys.

$$\hat{N}_{Schnabel} = \frac{\sum C_t M_t}{\sum R_t}$$

where at occasion `t`: `Cₜ` = catch, `Mₜ` = cumulative marked fish at large, `Rₜ` = recaptures.


### 3. Leslie Depletion Method

A removal/depletion method based on the linear decline of **CPUE (Catch Per Unit Effort)** as the population is fished down.

$$\text{CPUE}_t = qN_0 - q \cdot K_t$$

where `q` = catchability coefficient, `N₀` = initial population size, `Kₜ` = cumulative catch before occasion `t`.  
A linear regression of CPUE on cumulative catch yields `q = -slope` and `N₀ = intercept / q`.


### 4. DeLury Depletion Method

A log-linear depletion model relating **log(CPUE)** to **cumulative effort** — more appropriate when effort rather than catch drives depletion.

$$\ln(\text{CPUE}_t) = \ln(qN_0) - q \cdot E_t$$

where `Eₜ` = cumulative effort before occasion `t`.


### 5. Catch Composition Method

Estimates total population and subgroup sizes (e.g., male/female) using known proportions from two independent sampling frames.

$$\hat{N} = \frac{C_x - P_2 C}{P_1 - P_2}$$


## ▶️ Getting Started

### Prerequisites

- R (≥ 4.0.0)
- No external packages required , base R only

### Running the Script

```r
# Clone the repository and open in R or RStudio
source("Population_Size_Estimation_in_Fish_Populations.R")
```


## 📊 Sample Output

```
# Petersen Estimator
   Nhat      SE  lower95  upper95
   8800  931.67   6936.7   10663.3

# Schnabel Estimator
   Nhat_schnabel
   6308.511

# Leslie Depletion
   q         N0
   0.0621    4378.4

# DeLury Depletion
   q         N0
   0.00589   75682.7

# Catch Composition
   N_total   N_male   N_female
   206.25    123.75   82.5
```


## ⚠️ Common Sources of Bias

Awareness of violations is as important as knowing the methods. Key sources of bias include:

- **Tag/mark loss** : inflates N̂ (fewer recaptures than expected)
- **Unequal catchability** : marked fish may behave differently (trap shyness or trap happiness)
- **Non-random mixing** : marked fish may not disperse uniformly in the population
- **Population not closed** : recruitment, mortality, or emigration during the study violates assumptions
- **Effort measurement error** : inaccurate effort data corrupts CPUE in depletion models
- **Non-constant catchability** : Leslie/DeLury assume `q` is stable; gear saturation or seasonal behaviour can violate this



## 📋 Reporting Checklist

When publishing fish population estimates, always document:

- [ ] Method used and justification for choosing it
- [ ] Assumptions made and whether they were verified
- [ ] Sampling design (effort, occasions, gear type)
- [ ] Point estimate (N̂)
- [ ] Uncertainty measure (SE, 95% CI) where available
- [ ] Known limitations and potential biases



## 🎓 Academic Context

| Field | Detail |
|-------|--------|
| **Course** | STA 2232 : Ecological Sampling Techniques |
| **Institution** | Jomo Kenyatta University of Agriculture and Technology (JKUAT) |
| **Department** | Statistics and Actuarial Science |
| **Programme** | BSc Biostatistics |


## 👤 Author

**Ezra Komen Kipyegon**  
BSc Biostatistics, JKUAT  
📧 ezrakomen693@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/ezra-komen-kipyegon)  
🐙 [GitHub](https://github.com/ezrakomen693)


## 📄 License

This project is open for academic and educational use. Feel free to adapt the methods for your own fisheries or ecological sampling coursework.

*"Method choice should always be guided by study design, assumptions, and data quality."*

