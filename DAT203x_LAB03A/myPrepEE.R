## load the data
dirName <- "c:/git/EdX-DataSci/DAT203x_LAB03A/"
fileName <- "EnergyEfficiencyRegressiondata.csv"
infile <- file.path(dirName,fileName)
eeframe <- read.csv(infile,header=TRUE,stringsAsFactors = FALSE)

# remove the dots from the column names (spaces were replaced with dots by read.csv)
# gsub() finds and replaces all occurences of the . and replaces with nothing
names(eeframe) <- gsub("\\.","",names(eeframe))

# remove columns we aren't going to use
eeframe$CoolingLoad <- NULL

# convert some columns to factors from numeric as they have few discrete values
# uses a short inline function to first convert to char and then to factor
# does R not have a lambda function type as in Python?
catList <- c("OverallHeight","Orientation")
eeframe[,catList] <- lapply(eeframe[,catList],function(x){as.factor(as.character(x))}) 

# scale the numeric features using scale() which normalizes the columns
# such that the mean is 0 and the sd is 1
scaleList <- c("RelativeCompactness","SurfaceArea","WallArea","RoofArea",
               "GlazingArea","GlazingAreaDistribution")
eeframe[,scaleList] <- lapply(eeframe[,scaleList],function(x){as.numeric(scale(x))})