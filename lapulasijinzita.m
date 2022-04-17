close all
clear 
clc



%img=imread('W2.jpg');
%img_gray=rgb2gray(img);
img_gray=imread('W2.jpg');
img_filter=double(img_gray);
%% ���ý�����������p����˹������Ԫ������ΪgausPyramid��������˹������Ԫ������ΪLaplPyramid
p=5;
gausPyramid=cell(1,p);
LaplPyramid=gausPyramid;

%% 5*5��˹�ˣ�sigma=1
kernel=fspecial('gaussian',5,1);
% ��˹�˳���4�������غ㣩
kernel1=4.*kernel;

%% ����gausPyramid��LaplPyramid
[m,n]=size(img_filter);
gausPyramid(1)=mat2cell(img_filter,m,n);
for i=2:p        
    %% ��˹������
    % �˲�
    img_filter1=filter2(kernel,img_filter,'same');
    % �²�����ȥ��ż���С���
    img_filter1(2:2:end,:)=[];
    img_filter1(:,2:2:end)=[];    
    [m,n]=size(img_filter1);
    gausPyramid(i)=mat2cell(img_filter1,m,n);

    %% ������˹������
    % �ϲ���������ȫ���С���
    img_filter2=zeros(2*m,2*n);
    img_filter2(1:2:2*m,1:2:2*n)=img_filter1(1:m,1:n);
    % �˲�
    img_filter2=filter2(kernel1,img_filter2,'same');
    img_filter2=img_filter-img_filter2;
    LaplPyramid(i-1)=mat2cell(img_filter2,2*m,2*n);
   
    img_filter=img_filter1;
end
LaplPyramid(p)=gausPyramid(p);

%% ��ʾ����������Ԫ��������ͳ�Ƶ�һ��������
img_gaus=cell2mat(gausPyramid(1));
[r,~]=size(img_gaus);
img_lapl=cell2mat(LaplPyramid(1));
[r1,~]=size(img_lapl);
for i=2:p
    %% ��˹������
    img_filter=cell2mat(gausPyramid(i));
    [m,~]=size(img_filter);
    % �ڵ�һ��ǰ�油(r-m)��ȫ255��,10��ȫ255�У�������ͼ���ж���
    img_filter=padarray(img_filter,[r-m 10],255,'pre');
    img_gaus=[img_gaus img_filter];

    %% ������˹������
    img_filter=cell2mat(LaplPyramid(i));
    [m,~]=size(img_filter);
     % �ڵ�һ��ǰ�油(r-m)��ȫ255��,10��ȫ255�У�������ͼ���ж���
    img_filter=padarray(img_filter,[r1-m 10],255,'pre');
    img_lapl=[img_lapl img_filter];
end
figure('Name','gausPyramid');
imshow(uint8(img_gaus));
imwrite(uint8(img_gaus),'img_gaus.jpg');
figure('Name','LaplPyramid');
imshow(uint8(abs(img_lapl)));imwrite(uint8(abs(img_lapl)),'img_lapl.jpg');
