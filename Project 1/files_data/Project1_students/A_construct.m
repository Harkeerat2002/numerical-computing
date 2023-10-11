function [A,nz] = A_construct(n)
    A = zeros(n);
    for i = 1:n
        for j = 1:n
            if i == j
                A(i, j) = n + i - 1;
            elseif i == 1 || i == n || j == 1 || j == n
                A(i, j) = 1;
            else
                A(i, j) = 0;
            end
        end
    end
  nz = nnz(A);
end

