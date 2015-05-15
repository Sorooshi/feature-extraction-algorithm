% Soroosh Shalileh
% implementations for Event detection Report
% PCA algorithm Ref No. is[9]

% clear all; close all; clc;

% org_img_in = imread('D:\testing\image\lena_gray.jpg');
org_img_in = imread('D:\testing\image\cameraman.tif');
gry_img_in = (im2double(org_img_in)); %rgb2gray
% figure; imshow(gry_img_in); title('Original Gray Level Image');

% Vectorize the image
[nRow nCol spare1] = size(gry_img_in);
vectorize_gry_img = reshape(gry_img_in,[1 nRow*nCol]);

%% PreProccessing Operation
mu = mean(vectorize_gry_img);
Scaled_img = bsxfun(@minus, vectorize_gry_img, mu);
sigma4Normalization = std(Scaled_img);
normalize_img = bsxfun(@rdivide,Scaled_img,sigma4Normalization);
% Testing and showing the result of preproccessing operation
figure; imshow(reshape(normalize_img , nRow , nCol));title('Normilzed Image');
reshaped_normalize_img = (reshape(normalize_img , nRow , nCol));

%% PCA algorithm Implementation 
m = nCol;
sigma = (1/m)*(reshaped_normalize_img' * reshaped_normalize_img);


% this implementation is corrupted, becuase memory limitations. Thus I
% Understand this is not efficient way to do the pre-proccessing
% operations. by the way I download a function from the link the below and
% use it to implement the pre-proccessig operations in another version of
% my code named "PCAonImageRev02"
% The link address for feature scaling and preproccessing operation :
% http://www.mathworks.com/matlabcentral/fileexchange/42203-pca/content//pca/featureNormalize.m

