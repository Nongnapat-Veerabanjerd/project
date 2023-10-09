library(readxl)
library(caret)
library(tidyverse)
library(janitor)
library(randomForest)

# load excel file to R programming
hpi <- read_excel("House Price India.xlsx")

# clean names
hpi <- clean_names(hpi)

# 1.split data 80%:20%
train_test_split <- function(data, trainRatio) {
  set.seed(42)
  (n <- nrow(data))
  (id <- sample(1:n, size = trainRatio*n))
  
  train_data <- data[id, ]
  test_data <- data[-id, ]
  list(train = train_data, test = test_data)
}

(splitData <- train_test_split(hpi, 0.8))
train_data <- splitData$train
test_data <- splitData$test

# histogram before log price
ggplot(train_data, aes(price)) +
  geom_histogram(bins=10) +
  theme_minimal() +
  labs(
    title = "Histogram of train_data$price before log",
    x = "Train_data$price",
    y = "Frequency"
  )

ggplot(test_data, aes(price)) +
  geom_histogram(bins=10) +
  theme_minimal() +
  labs(
    title = "Histogram of test_data$price before log",
    x = "Test_data$price",
    y = "Frequency"
  )

# normalize data
train_data$price <- log(train_data$price)
test_data$price <- log(test_data$price)

# histogram after log price
# if log then อยากได้ค่าเดิมให้ใช้ exp()
ggplot(train_data, aes(price)) +
  geom_histogram(bins=10) +
  theme_minimal() +
  labs(
    title = "Histogram of train_data$price after log",
    x = "Train_data$price",
    y = "Frequency"
  )

ggplot(test_data, aes(price)) +
  geom_histogram(bins=10) +
  theme_minimal() +
  labs(
    title = "Histogram of test_data$price after log",
    x = "Test_data$price",
    y = "Frequency"
  )

# 2. train model
set.seed(42)
ctrl <- trainControl(
  method = "CV",
  number = 5 #,
  # verboseIter = TRUE
)

(lm_model <- train(price ~ number_of_bedrooms + 
                    number_of_bathrooms +
                    living_area + 
                    number_of_floors + 
                    grade_of_the_house +
                    built_year +
                    distance_from_the_airport,
                  data = train_data,
                  method = "lm",
                  trControl = ctrl))

(rf_model <- train(price ~ number_of_bedrooms + 
                       number_of_bathrooms +
                       living_area + 
                       number_of_floors + 
                       grade_of_the_house +
                       built_year +
                       distance_from_the_airport,
               data = train_data,
               method = "rf",
               trControl = ctrl))

(knn_model <- train(price ~ number_of_bedrooms + 
                    number_of_bathrooms +
                    living_area + 
                    number_of_floors + 
                    grade_of_the_house +
                    built_year +
                    distance_from_the_airport,
                  data = train_data,
                  method = "knn",
                  trControl = ctrl))

# 3. score model
p1 <- predict(lm_model, newdata = test_data)
p2 <- predict(rf_model, newdata = test_data)
p3 <- predict(knn_model, newdata = test_data)

# 4. evaluate
rmse_price <- function(actual, prediction) {
  sq_error <- (actual - prediction)**2
  sqrt(mean(sq_error))
}

rmse_price(test_data$price, p1)
rmse_price(test_data$price, p2)
rmse_price(test_data$price, p3)
















