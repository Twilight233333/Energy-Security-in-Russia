
devtools::install_github("synth-inference/synthdid")

data('california_prop99')
setup = panel.matrices(california_prop99)
tau.hat = synthdid_estimate(setup$Y, setup$N0, setup$T0)
print(summary(tau.hat))

se = sqrt(vcov(tau.hat, method='placebo'))
sprintf('point estimate: %1.2f', tau.hat)
sprintf('95%% CI (%1.2f, %1.2f)', tau.hat - 1.96 * se, tau.hat + 1.96 * se)

install.packages('plm')

install.packages('devtools')
library(devtools)
install_github('gertvv/gemtc')

devtools::install_github("synth-inference/synthdid")

library(synthdid)
library(ggplot2)
library(plm)
library(foreign)
set.seed(12345)

data('california_prop99')

mydata <-read.dta("E:/11.dta")

mydata0 = mydata
mydata0$treated = (mydata0$treated==1)
setup <- panel.matrices(mydata0, unit = 'Country', time = 'year', outcome = 'fragile_index', treatment = 'treated')
head(setup)

tau.hat = synthdid_estimate(setup$Y, setup$N0, setup$T0)
plot(tau.hat, se.method='placebo')
synthdid_units_plot(tau.hat, se.method='placebo')
plot(tau.hat, overlay=1,  se.method='placebo')

plot(tau.hat, overlay=.8, se.method='placebo')


tau.sc   = sc_estimate(setup$Y, setup$N0, setup$T0)
tau.did  = did_estimate(setup$Y, setup$N0, setup$T0)
estimates = list(tau.did, tau.sc, tau.hat)
names(estimates) = c('Diff-in-Diff', 'Synthetic Control', 'Synthetic Diff-in-Diff')

print(unlist(estimates))

synthdid_plot(estimates, se.method='placebo')

synthdid_units_plot(estimates, se.method='placebo')




setup = panel.matrices(mydata0)
estimate = synthdid_estimate(setup$Y, setup$N0, setup$T0)

top.controls = synthdid_controls(estimate)[1:10, , drop=FALSE]
plot(estimate, spaghetti.units=rownames(top.controls))




tau.hat = synthdid_estimate(setup$Y, setup$N0, setup$T0)
tau.hat
print(summary(tau.hat))

se = sqrt(vcov(tau.hat, method='placebo'))

sprintf('95%% CI (%1.2f, %1.2f)', tau.hat - 1.96 * se, tau.hat + 1.96 * se)
sprintf('point estimate: %1.2f', tau.hat)