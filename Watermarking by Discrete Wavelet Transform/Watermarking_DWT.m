%% Created by SOHAM ROY

%% Watermarking with DWT
clc;
clear;
close all;

%% Read the original image
img = imread('lena_color.tiff');

%% Convert to grayscale if it's a color image
if size(img,3) == 3
    img = rgb2gray(img);
end

%% Initialize an empty watermark image of the same size as the original
watermark = zeros(size(img));

%% Display the empty watermark image and overlay text onto it
figure;
imshow(watermark, []);
hold on;
text(size(img,2)/2, size(img,1)/2, 'SOHAM', 'FontSize', 50, 'Color', 'white', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

%% Capture the frame containing the text
frame = getframe(gca);
watermark = frame2im(frame);

%% Convert to grayscale (if needed) and resize to match half the original image size
watermark = rgb2gray(watermark);
watermark = imresize(watermark, size(img) / 2);
close;

%% Apply Discrete Wavelet Transform (DWT) using Haar wavelet to get subbands
[LL, LH, HL, HH] = dwt2(double(img), 'haar');

%% Define watermark strength
alpha = 0.6;

%% Embed watermark into the HH (high-frequency) subband
HH_watermarked = HH + alpha * double(watermark);

%% Perform inverse DWT to reconstruct the watermarked image
img_watermarked = idwt2(LL, LH, HL, HH_watermarked, 'haar');
img_watermarked = uint8(img_watermarked);

%% Save and display the watermarked image
imwrite(img_watermarked, 'text_watermarked_image.png');
figure;
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img_watermarked); title('Watermarked Image');
subplot(1,3,3); imshow(watermark, []); title('Text Watermark');

%% -------------------- Watermark Removal Process --------------------

%% Apply DWT to the watermarked image to extract subbands
[LL2, LH2, HL2, HH2] = dwt2(double(img_watermarked), 'haar');

%% Remove watermark from HH subband
HH2_cleaned = HH2 - alpha * double(watermark);

%% Perform inverse DWT to reconstruct the cleaned image (without watermark)
img_cleaned = idwt2(LL2, LH2, HL2, HH2_cleaned, 'haar');
img_cleaned = uint8(img_cleaned);

%% Save and display the watermark-removed image
imwrite(img_cleaned, 'text_watermark_removed.png');
figure;
subplot(1,3,1); imshow(img_watermarked); title('Watermarked Image');
subplot(1,3,2); imshow(HH2_cleaned, []); title('HH after Removal');
subplot(1,3,3); imshow(img_cleaned); title('Watermark Removed');