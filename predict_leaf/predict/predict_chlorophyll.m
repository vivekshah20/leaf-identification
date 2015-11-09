function chloro = predict_chlorophyll()
    source = '.\predict_leaf\predict\original_image.jpg';
    img=imread(source);
    [ r, c, l]=size(img);
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
   R1=mean(mean(R));
   G1=mean(mean(G));
   B1=mean(mean(B));
   chloro=G1-(R1/2)-(B1/2);
end
   