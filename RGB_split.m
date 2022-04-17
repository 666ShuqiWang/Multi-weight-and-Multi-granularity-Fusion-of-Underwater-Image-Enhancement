%%RGB_split.m

image = imread('331.jpg');

%%显示原图片
%%imshow(image)

%%R通道
R = image(:,:,1);
imshow(R)
imwrite(R,'R.jpg');

%%G通道
G = image(:,:,2);
imshow(G)
imwrite(G,'G.jpg');

%%B通道
B = image(:,:,3);
imshow(B)
imwrite(B,'B.jpg');
