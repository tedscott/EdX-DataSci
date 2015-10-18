Azure = FALSE
if(Azure) {
  eeframe <- maml.mapInputPort(1)
  maml.mapOutputPort('eeframe')
}
# construct a pairwise scatter plot
pairs(~.,data=eeframe)

## use ggplot2 to create conditioned scatter plots
library(ggplot2)
plotCols <- c("RelativeCompactness","SurfaceArea",
              "WallArea","RoofArea","GlazingArea",
              "GlazingAreaDistribution")
plotEE <- function(x){
  title <- paste("HeatingLoad vs", x, "\n conditioned on
                 OverallHeight and Orientation")
  ggplot(eeframe, aes_string(x, "HeatingLoad")) +
    geom_point() + facet_grid(OverallHeight ~ Orientation) +
    ggtitle(title) +
    stat_smooth(method="lm")
}

# use the plotEE func to generate plots for each column in plotCols
lapply(plotCols, plotEE)

## create series of histograms
plotCols4 <- c("RelativeCompactness","SurfaceArea",
               "WallArea","RoofArea","GlazingArea",
               "GlazingAreaDistribution","HeatingLoad")
library(gridExtra)
eeHist <- function(x){
  title <- paste("Histogram of",x,"\n conditioned on OverallHeight")
  ggplot(eeframe,aes_string(x)) +
    geom_histogram(aes(y=..density..)) +
    facet_grid(.~OverallHeight) +
    ggtitle(title) +
    geom_density()
}
lapply(plotCols4,eeHist)

# create box plots
eeBox <- function(x){
  title <- paste("Box plot of",x,"\n by OverallHeight")
  ggplot(eeframe,aes_string("OverallHeight",x)) +
    geom_boxplot() +
    ggtitle(title)
}
lapply(plotCols4,eeBox)
