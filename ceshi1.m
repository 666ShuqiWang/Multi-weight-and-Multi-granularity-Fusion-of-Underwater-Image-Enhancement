%fusion = imread('Drews J P.jpg');
fusion = imread('C:\Users\ll\Desktop\matlab???뼰ͼ??\ģ??ͼ??\ˮ??ͼ??\GAN\1\UGAN-pytorch-master\PyTorch\data\UDCP\1\16.jpg');
%fusion = imread('Galdran.jpg');
%fusion = imread('he.jpg');
%fusion = imread('our result.jpg');
%fusion = imread('2018.jpg');
%fusion = imread('2012.jpg');
uicm=UICM(fusion)
uiconm=UIConM(fusion)
uism = UISM(fusion)
uiqm = UIQM(fusion)
uciqe = UCIQE(fusion)