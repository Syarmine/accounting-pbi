# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# Paste or type your script code here:
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LinearRegression

# dataset is the DataFrame provided by Power BI
# Scatter plot
plt.figure(figsize=(10, 6))
plt.scatter(dataset['Income'], dataset['Sales'], color='#0D6ABF', label='Data points')

# Fit a linear regression model
model = LinearRegression()
X = dataset[['Income']]  # Independent variable
y = dataset['Sales']  # Dependent variable
model.fit(X, y)

# Predict values for the line
X_fit = pd.DataFrame({'Income': range(int(dataset['Income'].min()), int(dataset['Income'].max()) + 1)})
y_fit = model.predict(X_fit)

# Plot the regression line
plt.plot(X_fit, y_fit, color='red', linewidth=2, label='Fit Line')

# Add labels and title
plt.xlabel('Income')
plt.ylabel('Sales')
plt.title('Scatter Plot Income vs Sales')
plt.legend()

# Show plot
plt.show()


