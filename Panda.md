# Data frame
 1. Create API
 - `pd.DataFrame({"col1": [somelist],..."col2": [somelist] }`) creates the dataframe with col1 and col2 and their respective values.
 - `pd.DataFrame([col1_values], columns=['col1'])` creates dataframe where each column passed as seperate list.
 - `dataframe['col'] = <somecol>` adds a new column to a dataframe
 - `index` column - it can be set to some other column or by defult it is usual sequence series.
 - `index.name` - sets the name of index column 

 2. Column operations
  1. `df[col1] - df[col2]` subtracts col2 values from col1
  2. access a column `df.col1`
  3. `df.col.iloc[[<index1>, <index2>]]` return list of column values for the give indices list
  4. `df.col.loc[[index1key, index2key]]` return list of column values for the give indices list	
  
 3. Dataframe operation
  1. `describe()` - summarize data farme columns with centered values

 4. Melt usecase ?
  1. `pd.melt(df, id_var='col1', var_name='newCol')` 

 5. bin a column
  1. `cut(<col>, breakArr)` group a column in ranges returns a code col

 
