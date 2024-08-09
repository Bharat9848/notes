# Matplotlib module
- Jupyter notebook - use macro `%matplotlib inline` to display graph inline

## Plot Function
 
 - `plt.gca()`
 - `plt.subplots(nrows, ncols, figsize=(xsub_size, y_sub_size), sharex='True|False, sharey='True|False')` : plots small graphs of given `figsize` size in `nrows` rows and `ncols` columns. And returns arrays of (`nrows` * `ncols`) size `Axis` object and `figure` obeject. `sharex` shares x column and `shares` shares y column among all the subgraph.

## Axis function
 - `ax.annotate(text, xy=(x,y), xytext=(x,y), arrowprops='{'arrowstyle': '->'}')`: annotates text to a plot. `xy` starting point of arrow, xytext starting point of text) 
 - `ax.set_title`: sets title of a plot
 - `ax.set_xlabel`: sets x label
 - `ax.set_ylabel`: sets y label
 - `ax.vlines([x], [y], [x], <col>)`
 - `ax.hlines([x], [y], [x], <col>)`
 - `ax.legend()` helpful in denoting multiple plot in a same plot.
 - `ax.aspect('equal|..')` ? 
 - properties `ax.yaxis`, `ax.xaxis`
 - `ax.axis([xStart, xEnd, yStart, yEnd])` creates plot with given x-axis and y-axis range
 - `ax.axis('off')` turned off the axis 
 - `ax.scatter`: plots scatter plot.
 - `ax.flat` ???


 # SNS module
  - `heatmap(<multi_arr>, annot=true, cbar=false, ax=<axis>, **add_args)` plots heatmap.
  - `swarmplot(<1d_arr>, orient='v')` plots swarm plot
  - `swarmplot(x=<swarmcolumn>, y=<value>, hue=<column>,data=<dataframe>)` plots swarm plot - plot transformed features.	
  - `stripplot(data=<pandaDataFrame>`) plots strip plot ??  
  - `tsplot` ???  
  - `distplot(<col>, hist='True'|'False',rug=true)` plots a distribution for a feature
  - `lmplot()`

# excercise
 - plot a scatter plot for classification problem with color code each point based on its label/target.