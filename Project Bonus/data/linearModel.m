crudeOil = importdata('crudeOil.txt');
kerosene = importdata('kerosene.txt');


crudeOilData = crudeOil(3:end);




A_array = [];
b_array = [];
for index = 1:length(crudeOilData)
    str = crudeOilData{index};
    parts = strsplit(str, ' ');
    if ~isempty(parts)
        part = strsplit(parts{1}, '	');
        A_array = [A_array, str2double(part{2})];
        b_array = [b_array, str2double(part{3})];
    end
end




A = [ones(1, length(A_array)); A_array];
A = A';

b = b_array';


[x_star1, norm_r1, SE1, RMSE1] = leastSquares(A, b);

disp('x_star1');
disp(x_star1);
