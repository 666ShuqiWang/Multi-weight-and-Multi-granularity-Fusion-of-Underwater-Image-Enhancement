%%%%%%%%This is a demo for the usage of PCQI with default settings%%%%%%%%%%%%%%%%%%
clc;
clear;
%im1=imread('C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\��ѡ Underwater_Image_Enhancement_Using_MultiFusion_Technique-master\image5��ͷ\result.jpg');
%im1=imread('C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\GAN\1\UGAN-pytorch-master\output\1\601030\1.jpg');
im1=imread('C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\GAN\1\UGAN-pytorch-master\PyTorch\data\test\1.jpg');
%im2=imread('HE.JPG');
im2=imread('C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\GAN\1\UGAN-pytorch-master\PyTorch\data\car\1.jpg');
%im2=imread('Drews J P.JPG');
%im2=imread('Galdran.jpg');
%im2=imread('2018.JPG');
%im2=imread('our result.jpg');

im1=double(rgb2gray(im1));
im2=double(rgb2gray(im2));
%����ļ���pcqi������
[mpcqi,pcqi_map]=PCQI(im1,im2);

%