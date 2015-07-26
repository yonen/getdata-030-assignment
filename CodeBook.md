# Codebook

## Data
The Human Activity Recognition Using Smartphones Dataset contains a lot more information than is required for our purpose. The script merges the training and test data and then joins in the activity labels and subject information. 

## Clean up
Only the mean and Standard deviation measurements are required so all extra information is removed from the data set. Some column names are not clearly descriptive so the columns are renamed to improved their names.

### Renaming process
* `t` at the start of the variable is renamed to `time`
* `q` at the start of the variable is renamed to `freq` for frequency
* `mean` is renamed to `Mean`
* the standard variation variable `std` is renamed to `StdDev`
* `BodyBody` is renamed to `Body`
* any extra periods are removed

