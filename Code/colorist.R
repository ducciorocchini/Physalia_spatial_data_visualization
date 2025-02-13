# https://besjournals.onlinelibrary.wiley.com/doi/epdf/10.1111/2041-210X.13477

# First map

library(colorist)
data("fiespa_occ")

# First map with single distributions
m1 <- metrics_pull(fiespa_occ)
p1 <- palette_timecycle(fiespa_occ)
map_multiples(m1, p1, ncol=4, labels=names(fiespa_occ))

# Common map
m1_distill <- metrics_distill(fiespa_occ)
map_single(m1_distill, p1)

# Spheric graph
legend_timecycle(p1, origin_label="Jan 1")

# Second example single maps
data("elephant_ud")
m2 <- metrics_pull(elephant_ud)
p2 <- palette_set(2)
map_multiples(m2, p2, ncol = 2, lambda_i=-5,labels=names(elephant_ud))

# Common map
m2_distill <- metrics_distill(elephant_ud)
map_single(m2_distill, p2, lambda_i=-5)

# Legends
legend_set(p2, group_labels=names(elephant_ud))

