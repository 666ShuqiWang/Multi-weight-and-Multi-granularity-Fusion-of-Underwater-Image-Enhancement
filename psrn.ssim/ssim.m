function [mssim, ssim_map] = ssim(img1, img2, K, window, L)
 
if (nargin < 2 | nargin > 5)
   ssim_index = -Inf;
   ssim_map = -Inf;
   return;
end
 
if (size(img1) ~= size(img2))
   ssim_index = -Inf;
   ssim_map = -Inf;
   return;
end
 
[M N] = size(img1);
 
if (nargin == 2)
   if ((M < 11) | (N < 11))   % ͼ���С��С��û�����塣
           ssim_index = -Inf;
           ssim_map = -Inf;
      return
   end
   window = fspecial('gaussian', 11, 1.5); % ����һ����׼ƫ��1.5��11*11�ĸ�˹��ͨ�˲���
   K(1) = 0.01;                % default settings
   K(2) = 0.03;                                    
   L = 255;                                  
end
if (nargin == 3)
   if ((M < 11) | (N < 11))
           ssim_index = -Inf;
           ssim_map = -Inf;
      return
   end
   window = fspecial('gaussian', 11, 1.5);
   L = 255;
   if (length(K) == 2)
      if (K(1) < 0 | K(2) < 0)
                   ssim_index = -Inf;
                   ssim_map = -Inf;
                   return;
      end
   else
           ssim_index = -Inf;
           ssim_map = -Inf;
           return;
   end
end
if (nargin == 4)
   [H W] = size(window);
   if ((H*W) < 4 | (H > M) | (W > N))
           ssim_index = -Inf;
           ssim_map = -Inf;
      return
   end
   L = 255;
   if (length(K) == 2)
      if (K(1) < 0 | K(2) < 0)
                   ssim_index = -Inf;
                   ssim_map = -Inf;
                   return;
      end
   else
           ssim_index = -Inf;
           ssim_map = -Inf;
           return;
   end
end
if (nargin == 5)
   [H W] = size(window);
   if ((H*W) < 4 | (H > M) | (W > N))
           ssim_index = -Inf;
           ssim_map = -Inf;
      return
   end
   if (length(K) == 2)
      if (K(1) < 0 | K(2) < 0)
                   ssim_index = -Inf;
                   ssim_map = -Inf;
                   return;
      end
   else
           ssim_index = -Inf;
           ssim_map = -Inf;
           return;
   end
end
if size(img1,3)~=1  %�ж�ͼ��ʱ���ǲ�ɫͼ������ǣ����Ϊ3������Ϊ1
   org=rgb2ycbcr(img1);
   test=rgb2ycbcr(img2);
   y1=org(:,:,1);
   y2=test(:,:,1);
   y1=double(y1);
   y2=double(y2);
 else 
     y1=double(img1);
     y2=double(img2);
 end
img1 = double(y1); 
img2 = double(y2);
% automatic downsampling
%f = max(1,round(min(M,N)/256));
%downsampling by f
%use a simple low-pass filter
% if(f>1)
%     lpf = ones(f,f);
%     lpf = lpf/sum(lpf(:));
%     img1 = imfilter(img1,lpf,'symmetric','same');
%     img2 = imfilter(img2,lpf,'symmetric','same');
%     img1 = img1(1:f:end,1:f:end);
%     img2 = img2(1:f:end,1:f:end);
% end
 
C1 = (K(1)*L)^2;    % ����C1������������L��x��y���á�    C1=6.502500
C2 = (K(2)*L)^2;    % ����C2���������Աȶ�C��x��y���á�  C2=58.522500 
window = window/sum(sum(window)); %�˲�����һ��������
 
 
mu1   = filter2(window, img1, 'valid');  % ��ͼ������˲����Ӽ�Ȩ  valid�ĳ�same������
mu2   = filter2(window, img2, 'valid');  % ��ͼ������˲����Ӽ�Ȩ
 
mu1_sq = mu1.*mu1;     % �����Uxƽ��ֵ��
mu2_sq = mu2.*mu2;     % �����Uyƽ��ֵ��
mu1_mu2 = mu1.*mu2;    % ����Ux*Uyֵ��
 
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;  % ����sigmax ����׼�
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;  % ����sigmay ����׼�
sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;   % ����sigmaxy����׼�
 
if (C1 > 0 & C2 > 0)
   ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
else
   numerator1 = 2*mu1_mu2 + C1;
   numerator2 = 2*sigma12 + C2;
   denominator1 = mu1_sq + mu2_sq + C1;
   denominator2 = sigma1_sq + sigma2_sq + C2;
   ssim_map = ones(size(mu1));
   index = (denominator1.*denominator2 > 0);
   ssim_map(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
   index = (denominator1 ~= 0) & (denominator2 == 0);
   ssim_map(index) = numerator1(index)./denominator1(index);
end
mssim = mean2(ssim_map);
 
return
%img1= imread('image1.jpg'); img2= imread('image2.jpg');  ssim(img1,img2)