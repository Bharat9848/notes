# Machine learning

## Types
 - Supervised learning: Features + target 
 - Unsupervised learning: features
 - Semi supervised learning

## Books
 - machine learning by Tom Mitchell
 - Data science for business understanding by Foster Provost and Tom Fawcett
 - Fawcett, Tom (2004). “ROC Graphs: Notes and Practical Considerations for Researchers.” Pattern Recognition Letters 27 (8): 882–891.
 - Hand, David J. and Till, Robert J. (2001). “A Simple Generalisation of the Area Under the ROC Curve for Multiple Class Classification Problems.” Machine Learning 45 (2): 171–186.

## Gloassary
 - **Principle component analysis**
 - **Generalization**: how model performs on unseen data.
 - *Stationary learning task* - relationship between the features and target will not change over time.
 - Regression
 - classification
 - **Standardization/ Z-score**: helps in standardizing the data between 0 and 1, so that high values do not incur extra weight.
 - **Parameter** - parameter to learning stage
 - **HyperParameter** - are the parameter passed while constructing model objects like n_neighbour in KNearestNeighbors. these are parameters set beyond learning stage. Usually tuned before model is trained. It is tuned at cross validation stage using Gridsearch or randomized search. Grid search is slow.
 - **Bias** - Model does not fit the pattern of data means it does not explain the relationship between the predictors and target.
 - **Variance**
 - **Underfitting**: Model not learning training dataset and have high training error.
 - **Overfitting** : Model learned a lot of superficial patterns. Model's training error is very small. But testing error is high.
 - **Regularization/smoothing/penalization/shrinkage**: is measure of complexity.
 - **Cost** is a function of loss and lamda times complexity
 - **cross-validation** Divide the data into buckets e.g. train n models on n buckets with n-1 training set buckets and one test bucket. How to choose k value in CV, for each problem find the min percentage needed for a good learning by plotting learning curve vs training data. `sklearn` library use stratified data sampling in case of classification problm for cross_validation calls.  
 - **Loss**
 - **Score**: bigger the score measure better it is whereas **error** measure lower is better.
 - **Stratification** 
 - **Classification ML model Assumption** For classification problem GNB make certain assumptions if those assumptions are met, we’d prefer GNB and we’d probably see it perform better classification. If those assumptions arenot met, we can fall back to SVC. From a certain perspective, SVCs make the fewest assumptions of these three models (the DA methods, logistic regression, and SVCs), sothey are the most flexible. However, that means that the other methods may do better when the assumptions are met.
 - **Classification model complexity** As we move from SVCs to logistic regression to DA, we move from (1) minimal assumptions about the data to (2) a primitive data model that relates features and targets to (3) varying degrees of assumptions about how the features are distributed, their relationships to the target, and the base rates of the targets. Logistic regression attempts to capture the relationship between the inputs and the output. In particular, it captures the probability of the output given what we know about the inputs. However, it ignores any self-contained information from the target class. For example, it would ignore knowledge from the data that a particular disease is very, very rare. In contrast, the discriminant analysis methods model both a relationship between inputs and outputs and the base probabilities of the outputs. In particular, they capture the probability of the inputs given what we know about an output and (2) stand-alone information about the output.


## Score
 - **Accuracy** how often our prediction is correct compared to reality

## Data correction
 - missing data 
  1. missing randomly
  2. missing due to some other values - natural usecase
 - categorical data - order is removed then turned into numerical values and get used.

## Phases
 - Model training - uses training test set. General recomendation is to use 50% of data
 - Model selection - uses Validation test set. General recomendation is to use 25% of data left after training reserved data.
 - Model assessment - uses hold out dataset. This dataset is only used in last phase before ML is deployed in wild. 
  1. plot ROC and Precision-recall curve for classification problem.
  2. For multi label classification problem, we can choose oneVsRest or oneVsOne strategy.
  


 General recomendation is to use 25% of data left after training reserved data and validation test data.

## Hyperparameter testing
 - validation curve
 - grid search
 - grid search is susceptible to overfitting as all of the data can be used inside the grid search. Instead nested cross-validation is more recommendable approach where grid-search will used train data from outer loop to tune hyperparameter and test data will help in tackle generalization problem.


## Algorithm training
 - train
 - test

## Algorithm

## K-nearest neighbors
 - Hyperparameter is K(number of nearest neighbors) which can only be set before the training.
 - find the distance from the nearest clusters. Less distance should be given more weightage. Hence the weight is closness which equals 1/distance.
 - To normalize the weights to one we divide each closeness/sum(closeness)
   
### Naive Bayes
 - text classification

### Logistic regression
 - uses the `log(odd(probabilty(prediction)/1-probability(prediction)))` to decide whether an example belongs to a class or not. If it is greater than zero it means it belong to a class otherwise not.  

### Support Vector machines
 - max margin separater line. 
 - support vector - vectors from opposite classes that help in finding max margin between two categories.
 - least assumption about data. 
 - Uses **hinge loss** internally where it tends to ignore small error.
 - flavors of SVR are 1. `sklearn.NvSVR` It uses `nv` parameter which controls the porportion of well kept support vectors compared to total example. 2. `sklean.SVR` with epsillon parameter which controls the error band tolerance.
 - create features internally
 - kernel can be used for some non linear problems. 1. Gaussian or RBF 2. poly
 - Use a linear kernel when the number of features is larger than number of observations. Use an RBF kernel when number of observations is larger than number of features. If there are many observations, say more than 50k, consider using a linear kernel for speed. 



### Decision tree
 - very low bias
 - high capacity or flexibility
 - prone to overfitting in case of unique ID features.
 - It negelect non-important features in case its depth is constraint. Which might be helpful in overfitting and feature selection.
  
