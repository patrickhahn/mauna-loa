library("forecast")
library("tseries")

# Load data from .tsm file that should be located in same
# directory as this script
script.dir <- dirname(sys.frame(1)$ofile)
co2 <- scan(paste(script.dir, "/maunaloa.tsm", sep=""))

plot(co2)

# find best ARIMA model for the time seires
a = auto.arima(co2)

# Forecast 2 months ahead (March and April)
f = forecast(a, h=2, level= c(95, 99))
plot(f)

# extend data with residual predictions
co2.predicted = append(co2, f$mean)

plotnum = 36
colors = c(rep(1, plotnum-2), 2, 2)
plot(tail(co2.predicted, plotnum), 
     type="b", col=colors,
     main = "Mauna Loa CO2 Level",
     xlab = "month", ylab = "parts per million")
legend("topleft", c("Recorded", "Predicted"), pch=1, col=c(1,2))

# April prediction, with lower and upper 95% bound
april = tail(co2.predicted,1)
print(c("prediction:", april))
print(c("95% CI:", f$lower[3], f$upper[3]))
print(c("99% CI:", f$lower[4], f$upper[4]))
