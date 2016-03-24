library("itsmr")

# Load data from .tsm file that should be located in same
# directory as this script
script.dir <- dirname(sys.frame(1)$ofile)
co2 <- scan(paste(script.dir, "/maunaloa.tsm", sep=""))

plotc(co2)

# estimate season & trend, then remove them
xv = c("season", 12, "trend", 1)
e = Resid(co2, xv)

# test residuals for randomness
test(e)

# This line was used to find ultimate p and q (p=5, q=3)
# a = autofit(e, p=0:5, q=0:5)

# Estimate ARMA model coefficients
a = arma(e, p=5, q=3)

# Forecast 2 months ahead (March and April)
forecast(co2, xv, a, h=2, opt=2)