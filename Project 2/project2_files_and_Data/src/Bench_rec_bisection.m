% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for Numerical Computing at USI

% add necessary paths
addpaths_GP;
nlevels_a = 3;
nlevels_b = 4;

fprintf('       *********************************************\n')
fprintf('       ***  Recursive graph bisection benchmark  ***\n');
fprintf('       *********************************************\n')

% load cases
cases = {
     'mesh1e1.mat',
     'bodyy4.mat',
     'de2010.mat',
     'biplane-9.mat',
     'L-9.mat',
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end


fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

%% Create results table
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');




for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});
    

    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % 1. Initialize the problem
    [params] = Initialize_case(sparse_matrices(c));
    W      = params.Adj;
    coords = params.coords;   

    % 2. Recursive routines
    % i. Spectral
    [spectral_map_8, spectral_edge_sep_8, ~] = rec_bisection('bisection_spectral', nlevels_a, W, coords, 0);
    
    [map_spectral_16,sepij_spectral_16,sepA_spectral_16] = rec_bisection('bisection_spectral', nlevels_b, W, coords, 0);

    % ii. Metis
    [map_metis_8,sepij_metis_8,sepA_metis_8] = rec_bisection('bisection_metis', nlevels_a, W, coords, 0);

    [map_metis_16,sepij_metis_16,sepA_metis_16] = rec_bisection('bisection_metis', nlevels_b, W, coords, 0);

    % iii. Coordinate    
    [map_coordinate_8,sepij_coordinate_8,sepA_coordinate_8] = rec_bisection('bisection_coordinate', nlevels_a, W, coords, 0);

    [map_coordinate_16,sepij_coordinate_16,sepA_coordinate_16] = rec_bisection('bisection_coordinate', nlevels_b, W, coords, 0);

    % iv. Inertial
    [map_inertial_8,sepij_inertial_8,sepA_inertial_8] = rec_bisection('bisection_inertial', nlevels_a, W, coords, 0);

    [map_inertial_16,sepij_inertial_16,sepA_inertial_16] = rec_bisection('bisection_inertial', nlevels_b, W, coords, 0);


    % 3. Calculate number of cut edges
    % i. Spectral
    cut_edges_spectral_8 = cutsize(W, spectral_map_8);
    cut_edges_spectral_16 = cutsize(W, map_spectral_16);
    
    % ii. Metis
    cut_edges_metis_8 =  cutsize(W, map_metis_8);
    cut_edges_metis_16 =  cutsize(W, map_metis_16);
    
    % iii. Coordinate

    cut_edges_coordinate_8 = cutsize(W, map_coordinate_8);
    cut_edges_coordinate_16 = cutsize(W, map_coordinate_16);
    
    % iv. Inertial
    cut_edges_inertial_8 = cutsize(W, map_inertial_8);
    cut_edges_inertial_16 = cutsize(W, map_inertial_16);

    % 4. Visualize the partitioning result

    % i. Spectral
    if c == 3
        figure;
        gplotpart(W, coords, spectral_map_8)

        figure;
        gplotpart(W, coords, map_spectral_16)

        figure;
        gplotpart(W, coords, map_metis_8)
        
        figure;
        gplotpart(W, coords, map_metis_16)

        figure;
        gplotpart(W, coords, map_coordinate_8)

        figure;
        gplotpart(W, coords, map_coordinate_16)

        figure;
        gplotpart(W, coords, map_inertial_8)

        figure;
        gplotpart(W, coords, map_inertial_16)

    end




    
    
    fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n',cut_edges_spectral_8,cut_edges_spectral_16,cut_edges_metis_8,cut_edges_metis_16,cut_edges_coordinate_8,cut_edges_coordinate_16,cut_edges_inertial_8,cut_edges_inertial_16);
    
end

