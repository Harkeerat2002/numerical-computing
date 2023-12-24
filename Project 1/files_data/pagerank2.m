function x = pagerank2(U,G,p)
% PAGERANK  Google's PageRank
% pagerank(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factory p, (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank(U,G,p) returns the page ranks instead of printing.
% See also SURFER, SPY.

p = 0.85;

% Eliminate any self-referential links
% G = G - diag(diag(G));

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
I = speye(n,n);

e = ones(n,1);


% ---------------------------------- Inverse Iteration ------------------------------
% Solve (I - p*G*D)*x = e
disp('Using Inverse Iteartion Implementation\n');
G = p * G * D;

z = ((1 - p) * (c ~= 0) + (c == 0))/n;
A = p * G * D + e * z;

prec = 1e-16;
x = e/n;
x_old = zeros(size(x));
alpha = 0.99;
iter = 0;
while((norm(x - x_old)/ norm(x_old)) > prec)
    x_old = x;
    x = (alpha * I - A) \ x;
    x = x / norm(x,1);
    iter = iter + 1;
end

% -------------------------------------------------------------------------

% Normalize so that sum(x) == 1.
x = x/sum(x);

% Bar graph of page rank.
shg
bar(x)
title('Page Rank')

% Print URLs in page rank order.

if nargout < 1
   [~,q] = sort(-x);
   disp('     page-rank  in  out  url')
   k = 1;
   maxN = length(U);
   while  (k <= maxN) && (x(q(k)) >= .005)
       disp(k)
      j = q(k);
      temp1  = r(j);
      temp2  = c(j);
      disp(fprintf(' %3.0f %8.4f %4.0f %4.0f  %s', j,x(j),full(temp1),full(temp2),U{j}))
      k = k+1;
   end
   disp("Iterations");
   disp(iter);
end

