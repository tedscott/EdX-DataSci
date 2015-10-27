# Visualize the diabetes data
frame1 <- maml.mapInputPort(1)
library(ggplot2)
library(dplyr)

# compare outcomes for categorical variables
bar.plot <- function(x) {
  if(is.factor(frame1[,x])) {
    sums <- summary(frame1[,x], counts=n())
    msk <- names(sums[which(sums>100)])
    tmp <- frame1[frame1[,x] %in% msk, c('readmi_class',x)]
    if(strsplit(x,'[-]')[[1]][1]==x) {
      g <- ggplot(tmp,aes_string(x)) +
        geom_bar() +
        facet_grid(.~readmi_class) +
        ggtitle(paste("Readmissions by level of",x))
      print(g)
    }
  }
}
cols <- names(frame1)
cols <- cols[1:(length(cols)-1)] # don't want readmi_class so subtract 1?
lapply(cols, bar.plot)

# make box plots of numeric columns
box.plot <- function(x) {
  if(is.numeric(frame1[,x])) {
    ggplot(frame1,aes_string("readmi_class",x)) +
      geom_boxplot() +
      ggtitle(paste("Readmissions by", x))
  }
}
lapply(names(frame1),box.plot)