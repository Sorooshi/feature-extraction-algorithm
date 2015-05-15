% Soroosh Shalileh
% implementations for Event detection Report
% PCA algorithm Ref No. is[9]

clear all; close all; clc;
% Reading an images:
X =  imread('D:\testing\image\lena_gray.jpg');

% Converting to gray level:
Xgray = rgb2gray(X);

% Maybe a pre processing will be needed:



%% Calculating the Covariance matrix or sigma:
m = 255; % traning data set size
sigma = (1/m) * im2double(Xgray)' * im2double(Xgray);
% sigma = (1/m) * im2double(X)' * im2double(Xgray);


% Calculating the Eigen Vector of Sigma: (No math was studied)
[U,S,V] = svd(im2double(Xgray));
% [U,S,V] = svd(im2double(X));

% Reducing the U diemension to k dimension:
k = 255; % what is the basics to find the optimum value for k
Ureduce = U(:,1:k);

% Calculating the out put (Z):
Z = Ureduce' * im2double(Xgray);
% Z = Ureduce' * im2double(X);

% % Z = Ureduce' .* Xgray;

% Showing the results :
%  figure; imshow(Xgray);
figure; imshow(X);
figure; imshow(Z);
%  figure; imshow(double2im(Z));




