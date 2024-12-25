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

## Importing the Dataset
```r
data <- read.csv("Salary_Data.csv")
head(data)
```
**`Purpose`**: Load the dataset from the file Salary_Data.csv and display the first few rows using head().
The dataset contains columns: Salary, Age, Experience, and Education_Level.
