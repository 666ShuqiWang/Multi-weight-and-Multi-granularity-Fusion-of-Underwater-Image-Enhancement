function Wsat = Saturation_weight(image)

[m, n, ~] = size(image);


lab = double(rgb_to_lab(image)/255);


for i = 1 : m
    for j = 1 : n
        Wsat(i,j) = (1/3 * ((double(image(i,j,1)) - lab(i,j,1))^2 +  (double(image(i,j,2)) - lab(i,j,1))^2  +  double((image(i,j,3)) - lab(i,j,1))^2) )^0.5;
    end
end
%lab(i,j,1)变量LAB色彩空间下的第一个空间L的矩阵
end