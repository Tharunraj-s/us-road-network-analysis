# US Road Network Analysis

Graph-analysis coursework by Tharunraj Singaravelu, using R, igraph and Matrix.

## Analysis

- Node and edge counts
- Degree histogram and empirical complementary cumulative distribution P(Degree > k)
- Local clustering coefficients
- Six-hop neighbourhood visualisations

## Run

1. Obtain `road-usroads` from Network Repository: https://networkrepository.com/road-usroads.php
2. Check the dataset's current usage and attribution terms, extract its Matrix Market file and place `road-usroads.mtx` beside `code.R`.
3. In R, install `igraph` and `Matrix`, then run `source("code.R")`.

The dataset is not redistributed in this release. The script writes PNG figures to its working directory. Large neighbourhood layouts may take time. No shortest-path or travel-time prediction is implemented.

## Attribution

Ryan A. Rossi and Nesreen K. Ahmed, *The Network Data Repository with Interactive Graph Analytics and Visualization*, AAAI 2015. https://networkrepository.com

## Release notes

Curated from the original coursework. The invalid bare separator was commented and the CCDF axis label corrected to match its strict upper-tail calculation. The original presentation and academic history remain private. R execution has not been verified in this release environment.
