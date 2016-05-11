## Mauna Loa Prediction Contest
This repository contains several scripts forecasting CO<sub>2</sub> measurements at the Mauna Loa Observatory. This is part of a project for a Time Series Analysis class, where the task is to use the methods we learned in class to predict the April 2016 mean CO<sub>2</sub> level given past monthly measurements through February 2016.

#### arma_classical

We first attempt to model the time series using classical estimation to estimate a linear trend and seasonal component, modeling the residuals with an ARMA model. However, we found that the residuals are not stationary in this situation (the trend looks like it may be quadratic, not linear), so modeling them as an ARMA process is incorrect.

#### arma_differencing

This approach uses differencing to remove trend and seasonality, and fits an ARMA model to the residuals. The residuals appear stationary in this situation, so using ARMA may be appropriate.

#### arima_classical

We tried to fix the problem of non-stationary residuals after classical estimation by fitting an ARIMA model to the residuals, which does not require stationarity. It doesn't make much sense ARIMA *after* removing the trend and season doesn't make much sense when the trend and seasonality can be accounted for in a seasonal ARIMA model anyway, but we didn't know much about ARIMA at this point (due to not having covered it in class yet) and submitted the results from this script for our project.

#### seasonal_arima

This script simply fits a seasonal ARIMA model to the data. This approach seems best to me, but the prediction results don't end up being very close to the true value (not that the other models do particularly well, as the April measurement turns out to be quite high).
