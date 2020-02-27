# single linear regression example
setwd("./linear_regression_example")

library("rstan")
data(cars)

options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# Prepare the data
N <- dim(cars)[1]
x <- cars$speed
y <- cars$dist

fit <- stan(
  file = "simple_linear_regression.stan",  # Stan program
  data = list(N = N, x = x, y = y),    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 2,              # number of cores (could use one per chain)
  refresh = 0             # no progress shown
)

print(fit, pars = c("alpha", "beta", "lp__"), probs = c(.1, .5, .9))
plot(fit)
traceplot(fit, pars = c("alpha", "beta"), inc_warmup = TRUE, nrow = 2)
pairs(fit, pars = c("alpha", "beta", "lp__"))


# using R's lm to fit the linear model
result <- lm(y~x)
print(summary(result))
