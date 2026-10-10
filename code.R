# Load necessary libraries
library(igraph)
library(Matrix)

# Load the matrix market file (sparse format)
mtx_file <- "road-usroads.mtx"
mtx_data <- readMM(mtx_file)  # Reads sparse adjacency matrix

# Convert to graph (KEEPING it SPARSE)
g <- graph_from_adjacency_matrix(mtx_data, mode = "undirected", weighted = NULL)

# ---- Basic Graph Properties ----
cat("📌 Number of Nodes:", vcount(g), "\n")
cat("📌 Number of Edges:", ecount(g), "\n")

# Set small PNG parameters
png_width <- 500
png_height <- 500  # Slightly increased for better readability

# Set global text orientation and margins
par(las=1)  # Forces horizontal axis labels

# -----------------------------------------
# 1️⃣ Degree Distribution Histogram (BIG BARS, NO GAPS)
# -----------------------------------------
deg <- degree(g)

png("degree_distribution_histogram.png", width=png_width, height=png_height)
par(mar=c(6, 9, 5, 3), mgp=c(3.5, 1, 0))  # Increased left margin for y-label
hist(deg, breaks=seq(min(deg)-0.5, max(deg)+0.5, by=1), col="dodgerblue3", border="black",
     main="Degree Distribution Histogram", 
     xlab="Degree (Number of Connections)", 
     ylab="Frequency", 
     ylim=c(0, max(table(deg)) * 1.1), 
     xaxt="n",  # Remove default x-axis labels
     cex.main=1.8, cex.lab=1.8, cex.axis=1.6)  # Enlarged labels

# Custom X-axis with integer ticks
axis(1, at=seq(min(deg), max(deg), by=1), labels=seq(min(deg), max(deg), by=1), cex.axis=1.4)

grid(nx=NA, ny=NULL, col="gray80", lty="dotted")
dev.off()

# -----------------------------------------
# 2️⃣ CCDF (Cumulative Complementary Distribution Function)
# -----------------------------------------
deg_sorted <- sort(deg, decreasing = TRUE)
ccdf <- 1 - ecdf(deg)(deg_sorted)

png("ccdf_degree_distribution.png", width=png_width, height=png_height)
par(mar=c(6, 9, 5, 3), mgp=c(3.5, 1, 0))
plot(deg_sorted, ccdf, log="y", type="b", col="darkgreen", pch=16, cex=1.2, lwd=3,
     main="CCDF of Degree Distribution", 
     xlab="Degree", 
     ylab="P(Degree > k) (log scale)", 
     cex.main=2, cex.lab=1.8, cex.axis=1.6, xaxt="n")  # Disable default x-axis

axis(1, at=c(1,2,3,4,5,6,10,20,50,100), labels=c("1","2","3","4","5","6","10","20","50","100"))

grid(nx=NULL, ny=NULL, col="gray80", lty="dotted")
dev.off()

# -----------------------------------------
# 3️⃣ Clustering Coefficient Histogram (BIGGER BARS, FIXED Y-AXIS)
# -----------------------------------------
clustering_coeff <- transitivity(g, type="local")
clustering_coeff <- clustering_coeff[!is.na(clustering_coeff)]  # Remove NA values

png("clustering_coefficient.png", width=500, height=500)
par(mar=c(6, 9, 5, 3), mgp=c(3.5, 1, 0))

hist(clustering_coeff, breaks=30, col="seagreen4", border="black",
     main="Clustering Coefficient Histogram", 
     xlab="Clustering Coefficient", 
     ylab="Frequency", 
     ylim=c(0, max(table(cut(clustering_coeff, breaks=30))) * 1.2),  # Adjusted Y-axis scaling
     cex.main=1.8, cex.lab=1.8, cex.axis=1.6)

grid(nx=NA, ny=NULL, col="gray80", lty="dotted")
dev.off()

# -----------------------------------------
# 4️⃣ 6-Hop Neighborhood Network
# -----------------------------------------
set.seed(42)
central_node <- sample(V(g), 1)
six_hop_nodes <- ego(graph = g, order = 6, nodes = central_node, mode = "all")[[1]]
g_six_hop <- induced_subgraph(g, six_hop_nodes)

png("six_hop_network.png", width=png_width, height=png_height)
par(mar=c(5,6,4,2))
plot(g_six_hop, vertex.size=5, vertex.label=NA, edge.color="gray40",
     main="6-Hop Neighborhood of a Central Node", layout=layout_with_fr(g_six_hop), 
     cex.main=1.8)

dev.off()



# ---- High-Resolution 6-Hop Neighborhood Network ----
set.seed(42)
central_node <- sample(V(g), 1)
six_hop_nodes <- ego(graph = g, order = 6, nodes = central_node, mode = "all")[[1]]
g_six_hop <- induced_subgraph(g, six_hop_nodes)

# High-resolution image settings
png("six_hop_network_high_qual.png", width=4000, height=4000, res=600)  # High DPI for quality

par(mar=c(5,6,4,2))
plot(g_six_hop, vertex.size=5, vertex.label=NA, edge.color="gray40",
     main="6-Hop Neighborhood of a Central Node", layout=layout_with_fr(g_six_hop), 
     cex.main=2.5)  # Larger title for better readability

dev.off()




# Additional high-resolution visualisation
  # Load necessary libraries
library(igraph)
library(Matrix)

# Load the matrix market file (sparse format)
mtx_file <- "road-usroads.mtx"
mtx_data <- readMM(mtx_file)  # Reads sparse adjacency matrix

# Convert to graph (KEEPING it SPARSE)
g <- graph_from_adjacency_matrix(mtx_data, mode = "undirected", weighted = NULL)

# Load necessary libraries
library(igraph)
library(Matrix)

# Load the matrix market file (sparse format)
mtx_file <- "road-usroads.mtx"
mtx_data <- readMM(mtx_file)  # Reads sparse adjacency matrix

# Convert to graph (KEEPING it SPARSE)
g <- graph_from_adjacency_matrix(mtx_data, mode = "undirected", weighted = NULL)

# ---- High-Resolution 6-Hop Neighborhood Network ----
set.seed(42)
central_node <- sample(V(g), 1)
six_hop_nodes <- ego(graph = g, order = 6, nodes = central_node, mode = "all")[[1]]
g_six_hop <- induced_subgraph(g, six_hop_nodes)

# Ultra high-resolution image settings (4K+ quality) with Transparent Background
png("six_hop_network.png", width=5000, height=5000, res=800, bg="transparent")  # Transparent background

par(mar=c(0,0,0,0))  # Remove margins for full image fit
plot(g_six_hop, vertex.size=5, vertex.label=NA, edge.color="gray40",
     main="", layout=layout_with_fr(g_six_hop), 
     cex.main=3.0, frame=FALSE)  # No frame to blend with any background

dev.off()
