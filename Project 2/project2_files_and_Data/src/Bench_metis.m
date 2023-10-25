function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI


%  Add necessary paths
addpaths_GP;

addpath('../datasets/2d_3d_meshes');
% Graphs in question
load 'helicopter.mat' ;
load 'skirt.mat';

cases = {
    'helicopter.mat',
    'skirt.mat',
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

for c = 1:nc

    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});

    % Steps
    % 1. Initialize the cases

    [params] = Initialize_case(sparse_matrix);
    w = params.Adj;
    coords = params.coords;


    % Make a 2 by 2 array
    edgesCutRecursive = zeros(2,2);
    edgesCutKway = zeros(2,2);

% 2. Call metismex to
%     a) Recursively partition the graphs in 16 and 32 subsets.
        [map16,edg1a] = metismex('PartGraphRecursive',w,16);
        [map32,edg2a] = metismex('PartGraphRecursive',w,32);
        edgesCutRecursive(c,1) = edg1a;
        edgesCutRecursive(c,2) = edg2a;
        if c == 2
            disp('---------------------------------')
            disp('Recursive for 1')
            disp(edg1a)
            disp(edg2a)
            disp('---------------------------------')

        
%     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
        [map16,edg1b] = metismex('PartGraphKway',w,16);
        [map32,edg2b] = metismex('PartGraphKway',w,32);
        edgesCutKway(c,1) = edg1b;
        edgesCutKway(c,2) = edg2b;
        if c == 2
            disp('---------------------------------')
            disp('Kway for 1')
            disp(edg1b)
            disp(edg2b)
            disp('---------------------------------')
        end
% 3. Visualize the results for 32 partitions


end

cut_recursive = edgesCutRecursive;
cut_kway = edgesCutKway;

disp('---------------------------------')
disp('Recursive')
disp(cut_recursive(1,1))
disp(cut_recursive(1,2))
disp(cut_recursive(2,1))
disp(cut_recursive(2,2))
disp('---------------------------------')

disp('---------------------------------')
disp('Kway')
disp(cut_kway(1,1))
disp(cut_kway(1,2))
disp(cut_kway(2,1))
disp(cut_kway(2,2))
disp('---------------------------------')

end
