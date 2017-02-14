R - Getting and cleansing data project

Repository files:
run_analysis.R - R script for data processing
codebook.md - data description

My script is very simple.
0. Load library "data.table" and "dplyr"
1. First I checked data. If data doesn't exists I will download zip file and unzip
2. I read all data sources by fread function
3. Check which columns contains mean or std
4. Merging train and test data sets  x, y and subjects 
5. Add activity labels
6. Write output file with summary done by aggregate function
