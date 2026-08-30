# books and references
- Dietterich, Thomas G. (1998). “Approximate Statistical Tests for Comparing Supervised Classification Learning Algorithms.” Neural Computation 10 (7):
- Applied Linear Statistical Models by Kutner and friends
- What You Can and Can’t Properly Do with Regression,” Richard Berk
- Practical Regression and Anova in R by Faraway
- Section 2.2.4 of Advanced Data Analysis from an Elementary Point of View by Shalizi 1895–1923

# Basics definition
- Expectation: True mean of a population which cannot be measure in reality due to sheer number of volume and cost.
- Standard Error: standard deviation of an aggregate measurement is called standard error. It is difficult to get standard error as it will require lot of aggregate measurements. Therefore its estimated from a standard deviation of single aggregated measurement as 
`se = std/sqrt(N)`
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

# Distributions
 -- see probability notes

# Bias
 - Sampling Bias: Sampling don under different condition resulting into different data.
 - Confounder Bias : some bias is applied differently and consistently results in different result.



# Central limit theorem
  - It is an observation phenomenon where even if data is not normally distributed the sample statistics observed from samples are normally distributed.
  - Sample distribution is the distribution of sample statistics like mean over mutliple sampling. Sample statistics from sample distribution is more bell curve than the actual data distribution. Also more the sample size more bell curved the test statistics would be.
  - It has major contribution in hypothesis testing and confidence interval.
  - central limit theorem states that the sampling distribution (the distribution of point estimates) will approach a normal distribution as we increase the number of samples taken. A sampling distribution is a distribution of several point estimates.
  - Standerd error measures the variablity in a single sample statistics.

# confidence interval:
  - It covers the central region of a sample statistics data. It signifies that further sampling will likely to produce(some percentage) sample statistic that will lie in same central region. More generally an 95% confidence interval around a sample estimate should on average contain similar sample in 95% of the time. To do true estimate and if you have less data more confident you want to be then you have to choose a wider confidence interval. Confidence interval means how variable a sample estimate might be. A confidence interval is a range of values based on a point estimate that contains the true population parameter at some confidence level. A confidence level does not represent a “probability of being correct”; instead, it represents the frequency that the obtained answer will be accurate.

-----
# Testing
## AB Testing
-- see ABExperiment Notes

##  Hypothesis testing
- Statistical hypothesis testing was invented as a way to protect researcher from crediting random chances to some significance. Null hypothesis test further to the A/B testing. To determine whether the observed sample data deviates from what was to be expected from the population itself. A hypothesis test generally looks at two opposing hypotheses about a population. They are called the null hypothesis and the alternative hypothesis. The null hypothesis is the statement being tested and is the default correct answer. The alternative hypothesis is the statement that opposes the null hypothesis. Our test will tell us which hypothesis we should trust and which we should reject.

- p-value is the probability that results as extreme as observed can occur given the null hypothesis model. p-value does not measure that given hypothesis is true, It alone should be considered as proof for hypothesis. A P-value less than or equal to 0.05 leads to the rejection of the null hypothesis, considering it highly improbable. Conversely, a P-value greater than 0.05 results in accepting or “failing to reject” thenull hypothesis. When the P-value hovers around 0.05, further scrutiny of the hypothesis is warranted.

- **Type 1 error**/False Positive: Consider an hypothesis true but it is purly a chance.  
- **Type 2 error**/ False Negative: Reject an hypothesis but even if it is true. 
 
- **One sided test**
 
- **Two sided test**
 
- **Statistically significant**: when the result is beyond the realm of chance variation.

## Chi-square test
 - Very effective of categorical features.
 - It is used with count data to see how fit it is the expected distribution. Chi-square statistics measure the dispersion between expected and observed data. Chi square distribution is skewed with a long tail to the right.
 - provides p-values that signify dependence between two random variable
 - Chisquare score `X^2 =  SumAll(Osubi - Esubi)^2/Esubi`
 - "categorical data, especially where the relationship between features and the target variable is non-linear, chi-squared proves to be a valuable method for feature selection. However, its suitability diminishes for continuous or highly correlated features, where alternative feature selection methods may be more fitting."

