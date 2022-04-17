clear all; close all; clc;

img=double(imread('33.jpg'));
[m n]=size(img);

w=1/256*[1  4  6  4 1;      %������˹�˲���
         4 16 24 16 4;
         6 24 36 24 6;
         4 16 24 16 4;
         1  4  6  4 1];

imgn{1}=img;
for i=2:5                   %�˲����²���
   imgn{i}=imfilter(imgn{i-1},w,'replicate');
   imgn{i}=imgn{i}(1:2:size(imgn{i},1)-1,1:2:size(imgn{i},2)-1); %i-1������
end
       
for i=5:-1:2        %����ͼ���С
   imgn{i-1}=imgn{i-1}(1:2*size(imgn{i},1),1:2*size(imgn{i},2)); 
end

 for i=1:4          %��òв�ͼ��i��Ԥ��в�
    imgn{i}=imgn{i}-expand(imgn{i+1},w);     
 end
 
for i=4:-1:1        %�в�ͼ���ع�ԭͼ��
    imgn{i}=imgn{i}+expand(imgn{i+1},w);
end

imshow(uint8(imgn{1}));