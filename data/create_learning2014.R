#Data wrangling, chapter 2

# read the data from the given URL
url <- "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"
lrn14 <- read.table(url, sep="\t", header=TRUE)

#check variables
str(lrn14)

#In the given data set gender variable is a factor and rest all are integers

#check data set size
dim(lrn14)

#The data set has 183 observations and 60 variables

#We create analysis data set with variables gender, age, attitude, deep, stra, surf, points 
#load dplyr library
library(dplyr)

#Specify the questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06","D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#We create single column 'deep' by taking mean over all the columns of deep learning
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

#We create single column 'surf' by taking mean over all the columns of surface learning
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

#We create single column 'stra' by taking mean over all the columns of strategic learning
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#Acale 'Attitude' variable
lrn14$attitude <- lrn14$Attitude / 10

#specify variables of interest
keep_columns <- c("gender","Age","attitude","deep","stra","surf","Points")

#create data frame from the specified subset of columns
learning2014 <- select(lrn14,one_of(keep_columns))

#Exclude observations where exam points = 0
learning2014 <- filter(learning2014, Points > 0)

#The analysis data set is created
head(learning2014)
str(learning2014)
#check data set size
dim(learning2014)

#The analysis data set has 166 observations and 7 variables

#set working directory
setwd("~/MS/data-science/IODS-project/data")

#save dataset
write.csv(learning2014, file = "learning2014.csv",row.names=FALSE)

#read the data from local file
data <- read.csv("learning2014.csv")
head(data)
str(data)


