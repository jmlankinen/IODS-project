#1 file created

#2 reading datasets

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")
# more info about datasets here:
# https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

#3 exploring datasets

str(hd) # 195x8 with numeric and character variables
str(gii) # 195x10 with numeric and character variables

summary(hd)
summary(gii)

#4 renaming variables with metadata: https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt

##From metadata:
## Health and knowledge

#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate

# Empowerment

#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force

#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M


library(dplyr)
names(hd)

hd = rename(hd,
            HDIr = "HDI Rank",
            HDI = "Human Development Index (HDI)",
            Life.Exp = "Life Expectancy at Birth",
            Edu.Exp = "Expected Years of Education",
            M_YEdu = "Mean Years of Education",
            GNI = "Gross National Income (GNI) per Capita",
            GNI_HDIr = "GNI per Capita Rank Minus HDI Rank"
)
#left country as is since it's short enough
#checking names
names(hd)

names(gii)
gii = rename(gii, 
             GIIr = "GII Rank", 
             GII = "Gender Inequality Index (GII)", 
             MMR = "Maternal Mortality Ratio",
             ABR = "Adolescent Birth Rate", 
             Parli.P = "Percent Representation in Parliament",
             Edu2.F = "Population with Secondary Education (Female)",
             Edu2.M = "Population with Secondary Education (Male)",
             Labo.F = "Labour Force Participation Rate (Female)",
             Labo.M = "Labour Force Participation Rate (Male)"
)
#checking names
names(gii)

#5 Mutate the “Gender inequality” data and create two new variables. 
#The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M).
#The second new variable should be the ratio of labor force participation of females and males in each country (i.e. labF / labM).

gii = gii %>%
  mutate(Edu2.FM.R = Edu2.F/Edu2.M) %>%
  mutate(Labo.F.P = Labo.F/Labo.M)

#6 joining datasets by country and writing csv to my project folder

human <- inner_join(gii, hd, by = "Country")

write.csv(human, 
          file = "E:/ohjelmointi/IODS/IODS-project/data/human.csv", 
          row.names = FALSE)
str(human) #195x19 as expected
#data wrangling done