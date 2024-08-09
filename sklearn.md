## model_selection modules
 - `cross_val_score(<model>, <all_feature>, <all_target>, cv=<noOfCrossValidationSet>, score=<scoring strategy> , scoring=<custom_scorer>)` returns array of scores of size noOfCrossValidationSet using scoring algo
 - `cross_val_predict` to plot confusion matrix in classification problem.
 - `cross_validate`
 - `validation_curve`
 - `GridSearchCV(<model>, param_grid=<map[hyperparameter: list]>, cv=<noOfCrossValidaion>, return_train_score=True|False)` returns the output in property `cv_results_`
 - `RandomizedSearchCV(model, param_distribution=<Map[key: distribtion]>,cv=no, n_iter=no)` param_distribution is a distribution type object	

## metric modules
 - `sklearn.metrics.get_scorer_names()` gives all different scorer available in library 
 - `make_scorer(method)` creates a scorer which take method. Method retuns score higher the number better. The method take `test_ftrs` and `predictor` and return score.

## Dummy module
 - `DummyRegressor` with 'constant', 'quantile', 'mean', 'median' strategies can be used for baseline. 

## Svm module
 - `SVC(kernel='linear|...')`
 - `LinearSVC`
 - `NuSVC(kernel='linear|...', nu=0.8)`
 - plot lines based on C parameter for SVC
 - plot lines based on nu parameter for SVC

## neighbors module
 - `KNeighborsClassifier` `n_neighbors` argument signify number of neighbors

## tree module
 - `DecisionTreeClassifier` `max_depth` argument signify the depth of the tree.
 - `ginni index` 
 - `pydotplus` library generates decison tree images.

## preprocessing module
 - `Transformer` have fit and transform method e.g. `StandardScaler` learns mean and deviation from training data and the applies it using transform. `MinMaxScaler` scales the feature based on min-max range.
 - `binarize(<col>, partition)` returns new column and with values lower than partition as zero and greater and equal as 1
 - `PolynomialFeatures(degree=n, interaction_only=True|False, include_bias=True|False)` creates addition polynomial features of given degree. Interaction only argument signify self exponential e.g. x^n features is not required.
 

## pipeline module 
 - pipeline, primary purpose is to find good hyperparameter
 - `make_pipeline` creates a `pipeline` of transformer and predictor. It have the same `fit` and `predict` method as predictors. `predict` method calls transform method internally.
 - `pipeline.Pipeline(steps=Map<key, value>)`

## ensemble module
 - `VotingClassifier(clasifier...)` use majority vote from all the given classifiers.

## linear_model
 -`LogisticRegression(solver='saga|...' multi_class='multinomial...' max_iter=1000)` Solver param `saga` is used for multiclass problems
 -`SGDClassifier(loss='log'|..., max_iter=1000)`  `log` loss param make SGDClassifier to behave like logisticRegression 

## feature_selection module
 - `VarianceThreshold` used to discard features with given threshold.
 - `f_regression` returns the feature scores based on the correlation.
 - `mutual_info_classif(data, tgt, discrete_features=False)` gives information gain between features from given data and target
 - `mutual_info_regression(data, tgt, discrete_features=False)` gives information gain between features from given data and target
 - `SelectKBest(<f_classif|f_regression|mutual_info_classif|mutual_info_regression>, k=5)` takes strategy and number of features as input and further `fit_transform` will give top k number of features.
 - `SelectPercentile(<f_classif|f_regression|mutual_info_classif|mutual_info_regression>, percentile=0.25)`	same as `SelectKBest` but selects top given percentile.
 - `SelectFromModel(model_obj)` some model ranks features, this method will use the model rank to select features which have rank greater than mean. P.S. it is not a ordered list.
 - `RFE(model_obj, k=5)` uses recursive feature elimination technique to return top k features. Returned object have `ranking_` property for rank of all the features and `estimator_.coef_` returns relative importance coefficient of selected features. 














