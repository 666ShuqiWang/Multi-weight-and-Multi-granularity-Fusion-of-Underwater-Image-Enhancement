clc;
clear;
close all;

img = imread('W1.jpg');
img = im2double(img);
%figure;imshow(img);title('ԭʼͼ��');

nums = 4;
Gau = cell(nums,1);
N =1;
% ԭͼ����˹��������ײ�
Gau{N} = img;
% ȷ����˹ģ����
a = 0.4;
h = [1/4-a/2 1/4 a 1/4 1/4-a/2];
% ------------------------���ɸ�˹������-------------------------------% 

for N = 2:nums
    temp = imfilter(Gau{N-1},h,'conv','same','replicate');
    temp = imfilter(temp,h','conv','same','replicate');
    Gau{N} = temp(1:2:end,1:2:end,:);
end
% ��ʾ��˹������ 
 %for N = 1:nums
 %   str = sprintf('%s%d%s','��˹�������� ',N,'��');
    figure;imshow(Gau{5});imwrite(Gau{5},'E.JPG');
% end
%imshow(uint8(Gau{N}),'border','tight','initialmagnification','fit');    % ʵ����strain_image�����Լ���ͼ��.
%set (gcf,'Position',[0,0,1037,778]);     % 256���Լ������ͼ��ĸ�ʽ�� 
%axis normal;
%saveas(gca,'11.emf','emf');     % ����Ϊbmp��ʽ