## Algorithm evaluation
 - for classifier  we can use various basic baseline strategies e.g. uniform, prior, stratified, most_frequent, constant etc. 
 - `Accuracy` is a measure of model performance, given number of dataset what percentage of it model was able to evaluate correctly.

# Regression
 ## Evaluation
  1. `R2` computed as `1-(MSE of model/MSE of mean of testing set)`
  2. `mean squared error(MSE)` : It penalize errors away from center more than the errors which are nearby to center.
  3. `mean absolute error(MAE)` : it penalize error equally irrespective the distance from the mean.
  4. `median absolute error`
  5. Draw horizontal and vertical distance graph b/w predicted vs horizontal
  6. Residual plot - plot between the prediction and residual.
  7. **Lasso Regression** or **L1 regularize regression**  - Try to balance the loss with absolute sum of weights. It tries to push the cofficient of some features to zero. Hence it automatically do feature selection.  
  8. **Ridge regression** or **L2 regularize regression**  Try to balance the loss with square sum of weights.
  9. When to use regularize model - when we are seeing overfitting errors. Regularization will help in reducing the complexity of the model and make it less overfitting.


# Ensamble
 - different component give different result on partial features. Individual results must be combined tot get result.
 - Different models learn the whole problem the results uses some aggregation method like mean or majority votes.
 - **Stacking** - Different model like linear regressor and decision regressor are combined.
 - **Bagging** - train multiple same type of model. To make models independent of each other, we need bootstrapping sampling technique. Bagging reduces the variance part of the (bias-variance) equation. It does not improve bias which primarily depends upon the base model.
 - Random forest - is an bagging ensamble of decision trees. Additionally it chooses random sets of feature for each tree.
 - Extreme Random forest is random forest with some of decision points within each decision tree is random. 
 - **Boosting** - ensamble of same type usually (decision tree of depth-1) trained on the weighted data with more weight on hard example.
  1. AdaBoostClassifier
  2. GradientBoostingClassifier : it is generic with loss function.
  - For boosting models we can use `stage_predict` instead of `predict` it gives model performance through the cycle of reweighting. It will give insight into how each reweighting is contributing to overall model performance


# Classification
 ## Multi-classificatopm
 - `oneVsOne`
 - `oneVsRest`
 ## Stats
 - `Ginni index`
 
 ## Evaluation

  - For classification problems we check score in term of positive and negative classes. Postive class is more risky/interesting/less likely.
   - **Sensitivity** | **Recall** | **True positive rate** It measure how much sensitive our model is for measuring the rare positive class. Mathematically `True-positive/All-positive`
   - **Specificity** | **True Negative rate** Of all the real world negative cases how much were true negative predicted by our model . Mathematically `True negative/All-negative` 
   - **Precision** Of the total predicted positive class, how much of it was true positive. Mathematically `True positive/All predicted positive`
   - `sklearn` prediction score type `macro` is mean of precisions of each class in multi-class classification problem. `sklearn.classification_report` gives weighted avg of precision and recall
   - **F1 score** - provides harmonic mean of each class equal weights to precision and recall.
   - **ROC curve** - helps in finding the ideal threshold for selecting positive classes. x-axis represent false positive rate and y axis represent true positive rate. Ideal situation is to have TPR=1 and FPR=0. Threshold choice also depends upon problem if want how sensitive we want our model to be. It is good to choose threshold for which give roc curve nearer to upper left corner.
   - **AUC** summaries measure of center from ROC tells the overall performance of the model. More area it covers more the model performance.   


## Feature engineering
 - **data wrangling** - 
 - **Scaling or normalization**
 - **Filling missing values** entails understandng the sample collection process and take a intuitive descision about the missing values by discarding the sample, fill the missing value based on some heuristic etc.
 - **Feature selection** - discard unimportant features
  1. identification variables does not help in generalization e.g ID columns. It is harmful in case of descision tree.
  2. Discard feature using information gain methodology
  3. discard feature with lower cofficients - as in Lasso regularization
  4. we can discard less variance normalized features. It require GridSearch to select good variance threshold.
  5. certain models rank the feature according to the model nature. we can use their rank to select features. We can use `Recursive feature elimination` technique that gives feature according to their importance. 

 - **Feature construction** - reexpressing current feature.
  1. coding feature categories
  2. combining two features.
  3. Discretization - Divide feature values into bins. Its better to be done in crossvalidation pipeline. Other option is to do it in data preprocessing for data exploration.
  4. **kernel** method - models have builtin kernel support which automatically creates features. Kernel method do pairwise covariance between all the sample data and add them as new features.**Nystroem** is an out of the box kernel it consider less number of sample to compute covariance feature in case the data set is very large otherwise without sampling of data it will cause large memory footprint. Internally kernel take examples' features in higher dimension and then measure similarity. Some more examples of kernel are - 1. **poly** - polynomial with degree 2. Gaussian or Radial Bias Function(RBF).
  5. Principle Component Analysis - data driven axis - maximum variance and minimum error 

 - **Feature extraction**
  1. more complex way to extract feature from low value feature to high value feature.

## practical
 - Dataset
  [UCI](https://archive.ics.uci.edu/ml/datasets.html)
  [Kaggle](www.kaggle.com/datasets)
 - how to detect irrelevent feature ?
 - cause of randomness in data 1. naturally random 2. appears random as we are missing some data.
 - how to detect data shift
 - sklearn: datasets.load_boston 
 - plot ROC curve and find best threshold for classification problem.
 - plot boundries from classification method using two of the features and color code the classes.
 - how cross validation detects overfitting
## to read
 - computational learning theory
 - multimodal distribution