# read in the data into a data frame
frame1 <- maml.mapInputPort(1)

library(ggplot2)

## compute principle components, plot the clusters
# get numeric columns
numCols <- c("FFMC","DMC","DC","ISI","temp","RH","wind","area")

# create principal component matrix
pcfit <- princomp(frame1[,numCols])

# multiply
pcframe <- data.frame(as.matrix(frame1[, numCols])
                      %*% pcfit$loadings[, 1:2],
                      Assignments = frame1$Assignments)

# plot
ggplot(pcframe, aes(Comp.1, Comp.2)) +
  geom_point(aes(shape = factor(Assignments), color = factor(Assignments)),
             alpha = 0.3, size = 4) +
  ggtitle(paste("Clusters by first two principal components")) +
  xlab("Principal component 1") + ylab("Principal component 2")

# create scatter plots of numeric columns vs area
numCols <- c("FFMC","DMC","DC","ISI","temp","RH","wind")
plot.clusts <- function(x) {
  ggplot(frame1, aes_string(x, "area")) +
    geom_point(aes(shape = factor(Assignments), color = factor(Assignments)),
               alpha = 0.3, size = 4) +
    ggtitle(paste("Clusters for", x, "vs area"))
}
lapply(numCols, plot.clusts)

# look at scatter plots of the clusters by FFMC
numCols <- c("DMC","DC","ISI","temp","RH","wind","area")
plot.clusts2 <- function(x) {
  ggplot(frame1, aes_string(x, "FFMC")) +
    geom_point(aes(shape = factor(Assignments), color = factor(Assignments)),
               alpha = 0.3, size = 4) +
    ggtitle(paste("Clusters for", x, "vs FFMC"))
}
lapply(numCols, plot.clusts2)

