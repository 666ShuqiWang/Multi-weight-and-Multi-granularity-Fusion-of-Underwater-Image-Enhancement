% ͨ��ֱ��ͼ��׼��ִ��ɫ��ƽ�⡣
% satLevel ����Ҫ�ü�Ϊ��ɫ�ͺ�ɫ�����ذٷֱȡ�
% ���� plot = 0 �� 1 �Դ򿪻�ر����ͼ��
function outval = ColorBalance(im_org)
num = 255;
if ndims(im_org) == 3
    R = sum(sum(im_org(:,:,1)))
    G = sum(sum(im_org(:,:,2)))
    B = sum(sum(im_org(:,:,3)))%����ÿһ������֮��
    Max = max([R, G, B])
    ratio = [Max / R, Max / G, Max / B]%���յ�ֵ�Ĵ�С����� Ratio �İ�ɫ�ο������ֵ T TT��
%ȫ���ֱ��ͼ��
    satLevel1 = 0.005 * ratio%ͼ�񱥺�Ϊ��ɫ���ɫ�İٷֱȣ��ɵ�������
    satLevel2 = 0.005 * ratio
    
    [m, n, p] = size(im_org);%m,n�Ǿ�������������,��ɫͼP����3���Ҷ�ͼPΪ2
    imRGB_orig = zeros(p, m * n);%����a=zeros(3,5);���Ǵ���һ��3��5�е�0����M*NΪͼ�����������
    for i = 1 : p
        imRGB_orig(i, :) = reshape(double(im_org(:, :, i)), [1, m * n]);%������������±���
        %A = reshape��A��[m,n]��  % ��A ���������г�m��n��
    end
else
  
    satLevel1 = 0.001;
    satLevel2 = 0.005;
    [m, n] = size(im_org);%�����im_orgͼƬ�ĳߴ���m��n��
    p = 1;
    imRGB_orig = reshape(double(im_org), [1, m * n]);%M*NΪͼ�����������
end
% full width histogram methodȫ��ֱ��ͼ����
% percentage of the image to saturate to black or white, tweakable param
%���Ͷ� = .01; ͼ�񱥺͵���ɫ���ɫ�İٷֱȣ��ɵ�������
imRGB = zeros(size(imRGB_orig));

%��������˼����⿪ʼ

for ch = 1 : p 
  %ȷ��ÿ�� RGB ͨ����ֱ��ͼ�����ҵ�����������ı��Ͷ�ˮƽ���Ӧ�ķ�λ����  
    q = [satLevel1(ch), 1 - satLevel2(ch)]
    tiles = quantile(imRGB_orig(ch, :), q)
     % ����ÿһά�ȵ���Сֵ�����ֵ
    temp = imRGB_orig(ch, :);
    temp(find(temp < tiles(1))) = tiles(1);%���ٷֱ��Ƿ���ȷ
    temp(find(temp > tiles(2))) = tiles(2);
    imRGB(ch, :) = temp;
    %���ű���ֱ��ͼ�Կ�Խ���� 0-255 ��Χ��
    bottom = min(imRGB(ch, :)) %�ײ�
    top = max(imRGB(ch, :))
    imRGB(ch, :) = (imRGB(ch, :) - bottom) * num / (top - bottom);
    %һ��������-��С�淶����ԭʼ���ݽ������Ա任��X*=��X-Xmin��/(Xmax-Xmin)
end
if ndims(im_org) == 3
    outval = zeros(size(im_org));
    for i = 1 : p
        outval(:, :, i) = reshape(imRGB(i, :), [m, n]); 
    end
else
    outval = reshape(imRGB, [m, n]); 
end
outval = uint8(outval);
