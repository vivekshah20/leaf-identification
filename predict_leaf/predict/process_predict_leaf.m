function pred = process_predict_leaf()
    %%edit the add path
    addpath(genpath('.\predict_leaf'));
    k=1;
    %%
    %%Specify your image location here-------------------------------------
    source = '.\predict_leaf\predict\original_image.jpg';
    %%--------------------------------------------------------------------------
    img=imread(source);
    [r,c,l]=size(img);
    v=zeros(r,c);
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);
    for i=1:r
        for j=1:c
                  if B(i,j) > 60
                     v(i,j)=1;
                  end
        end
    end
    b = logical(not(v));
    b=imfill(b,'holes');
    %% specify your image location where it will save the binary image-----
    %%-------------------------------------------------------
    name='.\predict_leaf\predict\binary_image.jpg';
    %%---------------------------------------------------------------
    imwrite(b,name);
    pp=rgb2gray(img);
     for i=1:r
        for j=1:c
                  if b(i,j) == 0
                     pp(i,j) = 0;
                  end
        end
     end
    res=graycoprops(pp,{'contrast','homogeneity','Correlation','Energy'});
    arr(k,33)=res.Contrast;
    arr(k,34)=res.Homogeneity;
    arr(k,35)=res.Correlation;
    arr(k,36)=res.Energy;
    arr(k,37)=entropy(pp);
    results=regionprops(b,'Area','EulerNumber','Orientation','BoundingBox','Extent',...
        'Perimeter','Centroid','Extrema','PixelIdxList','ConvexArea',...
        'FilledArea','PixelList','ConvexHull','FilledImage','Solidity',...
        'ConvexImage','Image','SubarrayIdx','Eccentricity','MajorAxisLength',...
        'EquivDiameter','MinorAxisLength');
    [maxarea,index] = max([results.Area]);
    aspect_ratio = results(index).MajorAxisLength/results(index).MinorAxisLength;
    arr(k,1)=aspect_ratio;
    rectangularity =results(index).Area/aspect_ratio;
    arr(k,2)=rectangularity;
    convex_area_ratio=results(index).Area/results(index).ConvexArea;
    arr(k,3)=convex_area_ratio;
    eccentricity=results(index).Eccentricity;
    arr(k,4)=eccentricity;
    diameter=results(index).EquivDiameter;
    arr(k,5)=diameter;
    form_factor=(4*pi*results(index).Area)/(results(index).Perimeter).^2;
    arr(k,6)=form_factor;
    narrow_factor=diameter/results(index).MajorAxisLength;
    arr(k,7)=narrow_factor;
    perimeter_ratio_length_width=results(index).Perimeter/(results(index).MajorAxisLength+...
    results(index).MinorAxisLength);
    arr(k,8)=perimeter_ratio_length_width;
    Solidity=results(index).Solidity;
    arr(k,9)=Solidity;
    Circularity=results(index).Area/(results(index).Perimeter).^2;
    arr(k,10)=Circularity;
    if results(index).BoundingBox(3) > results(index).BoundingBox(4)
        encircle_radius=results(index).BoundingBox(3)/2;
    else
        encircle_radius=results(index).BoundingBox(4)/2;
    end
    [cir,incircle_radius]=incircle(results(index).ConvexHull(:,1),results(index).ConvexHull(:,2));
    Irregularity=encircle_radius/incircle_radius;
    arr(k,11)=Irregularity;
    
    % zernike moment n=order and m=repition
    [mom, amplitude, angle] = Zernikmoment(b,4,0);      % Call Zernikemoment fuction n=4, m=0
    arr(k,12)=mom;
    arr(k,13)=amplitude;
    clear mom amplitude angle
    [mom, amplitude, angle] = Zernikmoment(b,4,2);      % Call Zernikemoment fuction n=4, m=2
    arr(k,14)=mom;
    arr(k,15)=amplitude;
    clear mom amplitude angle
    [mom, amplitude, angle] = Zernikmoment(b,4,4);      % Call Zernikemoment fuction n=4, m=4
    arr(k,16)=mom;
    arr(k,17)=amplitude;
    clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,3,1);      % Call Zernikemoment fuction n=3, m=1
    arr(k,18)=mom;
    arr(k,19)=amplitude;
   clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,3,3);      % Call Zernikemoment fuction n=3, m=3
    arr(k,20)=mom;
    arr(k,21)=amplitude;
   clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,0,0);      % Call Zernikemoment fuction n=0, m=0
    arr(k,22)=mom;
    arr(k,23)=amplitude;
   clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,1,1);      % Call Zernikemoment fuction n=1, m=1
    arr(k,24)=mom;
    arr(k,25)=amplitude;
   clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,2,0);      % Call Zernikemoment fuction n=2, m=0
    arr(k,26)=mom;
    arr(k,27)=amplitude;
   clear mom amplitude angle
   [mom, amplitude, angle] = Zernikmoment(b,2,2);      % Call Zernikemoment fuction n=2, m=2
    arr(k,28)=mom;
    arr(k,29)=amplitude;
   clear mom amplitude angle
    b=double(b);
% Hu's 7 moment invariants(first 3)
    % Hu's 7 moment invariants(first 3)
   hu=feature_vec(b);
  arr(k,30)=hu(1,1);
  arr(k,31)=hu(2,1);
  arr(k,32)=hu(3,1);
  arr=double(arr);
  clearvars -except arr;
  %% edit these locations-----------------------------------------------
  xlswrite('.\predict_leaf\predict\testdata.xlsx',arr);
  testdata=xlsread('.\predict_leaf\predict\testdata.xlsx');
  normalize=xlsread('.\predict_leaf\predict\normalization_para.xlsx');
  %%----------------------------------------------------------------
  mini=normalize(1,:);
  maxi=normalize(2,:);
  [r2 c2]=size(testdata);
  for i=1:r2
      for j=1:c2
         testdata(i,j)=(testdata(i,j)-mini(1,j))/(maxi(1,j)-mini(1,j));
      end
  end
  [all_theta]=xlsread('.\predict_leaf\predict\theta.xlsx');
  pred = predictOneVsAll(all_theta,testdata);
end