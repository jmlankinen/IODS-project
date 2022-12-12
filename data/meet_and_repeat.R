BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T)

library(dplyr)
library(tidyr)

str(BPRS)
#40x11 with treatment types, subjects and weeks. Only integer variables

str(rats)
#16x13 with ID, groups and weekdays. Only integer variables.

# Factor treatment, subject, ID and groups
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

# Convert bprs to long form
BPRS <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRS <-  BPRS %>% 
  mutate(week = as.integer(substr(BPRS$weeks, 5, 5)))

#Convert rats to long form
rats <-  pivot_longer(rats, cols = -c(ID, Group),
                      names_to = "WD", values_to = "Weight") %>%
  arrange(WD) #order by weekday variable

#Extract the day number
rats <-  rats %>% 
  mutate(Time = as.integer(substr(WD, 3, 4)))


str(BPRS)
#now it's a 360x5 tibble with factorial treatments & subjects, character weeks, integer bprs and integer week numbers.

str(rats)
#176x5 tibble with factorial ID's and groups. Character weekday and integer Weight & Time.

#Serious look: Wide format contains values that do not repeat in the first column. Long format contains values that do repeat in the first column.
#In wide dataset each value in first column is unique and in long dataset the values in first column repeat.
#More info here: https://www.statology.org/long-vs-wide-data/

#Writing the files
write.table(rats, "data/rats.txt", 
            append = F, sep = ",", dec = ".",
            row.names = T, col.names = T)

write.table(BPRS, "data/bprs.txt", 
            append = F, sep = ",", dec = ".",
            row.names = T, col.names = T)