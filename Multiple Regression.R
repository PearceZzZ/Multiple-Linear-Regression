
if (!require(readxl)) install.packages("readxl")
if (!require(car)) install.packages("car")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(plotly)) install.packages("plotly")


# Load necessary libraries
library(readxl)
library(ggplot2)
library(car) # For VIF calculation
library(plotly) # For 3D visualization

# 1. Load the dataset
file_path <- "~/Campus/STATPROB/Multiple_Linear_Regression_Data.xlsx" # Specify the file path
data <- read_excel(file_path)

# 2. Inspect the dataset
head(data)
str(data)
summary(data)

# 3. Fit the Multiple Linear Regression Model
model <- lm(Salary ~ Age + Experience + Education_Level, data = data)
summary(model) # Display model summary

# 4. Assumption Checks
## 4.1 Linearity
par(mfrow = c(2, 2)) # Set layout for diagnostic plots
plot(model) # Diagnostic plots

## 4.2 Multicollinearity
vif_values <- vif(model) # Variance Inflation Factor
print(vif_values)

## 4.3 Normality of Residuals
shapiro_test <- shapiro.test(residuals(model)) # Shapiro-Wilk test
print(shapiro_test)

# 5. Visualization
## 5.1 Scatterplot matrix with linear trend lines
pairs(data[, c("Age", "Experience", "Education_Level", "Salary")], panel = panel.smooth)

## 5.2 Visualize actual vs predicted values
data$Predicted <- predict(model)
ggplot(data, aes(x = Predicted, y = Salary)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Actual vs Predicted Values", x = "Predicted Salary", y = "Actual Salary") +
  theme_minimal()

## 5.3 3D Visualization with plotly
fig <- plot_ly(data, x = ~Age, y = ~Experience, z = ~Salary, type = 'scatter3d', mode = 'markers',
               marker = list(size = 3, color = ~Salary, colorscale = 'Viridis')) %>%
  layout(scene = list(
    xaxis = list(title = 'Age'),
    yaxis = list(title = 'Experience'),
    zaxis = list(title = 'Salary')
  ))
fig

# 6. Interpretation
cat("\n--- Interpretation ---\n")
cat("Coefficients:\n")
print(coef(model))

cat("\nThe model suggests that:\n")
cat("1. For every unit increase in Age, the dependent variable Salary changes by", coef(model)["Age"], "units, holding other predictors constant.\n")
cat("2. For every unit increase in Experience, the dependent variable Salary changes by", coef(model)["Experience"], "units, holding other predictors constant.\n")
cat("3. For every unit increase in Education_Level, the dependent variable Salary changes by", coef(model)["Education_Level"], "units, holding other predictors constant.\n")

cat("\nAssumptions:\n")
cat("- Linearity is checked through diagnostic plots.\n")
cat("- Multicollinearity is assessed using VIF (all values should ideally be < 5).\n")
cat("- Residual normality is evaluated using the Shapiro-Wilk test. A p-value > 0.05 indicates normality.\n")
