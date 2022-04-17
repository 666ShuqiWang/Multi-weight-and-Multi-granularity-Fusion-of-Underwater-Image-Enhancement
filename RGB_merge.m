%%RGB_merge.m

R=imread('R1.JPG');
G=imread('G1.JPG');
B=imread('B1.JPG');

RGB(:,:,1)=R(:,:,1);
RGB(:,:,2)=G(:,:,1);
RGB(:,:,3)=B(:,:,1);
imshow(RGB)
imwrite(RGB,'RGB1.JPG');
