%%%%%%%%This is a demo for the usage of PCQI with default settings%%%%%%%%%%%%%%%%%%
clc;
clear;
%im1=imread('C:\Users\ll\Desktop\matlab代码及图像\模糊图像\水下图像\首选 Underwater_Image_Enhancement_Using_MultiFusion_Technique-master\image5船头\result.jpg');
%im1=imread('C:\Users\ll\Desktop\matlab代码及图像\模糊图像\水下图像\GAN\1\UGAN-pytorch-master\output\1\601030\1.jpg');
im1=imread('C:\Users\ll\Desktop\matlab代码及图像\模糊图像\水下图像\GAN\1\UGAN-pytorch-master\PyTorch\data\test\1.jpg');
%im2=imread('HE.JPG');
im2=imread('C:\Users\ll\Desktop\matlab代码及图像\模糊图像\水下图像\GAN\1\UGAN-pytorch-master\PyTorch\data\car\1.jpg');
%im2=imread('Drews J P.JPG');
%im2=imread('Galdran.jpg');
%im2=imread('2018.JPG');
%im2=imread('our result.jpg');

im1=double(rgb2gray(im1));
im2=double(rgb2gray(im2));
%这份文件的pcqi有问题
[mpcqi,pcqi_map]=PCQI(im1,im2);

%