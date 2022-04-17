%para=0代表原始方法，para=1代表改进后的方法
function out = WhitePatchRetinex(in,para)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%%%copyright: ofalling %%%%
if( nargin < 2 )
para = 0;
end
out = zeros(size(in));            %out定义一个和输入图像同等大小的零矩阵
inDouble = double(in);            %将图像转换为double型
L = [0 0 0];                      %定义一个行向量，用于存放光源的三个通道的值
if ( para == 0 )                  %para=0，表示采用原始方法
for i = 1:3             
L(i) = max(max(in(:,:,i)));       %分别获取三个通道中的最大值
out(:,:,i) = inDouble(:,:,i)/L(i);%获取输出图像
end
elseif ( para == 1 )              % more robust algorithm
np = 0.1 * size(in,1)*size(in,2); %获取总像素个数的10%
for i = 1:3                         
H = imhist(in(:,:,i));            %每个通道的直方图
j = 256;
sum = 0;
while( (sum < np)&(j > 1) )       %只要像素点个数没有统计完，并且j>1
j = j-1;
sum = sum + H(j);                 %累加直方图值
end
L(i) = j;
out(:,:,i) = inDouble(:,:,i)/L(i);%输出图
end
end
end