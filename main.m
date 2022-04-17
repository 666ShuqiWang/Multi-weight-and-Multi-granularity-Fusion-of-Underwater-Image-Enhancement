clear all
%tic
img = imread('C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\GAN\1\UGAN-pytorch-master\PyTorch\data\test\1\16.jpg');
% white balance
img1 = ColorBalance(img);
%img1 = imread('ͼ2-white patch.jpg');
cform = makecform('srgb2lab');%srgbתlab�Ĺ�ʽ�������� 
lab1 = applycform(img1,cform);%LAB��ʽ 
%figure;imshow(img1);
%imwrite(img1,'whitebalance.jpg'); 

%��ʾlab��ɫ�ռ����������
%Lab = lab2double(Lab);
%L = Lab(:,:,1);%L*��������
%a = Lab(:,:,2);%a*�������ɫ����ɫ�ķ���
%b = Lab(:,:,3);%b*�������ɫ����ɫ�ķ���
%imshow(Lab)

%lab11 = applycform(img,cform);%LAB��ʽ 

% CLAHE
%CLAHE��Ӣ����Contrast Limited Adaptive Histogram Equalization 
%���ƶԱȶȵ�����Ӧֱ��ͼ����
lab2 = lab1;
lab2(:, :, 1) = adapthisteq(lab2(:, :, 1));
cform = makecform('lab2srgb');
img2 = applycform(lab2,cform);
figure;
imshow(img2);
%img2 = imread('putongzhifangtu.jpg');
%imwrite(img2,'./dierpianlunwen/CLAHE6.jpg'); 

% input  
R1 = double(lab1(:, :, 1)) / 255; %lab��ɫ�ռ����������
R2 = double(lab2(:, :, 1)) / 255;%L = Lab(:,:,1);

% calculate the saturation weight
WSat1 = Saturation_weight(img1);
WSat2 = Saturation_weight(img2);
%imwrite(WSat1,'WSat1.jpg'); 
%imwrite(WSat2,'WSat2.jpg'); 

