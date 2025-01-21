clc;
clear;
close all;

I = imread("test.jpg");
Ig = rgb2gray(I);
Ieq = histeq(Ig);

subplot(1,3,1);
imshow(I);
title("Original Image");

subplot(1,3,2);
imshow(Ig);
title("Grayscale Image");

subplot(1,3,3);
imshow(Ieq);
title("Equalized Image");