# Load required libraries
library(ggplot2)
library(dplyr)

# Assuming 'dataset' is your Power BI dataset

# Scatter plot
ggplot(dataset, aes(x = Income, y = Sales)) +
  geom_point(color = '#0D6ABF', alpha = 0.6) +
  labs(x = 'Income', y = 'Sales', title = 'Scatter Plot Income vs Sales') +
  theme_minimal()

# Fit a linear regression model
model <- lm(Sales ~ Income, data = dataset)

# Create data for the regression line
income_range <- seq(min(dataset$Income), max(dataset$Income), length.out = 100)
predicted_sales <- predict(model, newdata = data.frame(Income = income_range))

# Add the regression line to the plot
ggplot(dataset, aes(x = Income, y = Sales)) +
  geom_point(color = '#0D6ABF', alpha = 0.6) +
  geom_line(data = data.frame(Income = income_range, Sales = predicted_sales), 
            aes(x = Income, y = Sales), color = 'red', size = 1) +
  labs(x = 'Income', y = 'Sales', title = 'Scatter Plot Income vs Sales') +
  theme_minimal()

# Display the plot
print(last_plot())
