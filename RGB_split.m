%%RGB_split.m

image = imread('331.jpg');

%%��ʾԭͼƬ
%%imshow(image)

%%Rͨ��
R = image(:,:,1);
imshow(R)
imwrite(R,'R.jpg');

%%Gͨ��
G = image(:,:,2);
imshow(G)
imwrite(G,'G.jpg');

%%Bͨ��
B = image(:,:,3);
imshow(B)
imwrite(B,'B.jpg');
