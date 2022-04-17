function ret = grayWorld1( im )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);

avgR = mean(mean(r));
avgG = mean(mean(g));
avgB = mean(mean(b));

avgRGB = [avgR avgG avgB];
grayValue = (avgR + avgG + avgB)/3;
scaleValue = grayValue./avgRGB;

ret(:,:,1) = scaleValue(1) * r;
ret(:,:,2) = scaleValue(2) * g;
ret(:,:,3) = scaleValue(3) * b;
end
