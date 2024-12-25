# Multiple-Linear-Regression
## Packages used

```r
if (!require(readxl)) install.packages("readxl")
if (!require(car)) install.packages("car")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(plotly)) install.packages("plotly")

library(readxl)
library(ggplot2)
library(car) 
library(plotly)
```
**`ggplot2`**: Creates detailed, publication-quality plots.  
**`car`**: Calculates Variance Inflation Factor (VIF) to detect multicollinearity.  
**`plotly`**: Creates interactive 3D scatterplots.

## Load The Data set
```r
file_path <- "~/Campus/STATPROB/Multiple_Linear_Regression_Data.xlsx" # Specify the file path
data <- read_excel(file_path)
```
The **`Data Set file`** can be found on this repository named **`Multiple_Linear_Regression_Data.xlsx`**

### Importing the Dataset
```r
data <- read_excel(file_path)
head(data)
```
**`Purpose`**: Load the dataset from the file data <- read_excel(file_path) and display the first few rows using head().  
The dataset contains columns: Salary, Age, Experience, and Education_Level.

### Checking the Structure of the Data
```r
str(data)
summary(data)
```
**`str(data)`**: Displays the structure of the dataset, including data types for each variable (e.g., numeric, factor).  
**`summary(data)`**: Provides a statistical summary of each column (e.g., mean, median, min, max).  

## Fitting the Multiple Linear Regression Model
```r
model <- lm(Salary ~ Age + Experience + Education_Level, data = data)
summary(model)
```
Fit a multiple linear regression model with **`Salary`** as the dependent variable and **`Age`**, **`Experience`**, and **`Education_Level`** as independent variables.  
 **`lm()`**: Fits the linear model.  
* **`summary(model)`**: Outputs important statistics like:  
  * **Coefficients** (
𝛽
0
,
𝛽
1
,
𝛽
2
,
…
 ,…): Shows the effect of each predictor on **`Salary`**.
  * R<sup>2</sup>
 : Explains how much variance in **`Salary`** is explained by the predictors.
  * **p-values**: Tests the statistical significance of predictors.
  * **F-statistic**: Tests the overall significance of the model.

## Checking Assumptions
### Linearity
```r
par(mfrow = c(2, 2))
plot(model)
```
* **Purpose**: Creates diagnostic plots to check
   1. Residuals vs. Fitted: Checks linearity.
   2. Normal Q-Q Plot: Assesses normality of residuals.
   3. Normal Q-Q Plot: Assesses normality of residuals.
   4. Residuals vs. Leverage: Identifies influential points.

### Multicollinearity
```r
vif_values <- vif(model)
print(vif_values)
```
* **Purpose**: Calculate Variance Inflation Factor (VIF) to detect multicollinearity.
  * VIF > 5 indicates potential multicollinearity.

 ### Normality of Residuals
 ```r
shapiro_test <- shapiro.test(residuals(model)) # Shapiro-Wilk test
print(shapiro_test)
```
* **Purpose**: Perform the Shapiro-Wilk test to check if residuals follow a normal distribution.
  * A p-value > 0.05 suggests residuals are approximately normal.

## Visualization
### Pairwise Relationships
```r
pairs(data[, c("Age", "Experience", "Education_Level", "Salary")], panel = panel.smooth)
```
* **Purpose**:  Create a scatterplot matrix showing relationships between all variables, with linear trends for visual confirmation of relationships.

### Actual vs Predicted Plot
```r
data$predicted <- predict(model)
ggplot(data, aes(x = predicted, y = Salary)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Actual vs Predicted Values", x = "Predicted", y = "Actual") +
  theme_minimal()
```
* **Purpose**: Visualize how well the predicted values align with the actual values of **`Salary`**.
  * Blue points: Observations.
  * Red line: Trend line showing model fit.

### 3D Visualization
```r
fig <- plot_ly(data, x = ~Age, y = ~Experience, z = ~Salary, 
               type = 'scatter3d', mode = 'markers',
               marker = list(size = 3, color = ~Salary, colorscale = 'Viridis')) %>%
  layout(scene = list(
    xaxis = list(title = 'Age'),
    yaxis = list(title = 'Experience'),
    zaxis = list(title = 'Salary')
  ))
fig
```
* **Purpose**: Interactive 3D scatterplot showing the relationship between **`Age`**, **`Experience`**, and **`Salary`**.

## Interpretation
```r
cat("\n--- Interpretation ---\n")
cat("Coefficients:\n")
print(coef(model))

cat("\nThe model suggests that:\n")
cat("1. For every unit increase in Age, the dependent variable Salary changes by", coef(model)["Age"], "units, holding other predictors constant.\n")
cat("2. For every unit increase in Experience, Salary changes by", coef(model)["Experience"], "units, holding other predictors constant.\n")
cat("3. For every unit increase in Education_Level, Salary changes by", coef(model)["Education_Level"], "units, holding other predictors constant.\n")

cat("\nAssumptions:\n")
cat("- Linearity is checked through diagnostic plots.\n")
cat("- Multicollinearity is assessed using VIF (all values should ideally be < 5).\n")
cat("- Residual normality is evaluated using the Shapiro-Wilk test. A p-value > 0.05 indicates normality.\n")
```
* **Purpose**: Summarize findings and interpret the results, highlighting the relationships and assumptions tested.
