file = load("householder\housegraph.mat");

% (Golub, Moler), (Golub, Saunders), (TChan, Demmel)

B = file.A;
B = B - diag(diag(B));

commonNames1 = [];
commonNames2 = [];
for i = 1:length(B)
    if B(file.TChan, i) == 1
        commonNames1 = [commonNames1, i];
    end
    if B(file.Demmel, i) == 1
        commonNames2 = [commonNames2, i];
    end
end

finalIntersection = intersect(commonNames1, commonNames2);