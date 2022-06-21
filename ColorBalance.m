% 通过直方图标准化执行色彩平衡。
% satLevel 控制要裁剪为白色和黑色的像素百分比。
% 设置 plot = 0 或 1 以打开或关闭诊断图。
function outval = ColorBalance(im_org)
num = 255;
if ndims(im_org) == 3
    R = sum(sum(im_org(:,:,1)))
    G = sum(sum(im_org(:,:,2)))
    B = sum(sum(im_org(:,:,3)))%计算每一个像素之和
    Max = max([R, G, B])
    ratio = [Max / R, Max / G, Max / B]%按照的值的大小计算出 Ratio 的白色参考点的阈值 T TT。
%全宽度直方图法
    satLevel1 = 0.005 * ratio%图像饱和为黑色或白色的百分比，可调整参数
    satLevel2 = 0.005 * ratio
    
    [m, n, p] = size(im_org);%m,n是矩阵行数与列数,彩色图P就是3，灰度图P为2
    imRGB_orig = zeros(p, m * n);%比如a=zeros(3,5);就是创建一个3行5列的0矩阵，M*N为图像的像素数量
    for i = 1 : p
        imRGB_orig(i, :) = reshape(double(im_org(:, :, i)), [1, m * n]);%对数组进行重新变形
        %A = reshape（A，[m,n]）  % 将A 的行列排列成m行n列
    end
else
  
    satLevel1 = 0.001;
    satLevel2 = 0.005;
    [m, n] = size(im_org);%读入的im_org图片的尺寸是m行n列
    p = 1;
    imRGB_orig = reshape(double(im_org), [1, m * n]);%M*N为图像的像素数量
end
% full width histogram method全宽直方图方法
% percentage of the image to saturate to black or white, tweakable param
%饱和度 = .01; 图像饱和到黑色或白色的百分比，可调整参数
imRGB = zeros(size(imRGB_orig));

%真正代码思想从这开始

for ch = 1 : p 
  %确定每个 RGB 通道的直方图，并找到与我们所需的饱和度水平相对应的分位数。  
    q = [satLevel1(ch), 1 - satLevel2(ch)]
    tiles = quantile(imRGB_orig(ch, :), q)
     % 计算每一维度的最小值与最大值
    temp = imRGB_orig(ch, :);
    temp(find(temp < tiles(1))) = tiles(1);%检查百分比是否正确
    temp(find(temp > tiles(2))) = tiles(2);
    imRGB(ch, :) = temp;
    %缩放饱和直方图以跨越整个 0-255 范围。
    bottom = min(imRGB(ch, :)) %底部
    top = max(imRGB(ch, :))
    imRGB(ch, :) = (imRGB(ch, :) - bottom) * num / (top - bottom);
    %一般采用最大-最小规范化对原始数据进行线性变换：X*=（X-Xmin）/(Xmax-Xmin)
end
if ndims(im_org) == 3
    outval = zeros(size(im_org));
    for i = 1 : p
        outval(:, :, i) = reshape(imRGB(i, :), [m, n]); 
    end
else
    outval = reshape(imRGB, [m, n]); 
end
outval = uint8(outval);
