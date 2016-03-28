library("itsmr")
library("forecast")
library("tseries")

# Load data from .tsm file that should be located in same
# directory as this script
script.dir <- dirname(sys.frame(1)$ofile)
co2 <- scan(paste(script.dir, "/maunaloa.tsm", sep=""))

plotc(co2)

# estimate & remove seasonality
s = season(co2,12)
plotc(s)
e = co2 - s

# estimate & remove trend
m = trend(e,1)
plotc(m)
residuals = co2 - s - m

# test residuals for randomness
test(residuals)

# test residuals for stationarity with KPSS test
print(kpss.test(residuals))

# find best ARIMA model for the residuals (KPSS shows they are non-stationary)
a = auto.arima(residuals)

# Forecast 2 months ahead (March and April)
f = forecast(a, h=2, level=95)
plot(f)

# extend trend data for next 2 timesteps
slope = m[2] - m[1]
m = append(m, tail(m,1) + slope)
m = append(m, tail(m,1) + slope)

# extend season data for next 2 timesteps
s = append(s, s[length(s) - 11])
s = append(s, s[length(s) - 11])

# extend data with residual predictions
y = append(residuals, f$mean)

# construct full predicted model (trend + season + resid prediction)
co2.predicted = m + s + y

plotnum = 36
colors = c(rep(1, plotnum-2), 2, 2)
plot(tail(co2.predicted, plotnum), 
     type="b", col=colors,
     main = "Mauna Loa CO2 Level",
     xlab = "month", ylab = "parts per million")
legend("topleft", c("Recorded", "Predicted"), pch=1, col=c(1,2))

# April prediction, with lower and upper 95% bound
april = tail(co2.predicted,1)
print(april)
print(april - f$mean[2] + f$lower[2]) 
print(april - f$mean[2] + f$upper[2])