% calculate laplacian contrast weight
%����������˹�Աȶ�Ȩ��
%Laplacian contrast weight (Laplacian filiter on input luminance channel
%������˹���ӶԱ�����(������˹����filiter��������ͨ��
Wlap1 = abs(imfilter(R1, fspecial('Laplacian'), 'replicate', 'conv'));
Wlap2 = abs(imfilter(R2, fspecial('Laplacian'), 'replicate', 'conv'));
%imwrite(Wlap1,'Wlap1.jpg'); 
%imwrite(Wlap2,'Wlap2.jpg'); 

%calculate Local contrast weight
%����ֲ��Աȶ�Ȩ��
h = 1/16* [1, 4, 6, 4, 1];
Wcont1 = imfilter(R1, transpose(h)*h, 'replicate', 'conv');
Wcont11 = R1 - Wcont1;
Wcont2 = imfilter(R2, transpose(h)*h, 'replicate', 'conv');
Wcont22 =R2 - Wcont2;
%Wcont22 =(R2 - Wcont2).^2;
%imwrite(Wcont1,'Wcont1.jpg'); 
%imwrite(Wcont2,'Wcont2.jpg'); 
%figure;
%imshow(Wcont22);
% calculate the saliency weight
%����������Ȩ��
Wsal1 = saliency_detection(img1);
Wsal2 = saliency_detection(img2);
%figure;
%imshow(Wsal1);
%imwrite(Wsal1,'Wsal1.jpg'); 
%imwrite(Wsal2,'Wsal2.jpg'); 
% calculate the exposedness weight
%�����ع��Ȩ�أ�����
sigma = 0.25;
avg = 0.5;
Wexp1 = exp(-(R1 - avg).^2 / (2*sigma^2));
Wexp2 = exp(-(R2 - avg).^2 / (2*sigma^2));
%imwrite(Wexp1,'Wexp1.jpg'); 
%imwrite(Wexp2,'Wexp2.jpg'); 

% calculate the normalized weight
%�����׼��Ȩ��

W11 =WSat1+Wlap1+Wcont1+Wsal1+Wexp1;
W22 = WSat2+Wlap2+Wcont2+Wsal2+Wexp2;
%figure;
%imshow(W11);
%imshow(W22);
%W1 = ( Wexp1) ./ (Wexp1 +Wexp2);
%W2 = (Wexp2 )./ (Wexp1 +Wexp2);
%W1 = ( WSat1+Wsal1) ./ (WSat1+WSat2+Wsal1+Wsal2);
%W2 = (WSat2+Wsal2 )./ (WSat1+WSat2+Wsal1+Wsal2);
%W1 = (Wlap1+Wcont1+Wexp1 ) ./ (Wlap1+Wlap2+Wcont1+Wcont2+Wexp1+Wexp2);
%W2 = (Wlap2+Wcont2+Wexp2 )./ (Wlap1+Wlap2+Wcont1+Wcont2+Wexp1+Wexp2);
W1 = (WSat1+Wlap1+Wcont1+Wsal1+Wexp1 ) ./ (WSat1+WSat2+Wlap1+Wlap2+Wcont1+Wcont2+Wsal1+Wsal2+Wexp1+Wexp2);
W2 = (WSat2+Wlap2+Wcont2+Wsal2+Wexp2 )./ (WSat1+WSat2+Wlap1+Wlap2+Wcont1+Wcont2+Wsal1+Wsal2+Wexp1+Wexp2);

%imwrite(W1,'W1.jpg'); 
%imwrite(W2,'W2.jpg'); 


% calculate the gaussian pyramid
%�����˹���������ڶ�����W1/W2 2�Ź�һ��Ȩ��ͼ�ֽ�ɸ�˹������
level = 9;%���Գ�����ʹ��ֵ���Ż�!!!!!!!!!
Weight1 = gaussian_pyramid(W1, level);
Weight2 = gaussian_pyramid(W2, level);

% calculate the laplacian pyramid
%����������˹����������һ���� W1/W2 ������ͼ�ֽ��������˹������
% input1
R1 = laplacian_pyramid(double(double(img1(:, :, 1))), level);
G1 = laplacian_pyramid(double(double(img1(:, :, 2))), level);
B1 = laplacian_pyramid(double(double(img1(:, :, 3))), level);
% input2
R2 = laplacian_pyramid(double(double(img2(:, :, 1))), level);
G2 = laplacian_pyramid(double(double(img2(:, :, 2))), level);
B2 = laplacian_pyramid(double(double(img2(:, :, 3))), level);



%figure;
%imshow(char_str,'border','tight','initialmagnification','fit');    % ʵ����strain_image�����Լ���ͼ��.
%set (gcf,'Position',[0,0,1037,778]);     % 256���Լ������ͼ��ĸ�ʽ�� 
%axis normal;
%saveas(gca,'R1.emf','emf');     % ����Ϊbmp��ʽ

% fusion���������ֱ�Ե�һ���������ͼ�ڸ� 9 ������ںϣ��õ���߶��ں�ͼ�� ��
%���Ĳ��Խ������ϲ�����������ͼ��
%�ں�
for i = 1 : level
    r_py{i} = Weight1{i} .* R1{i} + Weight2{i} .* R2{i};
    g_py{i} = Weight1{i} .* G1{i} + Weight2{i} .* G2{i};
	b_py{i} = Weight1{i} .* B1{i} + Weight2{i} .* B2{i};
end


for i = level : -1 : 2
    [m, n] = size(g_py{i - 1});
    g_py{i - 1} = g_py{i - 1} + imresize(g_py{i}, [m, n]);
end
G = g_py{1};

for i = level : -1 : 2
    [m, n] = size(r_py{i - 1});
    r_py{i - 1} = r_py{i - 1} + imresize(r_py{i}, [m, n]);
end
R = r_py{1};


for i = level : -1 : 2
    [m, n] = size(b_py{i - 1});
    b_py{i - 1} = b_py{i - 1} + imresize(b_py{i}, [m, n]);
end
B = b_py{1};
fusion = cat(3, uint8(R), uint8(G), uint8(B));


uiconm = UIConM(fusion)
uiqm = UIQM(fusion)
uciqe = UCIQE(fusion)
%figure, imshow( fusion)
%toc
%disp(['����ʱ�䣺',num2str(toc)]);
imwrite(fusion,'C:\Users\ll\Desktop\matlab���뼰ͼ��\ģ��ͼ��\ˮ��ͼ��\GAN\1\UGAN-pytorch-master\PyTorch\data\acuti\1\16.jpg');  

%figure;
%imshow(fusion,'border','tight','initialmagnification','fit');    % ʵ����strain_image�����Լ���ͼ��.
%set (gcf,'Position',[0,0,1037,778]);     % 256���Լ������ͼ��ĸ�ʽ�� 
%axis normal;
%saveas(gca,'chuanfusion.emf','emf');     % ����Ϊbmp��ʽ
%imwrite(fusion,'chuanfusion.jpg'); 

f=fspecial('average',31);%H =fspecial(��average��,hsize) �����ɾ�ֵ�˲�����hsizeͬ��ָ���˲����ĳߴ磬Ĭ����3��3��  
B=imfilter(fusion,f,'conv','replicate');%I�Ļ�����
D=fusion-B;%I��ϸ��ͼ
Z=imfilter(B,f,'conv','replicate');%I�Ļ�����
Z1=B-Z;%Z��ϸ��ͼ
I1=Z1+D+fusion;
 
%figure;
%imshow(I1,'border','tight','initialmagnification','fit');    % ʵ����strain_image�����Լ���ͼ��.
%set (gcf,'Position',[0,0,1037,778]);     % 256���Լ������ͼ��ĸ�ʽ�� 
%axis normal;
%saveas(gca,'Z.emf','emf');     % ����Ϊbmp��ʽ
%imwrite(fusion,'C:/Users/ll/Desktop/matlab���뼰ͼ��/ģ��ͼ��/ˮ��ͼ��/GAN/1/UGAN-pytorch-master/data/test/1/1/delight/55.jpg');
