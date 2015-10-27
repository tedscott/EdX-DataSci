frame1 <- maml.mapInputPort(1)

# compute residuals
frame1$Resids <- frame1$HeatingLoad-frame1$ScoredLabels

# plot residuals vs HeatingLoad
library(ggplot2)
ggplot(frame1,aes(x=HeatingLoad, y=Resids, by=OverallHeight)) +
  geom_point(aes(color=OverallHeight)) +
  xlab("heating Load") + ylab("Residuals") +
  ggtitle("Residuals vs Heating Load") +
  theme(text=element_text(size=20))

# create conditioned plots of the residuals
plotCols <- c("SurfaceAreaSqred","SurfaceArea","RoofArea","RelativeCompactnessSqred","WallArea","SurfaceArea3")

plotEERes <- function(x) {
  title <- paste("residuals vs heating load conditioned by", x)
  facFormula <- paste("OverallHeight ~", x)
  ggplot(frame1,aes(Resids, HeatingLoad)) +
    geom_point() +
    facet_grid(facFormula) +
    ggtitle(title)
}

lapply(plotCols, plotEERes)

# conditioned histograms of the residuals
ggplot(frame1, aes(Resids)) +
  geom_histogram(binwidth=0.5) +
  facet_grid(. ~ OverallHeight) +
  ggtitle("Histograms of residuals conditioned by OverallHeight") +
  xlab("residuals")

# Q-Q normal plot of the residuals
Resids35 <- frame1[frame1$OverallHeight==3.5,]$Resid
Resids7 <- frame1[frame1$OverallHeight==7,]$Resid
par(mfrow=c(1,2))
qqnorm(Resids35)
qqnorm(Resids7)
par(mfrow=c(1,1))

# compute the RMSE values for the residuals for both
# the overall and evaluation parts of the dataset
rmse <- function(x) {
  sqrt(sum(x^2)/length(x))
}

outFrame <- data.frame(
  rms_Overall <- rmse(frame1$Resids),
  rms_35 <- rmse(Resids35),
  rms_7 <- rmse(Resids7)
)

# if in Azure output the data frame
maml.mapOutputPort("outFrame")
