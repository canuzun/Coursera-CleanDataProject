# Coursera-CleanDataProject

##Variables
datasetRootPath : Should be set where the data file root is.

## How it works?
Script;
* Imports all data and reference files in different R objects.
* Appends/Binds all test and train data into single relevent files. Order should be same for all bindings.
* For reference data, it uses a factor labeling, and updates activity data.
* Adds headers to data frame columns. Headers were imported into features object. There are some duplicate column names in features and they are not std or mean so those columns are also removed.
* By using dplyr package and select function, choses only std or mean related columns. If a column name has mean() or std() in it, it is selected, otherwise ignored.
* A final datased is ready with mean and std columns, script adds Activity & Subject columns to the end.
* Last, it aggregates by Subject & Activity and gets the average of all other columns and writes result to a txt file.

See also comments in code for more details.

Thanks for evaluating me :)