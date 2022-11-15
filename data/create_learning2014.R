#Jukka Lankinen / 13.11.2022 / This script is for the data wrangling exercise

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
# 183x60 table
str(lrn14)
# table has various letter-number combinations (questions) and Age/Attitude/Points/gender in the first column and the rest of the columns have integers.
library(tidyverse)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
#questions related to different kinds of learning

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

lrn14$attitude <- lrn14$Attitude / 10
#attitude avg

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14,one_of(keep_columns))

#excluding rows with zero
learning <- filter(learning2014, Points > 0)
#has 166 rows and 7 variables

#set working directory from session -> set working directory -> to project directory

#create csv file named learning to my project folder
write.csv(learning, 
          file = "E:/ohjelmointi/IODS/IODS-project/data/learning2014.csv", 
          row.names = FALSE)

read.csv("E:/ohjelmointi/IODS/IODS-project/data/learning2014.csv")
str(read.csv("E:/ohjelmointi/IODS/IODS-project/data/learning2014.csv"))
dim(read.csv("E:/ohjelmointi/IODS/IODS-project/data/learning2014.csv"))
#still 166x7 and exercise done :)