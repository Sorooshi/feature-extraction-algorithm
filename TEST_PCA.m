% close all; clc; clear;
fprintf('Loading Dataset ....\n')

% load ('face.mat');
X = imread('D:\testing\image\lena_gray.jpg');
x = rgb2gray(X);
x = im2double(x);
% % % mu = [2 3];
% % % SIGMA = [1 1.5; 1.5 3];
% % % rng('default');  % For reproducibility
% % % x = mvnrnd(mu,SIGMA,100);
fprintf('Orignal dimensions/features in dataset for each example\n')

size(x,2)
fprintf('implementing PCA ..\n')

[x_norm, mu, sigma] = featureNormalize(x);

[U,S,X_reduce]= pca(x_norm,size(x,2));
fprintf('Now the no. of dimesions/features in each instance of dataset is:\n')
size(X_reduce,2)

figure;imshow(x);
figure;imshow(X_reduce)
% % % figure;
% % % plot(x(:,1),x(:,2),'+');
% % % hold on
% % % plot(X_reduce(:,1),X_reduce(:,2),'+','color','r');