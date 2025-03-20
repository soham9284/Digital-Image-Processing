%Created By Soham Roy
%Edge Detection Without Using Standard Functions

clc; 
clear; 
close all;

% Read the input image
img = imread('lena_color.tiff');  % Replace with your image file
gray_img = rgb2gray(img);   % Convert to grayscale

% Define Sobel filters manually
Gx = [-1 0 1; -2 0 2; -1 0 1];  % Sobel operator for X direction
Gy = [-1 -2 -1; 0 0 0; 1 2 1];  % Sobel operator for Y direction

% Perform convolution manually
Ix = conv2(double(gray_img), Gx, 'same');  % Convolve with Gx
Iy = conv2(double(gray_img), Gy, 'same');  % Convolve with Gy

% Compute Gradient Magnitude
Gradient_Mag = sqrt(Ix.^2 + Iy.^2);  % Magnitude of the gradient

% Normalize the result (0-255)
Gradient_Mag = uint8(255 * (Gradient_Mag / max(Gradient_Mag(:))));

% Apply thresholding for edge detection
threshold = 50;  % You can adjust this value
Edge_Image = Gradient_Mag > threshold;

% Display Results
subplot(1,3,1), imshow(gray_img), title('Grayscale Image');
subplot(1,3,2), imshow(Gradient_Mag), title('Gradient Magnitude');
subplot(1,3,3), imshow(Edge_Image), title('Edge Detected Image');