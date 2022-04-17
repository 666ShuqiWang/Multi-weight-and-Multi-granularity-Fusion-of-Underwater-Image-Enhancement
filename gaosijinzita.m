clc;
clear;
close all;

img = imread('W1.jpg');
img = im2double(img);
%figure;imshow(img);title('原始图像');

nums = 4;
Gau = cell(nums,1);
N =1;
% 原图进高斯金字塔最底层
Gau{N} = img;
% 确定高斯模糊核
a = 0.4;
h = [1/4-a/2 1/4 a 1/4 1/4-a/2];
% ------------------------生成高斯金字塔-------------------------------% 

for N = 2:nums
    temp = imfilter(Gau{N-1},h,'conv','same','replicate');
    temp = imfilter(temp,h','conv','same','replicate');
    Gau{N} = temp(1:2:end,1:2:end,:);
end
% 显示高斯金字塔 
 %for N = 1:nums
 %   str = sprintf('%s%d%s','高斯金字塔第 ',N,'层');
    figure;imshow(Gau{5});imwrite(Gau{5},'E.JPG');
% end
%imshow(uint8(Gau{N}),'border','tight','initialmagnification','fit');    % 实际中strain_image换成自己的图像.
%set (gcf,'Position',[0,0,1037,778]);     % 256是自己保存的图像的格式， 
%axis normal;
%saveas(gca,'11.emf','emf');     % 保存为bmp格式

