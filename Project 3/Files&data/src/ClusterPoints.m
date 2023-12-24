% Cluster 2D pointclouds with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing

clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes



% Specify the number of clusters
K = 2;

%% 1.1) Get coordinate list from pointclouds
[Pts_spirals, Pts_clusterin, Pts_corn, Pts_halfk, Pts_fullmoon, Pts_out] = getPoints();
% Coords used in this script

Plts = Pts_halfk(: , 1:2);
figure;
scatter(Plts(:,1),Plts(:,2));
title('Visualizing the Coordinate List of the Pointcloud of Halfk');
saveas(gcf,'.\figures\1.1.png');


n = size(Plts, 1);
map = ones(n, 1);

% Create Gaussian similarity function
[GS] = similarityfunc(Plts(:,1:2));


%% 1.2) Find the minimal spanning tree of the full graph. Use the information
%       to determine a valid value for epsilon
GS_Graph = graph(GS);
[MST] = minspantree(GS_Graph);
epsilon = max(max(MST.Edges.Weight));

%% 1.3) Create the epsilon similarity graph
[ESP] = epsilonSimGraph(epsilon, Plts); % ESP = G


%% 1.4) Create the adjacency matrix for the epsilon case
W = GS .* ESP;
%% disp(W)

figure;
gplotg(W,Plts(:,1:2))
title('Visualizing the Epsilon Similarity Graph of Halfk');
saveas(gcf,'.\figures\1.4.png');

%% 1.5) Create the Laplacian matrix and implement spectral clustering
[L, Diag] = CreateLapl(W);

[V, D] = eig(L);

lambda = diag(D);
[lambda, idx] = sort(lambda);
Y = V(:,idx(1:K));

[D_spec,x_spec] = kmeans_mod(Y, K, n);

%% 1.6) Run K-means on input data
[D_kmeans,x_kmeans] = kmeans_mod(Plts, K, n);

%% 1.7) Visualize spectral and k-means clustering results
figure;
subplot(1,2,1)
gplotmap(W,Plts,x_spec)
title('Spectral Clustering for Halfk')
subplot(1,2,2)
gplotmap(W,Plts,x_kmeans)
title('K-means Clustering for Halfk')
saveas(gcf,'.\figures\1.7.png');

two_cluster_graphs = {Pts_halfk, Pts_spirals, Pts_clusterin, Pts_fullmoon};
two_cluster_graphs_name = {'HalfK', 'Two Spirals', 'Cluster in Cluster', 'Crescent & Full Moon'};

three_cluster_graphs_name = {'Corn', 'Outliers'};
three_cluster_graphs = {Pts_corn, Pts_out};

all_cluster_graphs_name = [two_cluster_graphs_name, three_cluster_graphs_name];

K_2 = 2;
K_4 = 4;

epsilonAll = [];
for i = 1:length(two_cluster_graphs)
    epsilonAll = [epsilonAll, plotClusters(two_cluster_graphs{i}, K_2, two_cluster_graphs_name{i})];
end

for i = 1:length(three_cluster_graphs)
    epsilonAll = [epsilonAll, plotClusters(three_cluster_graphs{i}, K_4, three_cluster_graphs_name{i})];
end

T = table(all_cluster_graphs_name', epsilonAll');
disp(T);

function [epsilon] = plotClusters(Plts, K, titleName)
    n = size(Plts, 1);

    [GS] = similarityfunc(Plts(:, 1:2));
    
    GS_Graph = graph(GS);
    [MST] = minspantree(GS_Graph);
    epsilon = max(max(MST.Edges.Weight));
    [ESP] = epsilonSimGraph(epsilon, Plts);
    W = GS .* ESP;
    [L, Diag] = CreateLapl(W);

    [V, D] = eig(L);
    
    lambda = diag(D);
    [lambda, idx] = sort(lambda);
    Y = V(:,idx(1:K));
    
    [D_spec,x_spec] = kmeans_mod(Y, K, n);
    [D_kmeans, x_kmeans] = kmeans_mod(Plts, K, n);

    figure;
    subplot(1,2,1)
    gplotmap(W,Plts,x_spec)
    title(['Spectral Clustering for ', titleName])
    subplot(1,2,2)
    gplotmap(W,Plts,x_kmeans)
    title(['K-means Clustering for ', titleName])
    saveas(gcf,['.\figures\1.7_', titleName, '.png']);
end