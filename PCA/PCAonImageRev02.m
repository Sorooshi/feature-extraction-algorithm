% Soroosh Shalileh
% implementations for Event detection Report
% PCA algorithm Ref No. is[9]

% clear all; close all; clc;

org_img_in = imread('D:\testing\image\lena_gray.jpg');
% org_img_in = imread('D:\testing\image\cameraman.tif');

gry_img_in = (im2double(org_img_in));%rgb2gray
% figure; imshow(gry_img_in); title('Original Gray Level Image');
% Determing the image size
[nRow nCol spare1] = size(gry_img_in);

%**************************************************************************
% Normalization process
norm_gry_img_in = gry_img_in;
norm_gry_img_out = featureNormalize(norm_gry_img_in);
figure;imshow(norm_gry_img_out);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For cuase shown by comparing the visual results in "PCAonimageRev01" 
% we can prove by visualization the our implementation is more effective 
% than the thos mentioned in last part of m.file "PCAonimageRev01".
% our approach results are more similar to the original images ang maintain
% less false countors and false edges. thus our approach is more efficient.
% *** Make "PCAonimageRev03"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
