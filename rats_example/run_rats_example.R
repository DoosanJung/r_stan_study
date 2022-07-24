getwd()
setwd('/Users/doosansmacbookpro/Documents/Projects/r_stan_study/rats_example')

library("rstan")
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# Prepare the data (which typically is a named list)
y <- as.matrix(read.table('rats.txt', header = TRUE))
x <- c(8, 15, 22, 29, 36)
xbar <- mean(x)
N <- nrow(y)
T <- ncol(y)

# Fit
rats_fit <- stan(
  file = "rats.stan",     # Stan program
  data = list(N=N, T=T, y=y, x=x, xbar=xbar)
)

# Fit result
print(rats_fit)
plot(rats_fit, pars=c("sigma_alpha", "sigma_beta"))
traceplot(rats_fit, pars=c("sigma_alpha", "sigma_beta"), inc_warmup = TRUE, nrow = 2)
pairs(rats_fit, pars=c("sigma_alpha", "sigma_beta"))
