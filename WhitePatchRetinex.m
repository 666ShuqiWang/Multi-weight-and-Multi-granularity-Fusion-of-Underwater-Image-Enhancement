%para=0����ԭʼ������para=1����Ľ���ķ���
function out = WhitePatchRetinex(in,para)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%%%copyright: ofalling %%%%
if( nargin < 2 )
para = 0;
end
out = zeros(size(in));            %out����һ��������ͼ��ͬ�ȴ�С�������
inDouble = double(in);            %��ͼ��ת��Ϊdouble��
L = [0 0 0];                      %����һ�������������ڴ�Ź�Դ������ͨ����ֵ
if ( para == 0 )                  %para=0����ʾ����ԭʼ����
for i = 1:3             
L(i) = max(max(in(:,:,i)));       %�ֱ��ȡ����ͨ���е����ֵ
out(:,:,i) = inDouble(:,:,i)/L(i);%��ȡ���ͼ��
end
elseif ( para == 1 )              % more robust algorithm
np = 0.1 * size(in,1)*size(in,2); %��ȡ�����ظ�����10%
for i = 1:3                         
H = imhist(in(:,:,i));            %ÿ��ͨ����ֱ��ͼ
j = 256;
sum = 0;
while( (sum < np)&(j > 1) )       %ֻҪ���ص����û��ͳ���꣬����j>1
j = j-1;
sum = sum + H(j);                 %�ۼ�ֱ��ͼֵ
end
L(i) = j;
out(:,:,i) = inDouble(:,:,i)/L(i);%���ͼ
end
end
end