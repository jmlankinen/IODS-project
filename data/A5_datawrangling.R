library(readr)
#loading the data
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt")

#195x19 as expected
str(human)

#selecting the wanted variables
human <- subset(human, select = c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))

#9 variables left / sanity check
str(human)

#removing non-complete rows
human <- human[complete.cases(human),]

#162 rows left
str(human)

#by looking at the data we see that the last 7 rows relate to regions so lets pick rows 1-155
human <- human[1:155,]

#making a new dataframe by picking the 1st column/country column as row name
human <- data.frame(human, row.names = 1)

#sanity check
str(human)

#writing the human data on top of my old data
write.csv(human, 
          file = "E:/ohjelmointi/IODS/IODS-project/data/human.csv", 
          row.names = TRUE)

#data wrangling exercise done