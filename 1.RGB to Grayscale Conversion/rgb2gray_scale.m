clear;
close all;
clc;

I = imread('test.jpg');

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
Ig=((R+G+B)/3);

count = sum(Ig(:));

threshold=count/(3840*2160);
Ib = Ig > threshold;

Iblue=I;
Iblue(:,:,1)=0;
Iblue(:,:,2)=0;

Igreen=I;
Igreen(:,:,1)=0;
Igreen(:,:,3)=0;

Ired=I;
Ired(:,:,2)=0;
Ired(:,:,3)=0;

subplot(2,3,1);
imshow(I);
title("Original Image");

subplot(2,3,2);
imshow(Ig);
title("Grayscale Image");

subplot(2,3,3);
imshow(Ib);
title("B&W Image");

subplot(2,3,4);
imshow(Ired);
title("Red Image");

subplot(2,3,5);
imshow(Igreen);
title("Green Image");

subplot(2,3,6);
imshow(Iblue);
title("Blue Image");