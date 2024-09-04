# Load required libraries
library(ggplot2)
library(dplyr)

# Assuming 'dataset' is your Power BI dataset

# Scatter plot
ggplot(dataset, aes(x = Age, y = Sales)) +
  geom_point(color = '#0D6ABF', alpha = 0.6) +
  labs(x = 'Age', y = 'Sales', title = 'Scatter Plot Age vs. Sales') +
  theme_minimal()

# Fit a linear regression model
model <- lm(Sales ~ Age, data = dataset)

# Create data for the regression line
age_range <- seq(min(dataset$Age), max(dataset$Age), length.out = 100)
predicted_sales <- predict(model, newdata = data.frame(Age = age_range))

# Add the regression line to the plot
ggplot(dataset, aes(x = Age, y = Sales)) +
  geom_point(color = '#0D6ABF', alpha = 0.6) +
  geom_line(data = data.frame(Age = age_range, Sales = predicted_sales), 
            aes(x = Age, y = Sales), color = 'red', size = 1) +
  labs(x = 'Age', y = 'Sales', title = 'Scatter Plot Age vs. Sales') +
  theme_minimal()

# Display the plot
print(last_plot())
