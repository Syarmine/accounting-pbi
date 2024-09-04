import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# Assume columns are in order: Sales, Income, Age, GenderDummy
dataset.columns = ['Sales', 'GenderDummy']

# Prepare the data
X = dataset[['GenderDummy']]
y = dataset['Sales']

# Create and fit the model
model = LinearRegression()
model.fit(X, y)

# Create a DataFrame with the results
results = pd.DataFrame({
    'Variable': ['Intercept', 'GenderDummy'],
    'Coefficient': [model.intercept_] + list(model.coef_)
})

# Create a scatter plot
plt.figure(figsize=(10, 6))
plt.scatter(dataset['Sales'], dataset['GenderDummy'], color='#0D6ABF')
plt.title('Sales vs GenderDummy')
plt.xlabel('Gender')
plt.ylabel('Sales')
plt.xticks([0, 1], ['0', '1'])
plt.xlim(-0.1, 1.1)
plt.show()

# Display the results table
print(results)

# Return the results DataFrame for display in Power BI
results