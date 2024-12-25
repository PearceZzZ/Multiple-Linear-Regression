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

### Checking Assumptions
## Linearity
```r
par(mfrow = c(2, 2))
plot(model)
```
* **Purpose**: Creates diagnostic plots to check
   1. Residuals vs. Fitted: Checks linearity.
   2. Normal Q-Q Plot: Assesses normality of residuals.
   3. Normal Q-Q Plot: Assesses normality of residuals.
   4. Residuals vs. Leverage: Identifies influential points.

## Multicollinearity
```r
vif_values <- vif(model)
print(vif_values)
```
* **Purpose**: Calculate Variance Inflation Factor (VIF) to detect multicollinearity.
  * VIF > 5 indicates potential multicollinearity.

 ## Normality of Residuals
 ```r
shapiro_test <- shapiro.test(residuals(model)) # Shapiro-Wilk test
print(shapiro_test)
```
* **Purpose**: Perform the Shapiro-Wilk test to check if residuals follow a normal distribution.
  * A p-value > 0.05 suggests residuals are approximately normal.

### Visualization
