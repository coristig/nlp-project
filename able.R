

# simple credit dataset
df <- read.csv("~/repos/yhat/blog/code-exp/18/credit-data.csv")

# really simple credit model
df$revolving_utilization_of_unsecured_lines_sq <- df$revolving_utilization_of_unsecured_lines^2
fit <- glm(serious_dlqin2yrs ~ revolving_utilization_of_unsecured_lines + age + debt_ratio +
             number_of_times90_days_late, data=df, family=binomial())
fit

library(yhatr)

model.require <- function() {
  # nothing required
}

model.transform <- function(df) {
  df$revolving_utilization_of_unsecured_lines_sq <- df$revolving_utilization_of_unsecured_lines^2
  df
}

model.predict <- function(df) {
  prob <- predict(fit, df, type="response")
  data.frame(prob_delinquent=prob, message="glenn is cool")
}

yhat.config <- c(
  username="demo",
  apikey="ae5ca2c170cd44829b3787eef008d1bb",
  env="http://demo.yhathq.com/"
)

yhat.deploy("AbleDemo")

testcase <- head(df, 1)
testcase
yhat.predict("AbleDemo", testcase)

library(jsonlite)
cat(jsonlite::toJSON(testcase))




