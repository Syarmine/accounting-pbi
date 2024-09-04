# Load required libraries
library(ggplot2)
library(dplyr)

# Assume columns are in order: Sales, GenderDummy
colnames(dataset) <- c('Sales', 'GenderDummy')

# Prepare the data
X <- dataset$GenderDummy
y <- dataset$Sales

# Create and fit the model
model <- lm(Sales ~ GenderDummy, data = dataset)

# Create a DataFrame with the results
results <- data.frame(
  Variable = c('Intercept', 'GenderDummy'),
  Coefficient = coef(model)
)

# Create a scatter plot
ggplot(dataset, aes(x = factor(GenderDummy), y = Sales)) +
  geom_jitter(color = '#0D6ABF', width = 0.2, alpha = 0.6) +
  labs(title = 'Sales vs GenderDummy', x = 'Gender', y = 'Sales') +
  scale_x_discrete(labels = c('0', '1')) +
  theme_minimal()

# Display the plot
print(last_plot())

# Display the results table
print(results)

# Return the results DataFrame for display in Power BI
results
