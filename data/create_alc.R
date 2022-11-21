#Jukka Lankinen / 21.11.2022
#This script is for the data wrangling of Student Perfomance Data located in https://archive.ics.uci.edu/ml/datasets/Student+Performance


#setting working directory to my project folder
setwd("E:/ohjelmointi/IODS/IODS-project")

#reading csv files with ; separators from the project data folder
por <- read.table(file="data/student-por.csv", sep=";", header=TRUE)
math <- read.table(file="data/student-mat.csv", sep=";", header=TRUE)

#Variable names seem identical and there's same amount of them (33)
str(por)
str(math)

#portugese course data has 649 rows whereas math course data has 395 rows
dim(por)
dim(math)

#accessing dplyr library for joining columns
library(dplyr)

#give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

#the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

#join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

#Copied the loop from exercise 3.3. This takes the average for G1 G2 G3 failures and absences. The first paid column is also chosen (aka only paid.math is taken into account).
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- two_cols[,1]
  }
}


#taking the means of consumption columns and creating a new column to alc.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#creating a logical column for high consumption
alc <- mutate(alc, high_use = alc_use > 2)

#Checking the data. Everything seems in order.
glimpse(alc)


#Accessing tidyverse to save csv file
library(tidyverse)
write.csv(alc, 
          file = "data/alc.csv",
          row.names = FALSE)

#Exercise done :)