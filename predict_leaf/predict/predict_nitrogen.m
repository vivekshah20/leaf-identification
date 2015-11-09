function nitro=predict_nitrogen()
    source = '.\predict_leaf\predict\original_image.jpg';
    img=imread(source);
    [r,c,l]=size(img);
    v=zeros(r,c);
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);
    for i=1:r
        for j=1:c
                  if B(i,j) > 90
                     R(i,j)=0;
                     G(i,j)=0;
                     B(i,j)=0;
                  end
        end
    end
    image=cat(3, R, G, B);
   % [HSI,H,S,I] = convert_HSI(image);
    R_av=mean(mean(R))/255;
    G_av=mean(mean(G))/255;
    B_av=mean(mean(B))/255;
    maxi = max(max(R_av,G_av),B_av);
    mini = min(min(R_av,G_av),B_av);
    if maxi == R_av
        H=((G_av-B_av)/(maxi-mini))*60;
    end
    if maxi == G_av
        H=(((B_av-R_av)/(maxi-mini))+2)*60;
    end
    if maxi == B_av
        H=(((R_av-G_av)/(maxi-mini))+4)*60;
    end
    S=(maxi-mini)/maxi;
    B=maxi;
   nitro = ((H - 60)/60 + (1 - S) + (1 - B))/3;
end