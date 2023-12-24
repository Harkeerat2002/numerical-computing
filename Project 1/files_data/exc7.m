file = load("householder\housegraph.mat");



A = file.A;
A = A - diag(diag(A));

authors = file.name;
[topValues, indices] = maxk(sum(A), 5);

for i = 1:5
    n = ''
    for j = 1:20
        n = [n, authors(indices(i), j)];
    end
end

            