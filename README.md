---
# statsUtils

`statsUtils` is a lightweight R package designed to streamline common steps in preparing for statistical analyses. It provides tools for summarizing data by groups and checking ANOVA assumptions such as normality, outliers, and homogeneity of variances.

## ✨ Features

- Summarize group-wise means and standard deviations
- Detect outliers using the IQR rule
- Perform Shapiro-Wilk normality tests for each group
- Run Levene's test for homogeneity of variances
- Return clean, structured output for downstream use
- Optional verbose printing for integration in analysis reports

---

## 📦 Installation

```r
# Install from GitHub using devtools
install.packages("devtools")
devtools::install_github("yourusername/statsUtils")
````

---

## 🧠 Usage

### Load the package

```r
library(statsUtils)
```

### 1. Summarize your data

```r
data <- data.frame(
  group = rep(c("A", "B"), each = 5),
  value = c(5.2, 4.9, 5.5, 5.1, 5.3, 6.8, 6.9, 6.7, 7.0, 6.5)
)

data_summary(data, varname = "value", groupnames = "group")
```

### 2. Check ANOVA assumptions

```r
check_anova_assumptions(
  data = data,
  response = "value",
  group = "group",
  return_results = TRUE
)
```

---

## 📚 Functions

### `data_summary()`

Summarizes a numeric variable by groups.

* **Arguments**:

  * `data`: A data frame
  * `varname`: Name of the numeric variable (string or unquoted)
  * `groupnames`: One or more grouping variable names (strings)

* **Returns**: Data frame with group means and standard deviations.

---

### `check_anova_assumptions()`

Checks for outliers, normality, and variance homogeneity before ANOVA.

* **Arguments**:

  * `data`: A data frame
  * `response`: Name of the numeric response variable (string)
  * `group`: Grouping variable name (string)
  * `return_results`: If `TRUE`, returns results in a list
  * `verbose`: If `TRUE`, prints results to the console

* **Returns**: A list (if `return_results = TRUE`) with:

  * `outlier_results`
  * `normality_results`
  * `levene_test`

---

## 🔧 Development

To contribute:

1. Fork this repo
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -am 'Add feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Create a Pull Request

---

## 📄 License

This package is released under the MIT License.

---

## 💬 Feedback

Feel free to open an [issue](https://github.com/yourusername/statsUtils/issues) or suggest improvements through a pull request.

```
