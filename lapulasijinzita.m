close all
clear 
clc



%img=imread('W2.jpg');
%img_gray=rgb2gray(img);
img_gray=imread('W2.jpg');
img_filter=double(img_gray);
%% 设置金字塔层数：p，高斯金字塔元胞数组为gausPyramid，拉普拉斯金字塔元胞数组为LaplPyramid
p=5;
gausPyramid=cell(1,p);
LaplPyramid=gausPyramid;

%% 5*5高斯核，sigma=1
kernel=fspecial('gaussian',5,1);
% 高斯核乘以4（亮度守恒）
kernel1=4.*kernel;

%% 计算gausPyramid和LaplPyramid
[m,n]=size(img_filter);
gausPyramid(1)=mat2cell(img_filter,m,n);
for i=2:p        
    %% 高斯金字塔
    % 滤波
    img_filter1=filter2(kernel,img_filter,'same');
    % 下采样：去掉偶数行、列
    img_filter1(2:2:end,:)=[];
    img_filter1(:,2:2:end)=[];    
    [m,n]=size(img_filter1);
    gausPyramid(i)=mat2cell(img_filter1,m,n);

    %% 拉普拉斯金字塔
    % 上采样：新增全零行、列
    img_filter2=zeros(2*m,2*n);
    img_filter2(1:2:2*m,1:2:2*n)=img_filter1(1:m,1:n);
    % 滤波
    img_filter2=filter2(kernel1,img_filter2,'same');
    img_filter2=img_filter-img_filter2;
    LaplPyramid(i-1)=mat2cell(img_filter2,2*m,2*n);
   
    img_filter=img_filter1;
end
LaplPyramid(p)=gausPyramid(p);

%% 显示金字塔，把元胞金字塔统计到一个数组中
img_gaus=cell2mat(gausPyramid(1));
[r,~]=size(img_gaus);
img_lapl=cell2mat(LaplPyramid(1));
[r1,~]=size(img_lapl);
for i=2:p
    %% 高斯金字塔
    img_filter=cell2mat(gausPyramid(i));
    [m,~]=size(img_filter);
    % 在第一行前面补(r-m)行全255行,10列全255列，与最大的图像行对齐
    img_filter=padarray(img_filter,[r-m 10],255,'pre');
    img_gaus=[img_gaus img_filter];

    %% 拉普拉斯金字塔
    img_filter=cell2mat(LaplPyramid(i));
    [m,~]=size(img_filter);
     % 在第一行前面补(r-m)行全255行,10列全255列，与最大的图像行对齐
    img_filter=padarray(img_filter,[r1-m 10],255,'pre');
    img_lapl=[img_lapl img_filter];
end
figure('Name','gausPyramid');
imshow(uint8(img_gaus));
imwrite(uint8(img_gaus),'img_gaus.jpg');
figure('Name','LaplPyramid');
imshow(uint8(abs(img_lapl)));imwrite(uint8(abs(img_lapl)),'img_lapl.jpg');