# References
 - Dangeti, Pratap. Statistics for machine learning. Packt Publishing Ltd, 2017.
 - Introductory Statistics and Analytics: A Resampling Perspective by Peter Bruce
 - The Drunkard’s Walk by Leonard Mlodinow (Vintage Books, 2008) is a readable survey of the ways in which “randomness rules our lives.”
 - David Freedman, Robert Pisani, and Roger Purves’s classic statistics text Statistics, 4th ed. (W. W. Norton, 2007) 

    Measuring center of dataset : 1. Mean is sensitive to outliers its beneficial to use mean if dataset member are close to each other or variation in dataset is minimum. one minute/hour rollup (???). If it is used for measurement then it can lead to spike erosion as the mean data averages out over the large period of time. sample mean is represented using x-bar and population mean is represented using greek symbol mue. 2. Median: On the other hand median of sorted dataset is not sensitive to outliers, then its a good measurement of center if your dataset is suffering from outliers. median is less sensitive to data than mean. 3. Mode highest frequency value. its mainly used for categorical data or proportional data.

    Measuring tail of dataset: 1. Quantile is a flexible tool that offers an alternative to the classical summary statistics which is less susceptible to outliers.The (empirical) cumulative distribution function CDF(y) for dataset X, at a value y, is the ratio of samples that are lower than the value y.

    Measuring variation or dispersion in dataset. 1. Standerd deviation 2. Mean absolute deviation/Median absolute deviation 3. Percentile or quartile 4. InterQuartile range: is difference between 25th percentile and 75 percentile after sorting the data. Its less succeptible to outliers.

    The coefficient of variation is defined as the ratio of the data’s standard deviation to its mean.We use this measure frequently when attempting to compare means, and it spreads across populations that exist at different scales.

    The z-score is a way of telling us how far away a single data value is from the mean. By replacing each value with its z-score is same as original data value. It is a very effective way of normalizing data that exists on very different scales, and also to put data in context of their mean.

    Assumption : Many statistical tests and hypotheses require the underlying data to come from a normally distributed population.

    A desirable property is robustness against outliers. A single faulty measurement should not change a rough description of the dataset.

    Correlation simply quantifies the degree to which variables change together.
    Reasons for correlation b/w two variables
        causation is the idea that one variable actually determines the value of another. It is based on cofounding factor. While Cofounding factor is a third random variable that direct show the causation betweeen two correlated variables
        conincidence . While coincidence shows that correlation does not imply causation. When we ignore cofounding variables then correlation become very misleading.

    Simpson paradox shows there might be another cofounded variable which can break the hypothesis of two correlated variables by showing anti-correlation. The main takeaway from Simpson’s paradox is that we should not unduly give causational power to correlated variables. There might be confounding variables that have to be examined.

    Correlation cofficient for Bivariate analysis
    It describe the relation between two variables. Relationship might go from linear to polynomial based on level of fitness that can be find out by mapping different model on testing data.
    The hypothesis relationship between two variable must be tested further. We will need to use more sophisticated statistical methods and machine learning algorithms to solidify these assumptions and hypotheses.
    Its value can be in between -1 to 1.

    Correlation cofficient is also sensitive to outliers.

    Correlation matrix is a matrix representaion of two or more random variables correlation cofficients e.g. X Y {{1.00 0.67} {0.67 1.00}}. Note correlation cofficient is 1 for a variable with itself since its perfectly correlatable with itself.

    Sampling
    Big data use cases are when not only data is in big quantity but also when its sparse enough.
    Two main type of resampling technique : Bootstating and permutation tests. In permutation test multiple dataset are combined and resuffled. Then datasets are again choosen in same numbers as the original size and statistics of interest again completed.
    The number of degree of freedom forms the calculation to standerdize test statistics so that they can be compared to reference distribution e.g. t-distribution and F-distribtion. The concept of Degree of freedom lies behind factoring of categorical variables into n-1 indicator or dummy variables when doing regression (to avoid multicollinearity)
    Sampling with replacement : choosing an element from the population for the sample but also put copy of element again in the popultion to get rechoosen again.
    Sample bias is when bad data is choosen which does not represent all the members of population equally or proportionaly. It results into wrong predictions. Stratified Sampling is used to solve sample bias. Given a population with homogenous subgroup then sampling according to proportion of a strata is what entails the stratified sampling

    Error bias is other form of bias in which data is incorrect due to incorrect sampling process.

    Student-t distribution: its a normal distribution but its thicker and longer in tails. Its extensively used in depicting sample distributions of sample statistics.
    For events that occur at constant rate of event per unit time or space Poisson distribution can be more appropriate.

    In constant rate scenario if we want to model the time or space between two subsequent event, we can use exponential distribution- A changing event over time can be modelled with the Weibull distribution.





(RMSE), - Residual standard error (RSE) is same as Root mean square error(RMSE) as but have additional degree of freedom in the denominator. - R2 (R-square) is the matrics for seeing how fit the data is fit to the model is. its R2=1- Sum(actual(y)-predicted(y))/ sum(actual(y)-mean(y)). - t-statistics is (coficient)/standard error(cofficient) tells the significance level of cofficient. Higher the t value is more significant the predictor is. Stepwise regression is a way to automatically determine which variable should be included in model.Confidence intervals quantify uncertainty around regression Prediction.coefficients intervals quantify uncertainty in individual predictions. - Correlation of multi-variate variables: When predicator variables are highly correlated with each other (e.g. houseSize and noOfBedroom in regression to estimate house price ) then its very difficult to interpret correlation cofficients. When predictor variables are perfect or near-perfect correlated to each other, then regression is very difficult to compute this is called Multicollinearnity.This is equivalent to include a predictor multiple times in regression equation. B. Cofounding variable if we forgot to include an important varaiable (e.g. location in equation of house price) in regression equation then this can lead to unstable predictions. C. Main effect(Predictor variables) often have intractions which should also be included in the regression material.

Regression Diagnostics: A. Standardized residual which is calculated by dividing residual by standardized error can be used to predict outlier. Outlier can also be used to find anomaly, frauds and accident detection. B. A record /values which change the regression formula significantly known as influental value/observation. This observation have high leverage on regression equation. Hat values and cook’s distance can be used to measure influence. In small no of observations removing influential value can lead to more fitting regression model while in large amount of data you will rarely sees influential data observations. C.Heteroskedasticity : your model is suffering from heteroskedasticity if variance or residuals is more in some range of data. It should be constant across the range of data. It means regression model have miss something or incomplete. D. Partial residual plot: can be used to see relationship between individual predictor variable and the output variable qualitatively. The relationship can be non-linear which means non-linear regression model should be used. 