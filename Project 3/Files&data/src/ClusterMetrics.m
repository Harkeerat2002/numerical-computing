function [Spec_nodes, Kmeans_nodes] = ClusterMetrics(K,x_spec,x_kmeans)
 % 2c) Calculate the number of nodes per cluster (for k-means and spectral
 %     clustering) and plot them in a histogram.
 
 Spec_nodes = histcounts(x_spec,K);
 Kmeans_nodes = histcounts(x_kmeans,K);
 
end