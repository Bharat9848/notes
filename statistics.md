# books and references
- Dietterich, Thomas G. (1998). “Approximate Statistical Tests for Comparing Supervised Classification Learning Algorithms.” Neural Computation 10 (7):
- Applied Linear Statistical Models by Kutner and friends
- What You Can and Can’t Properly Do with Regression,” Richard Berk
- Practical Regression and Anova in R by Faraway
- Section 2.2.4 of Advanced Data Analysis from an Elementary Point of View by Shalizi

1895–1923
# Distribution
1. Normal distribution
  - formula `1/(2.Pie.spread)^1/2  * e^(-1/2 * (x-center/spread)^2) `
2. binomial distribution.

- Expected mean is weighted average.

# Distribution summary
 - mean, median and mode, standard deviation
 - Summary metrics are sensitive to outliers we should consider inter-quartile range.
 - Correlation: Covariance becomes easier to understand when we normalize it by the variance of its parts i.e. `cov(X,Y)/ sqrt(var(X) * var(Y))` . It tells the linear relationship between X and Y.
# classification problem = Discriment analysis 
1. Quadaratic DA: possibly different covariance matrices per class,
2. Linear DA: same covariance matrix for all classes,
3. Gaussian Naive Bayes: different diagonal covariance matrices per class, and
4. Diagnol Linear DA: same diagonal covariance matrix for all classes.
