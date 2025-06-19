############# VECTOR

library(sf)
nc <- st_read(system.file("shape/nc.shp", package="sf"))

plot(nc)

# Mapping NC counties

library(ggplot2)
ggplot() + 
  geom_sf(data = nc)


# Calculating area

nc$area <- st_area(nc)
nc$areakm2 <- nc$area/1000000

# Order counties by area

nc <- nc[order(nc$areakm2, decreasing = TRUE), ]

# Visualize counties iwth hugher areas

library(ggplot2)
  ggplot() + 
    geom_sf(data = nc[1:20, ])

# Scatterplots

nc_df <- st_drop_geometry(nc)

# Select columns
cols <- c("AREA", "PERIMETER", "CNTY_")
nc_df_subset <- nc_df[, cols]

# Histograms on one var

ggplot(nc_df_subset, aes(x = AREA)) +
  geom_histogram(
    aes(y = ..density.., fill = ..count..),
    bins = 20,
    color = "black",
    alpha = 0.85
  ) 

# Adding density

ggplot(nc_df_subset, aes(x = AREA)) +
  geom_histogram(
    aes(y = ..density.., fill = ..count..),
    bins = 20,
    color = "black",
    alpha = 0.85
  ) +
geom_density(color = "darkblue", size = 1.2) +
scale_fill_viridis_c(option = "viridis")


# pairs()
pairs(nc_df_subset)

# ggpairs()
library(GGally)
ggpairs(nc_df_subset)

# Plotting area and perimeter per county as a factor

ggplot(nc_df_subset, aes(x = PERIMETER, y = AREA, color = as.factor(CNTY_))) +
  geom_point(size = 4) +
  scale_color_viridis_d(option = "viridis") 



############# RASTER
### Multipanel in R

install.packages("sp")
install.packages("GGally") # this is used for the function ggpairs()

library(sp) # require(sp) will also do the job
library(GGally)
library(gclus) # final clusters

data(meuse) # there is a dataset available named meuse

attach(meuse)

# Exercise: see the names of the variables and plot cadmium versus zinc
# There are two ways to se the names of the variables:
names(meuse)
head(meuse)
plot(cadmium,zinc,pch=15,col="red",cex=2)

# Exercise: make all the possible paiwis plots of the dataset
# plot(x,cadmium)
# plot(x,zinc)
# plot....
# plot is not a good idea!
pairs(meuse)

# in case you receive the error "the sizze is too large" reshape with the mouse the graph window and relaunch the code

pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6])

# Exercise: prettify this graph
pairs(meuse[,3:6], col="red", pch=18, cex=1.5)

# GGally package will prettify the graph
ggpairs(meuse[,3:6])

# ggcorr
ggcorr(meuse[,3:6])


## Loading required package: gclus
# make the corelation
sb.cor <- cor(meuse[,3:6])

# assign color
sb.color <- dmat.color(sb.cor)
# dmat.color assigns three colours to the correlations according to the correlation magnitude. High correlations are in pink, the middle third are in blue, and the botom third are in yellow.

# assign order
sb.o <- order.hclust(sb.cor)

# make the plot
cpairs(meuse[,3:6], order= sb.o,panel.color= sb.color,upper.panel=NULL)




