function r=Guassion(im)
    radius=5;
    delta=1;
    GuassionSmooth=GuassionMatrix(delta,radius);
    %怎样把循环优化了呢---------------------------------------
    im=double(im);
    [m,n,z]=size(im);
    r=zeros(m,n,z);
    for i=1:m
        for j=1:n
            for k=-radius:radius
                for l=-radius:radius
                    x1=i+k+1;
                    if x1<1
                        x1=x1-2*k+1;
                    end
                    if x1>m
                        x1=x1-2*k-1;
                    end
                    x2=j+l+1;
                    if x2<1
                        x2=x2-2*l+1;
                    end
                    if x2>n
                        x2=x2-2*l-1;
                    end
                    r(i,j,:)=r(i,j,:)+im(x1,x2,:)*GuassionSmooth(k+radius+1,l+radius+1);
                end
            end
        end
    end
   
