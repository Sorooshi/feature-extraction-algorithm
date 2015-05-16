% Soroosh Shalileh
% implementations for Event detection Report -- Final version
% PCA algorithm Ref No. is[9]

clear all; %close all; clc;

% org_img_in = imread('D:\testing\image\cameraman.jpg');
org_img_in = imread('D:\testing\image\lena_gray.jpg');
gry_img_in = rgb2gray((im2double(org_img_in)));
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
% figure; imshow(reshape(normalize_img , nRow , nCol));title('Normilzed Image');
reshaped_normalize_img = (reshape(normalize_img , nRow , nCol));

%% PCA algorithm Implementation
m = nCol;
sigma = (1/m)*(reshaped_normalize_img' * reshaped_normalize_img);
[U S V] = svd(sigma);

%% Visualization of svd algorithm results
% % figure;
% % subplot(4,1,1);imshow(sigma);title('Showing sigma');
% % subplot(4,1,2);imshow(U);title('Showing U');
% % subplot(4,1,3);imshow(V);title('Showing V');
% % subplot(4,1,4);imshow(S);title('Showing S');

%% PCA Evalution and selecting the k component
k = 0;
thr = 0;
while thr <= 0.99
k = k+1;
thr = (sum(diag(S(1:k,1:k))) / sum(diag(S)));
end

    
U_reduced = U(:,1:k);
% Achaving the Weight Matrix :
z =  U_reduced' * reshaped_normalize_img ;

%% Reconstructing the image :
% img_reconstruct = z* U_reduced' ;
img_reconstruct = U_reduced * z;
figure;imshow(img_reconstruct);title('PCA Output');

% ************ Final Code for PCA On Image ************