% Cluster 2D real-world graphs with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing

clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes

meshFiles = {'airfoil1.mat', 'grid2.mat', 'barth.mat', '3elt.mat'};
meshFilesNames = {'airfoil1', 'grid2', 'barth', '3elt'};

for i = 1:length(meshFiles)
    load(meshFiles{i});
    
    
    % Specify the number of clusters
    K = 4;
    % Read graph
    W   = Problem.A;
    Pts = Problem.aux.coord;
    n   = size(Pts,1);
    
    
    figure;
    spy(W)
    title('Adjacency matrix')
    %% 2.1) Create the Laplacian matrix and plot the graphs using the 2nd and 3rd eigenvectors
    
    [L, Diag] = CreateLapl(W);
    
    [V, D] = eig(L);
    
    % Sort eigenvalues and eigenvectors
    lambda = diag(D);
    [lambda, idx] = sort(lambda);
    Y = V(:, idx(1:K));
    
    v2 = Y(:,2);
    v3 = Y(:,3);
    
    new_coords = [v2, v3];
    
    % Plot and compare
    figure;
    subplot(1,2,1);
    gplot(W,Pts)
    xlabel('Nodal coordinates')
    
    subplot(1,2,2);
    gplot(W, new_coords)
    xlabel('Eigenvectors 2 and 3')
    
    saveas(gcf,['.\figures\2.1_', meshFilesNames{i}, '.png'])
    
    %% 2.2) Cluster each graph in K = 4 clusters with the spectral and the
    %      k-means method, and compare yourresults visually for each case.
    
    [D_spec, x_spec] = kmeans_mod(Y, K, n);
    [D_kmeans, x_kmeans] = kmeans_mod(Pts, K, n);
    
    
    % Compare and visualize
    figure;
    subplot(1,2,1);
    gplotmap(W,Pts,x_spec)
    title(['Spectral clustering for ', meshFilesNames{i}])
    subplot(1,2,2);
    gplotmap(W,Pts,x_kmeans)
    title(['K-means clustering for ', meshFilesNames{i}])
    saveas(gcf,['.\figures\2.2_', meshFilesNames{i}, '.png'])
    
    %% 2.3) Calculate the number of nodes per cluster
    [Spec_nodes, Kmeans_nodes] = ClusterMetrics(K, x_spec, x_kmeans);
    
    % Create a table to report the number of nodes per cluster
    disp(['Number of nodes per cluster for ', meshFilesNames{i}])
    T = table(Spec_nodes, Kmeans_nodes);
    disp(T)
    
    % Make an Histogram
    Spec_nodes_1 = Spec_nodes(1);
    Spec_nodes_2 = Spec_nodes(2);
    Spec_nodes_3 = Spec_nodes(3);
    Spec_nodes_4 = Spec_nodes(4);
    
    Kmeans_nodes_1 = Kmeans_nodes(1);
    Kmeans_nodes_2 = Kmeans_nodes(2);
    Kmeans_nodes_3 = Kmeans_nodes(3);
    Kmeans_nodes_4 = Kmeans_nodes(4);
    
    
    % Create an array with the number of nodes per cluster (Used )
    Spec_nodes_array = [ones(1, Spec_nodes_1), 2*ones(1, Spec_nodes_2), 3*ones(1, Spec_nodes_3), 4*ones(1, Spec_nodes_4)];
    
    % Create a histogram
    figure;
    subplot(1,2,1);
    histogram(Spec_nodes_array, 4)
    title(['Spectral clustering'])
    subplot(1,2,2);
    histogram(x_kmeans, 4)
    title(['K-Means clustering'])
    supTitle = sgtitle(['Histograms for ', meshFilesNames{i}]);
    saveas(gcf,['.\figures\2.3_', meshFilesNames{i}, '.png'])
    
end