% CNMF Project 

clc;clear all; close all;
Xrgb = imread('D:\testing\image\lena_gray.jpg');
X = rgb2gray(Xrgb);
X = im2double(X);
figure
imshow(Xrgb) , title ('original image')  ; 
figure
imshow(X);
[m,n] = size(X);
disp('the values for m and n in order are =');
m 
n
% constructing C 

k = input(' Enter a value for k,the value must be smaller than m and n, for comprehension=');
NumC = input ('Enter a value for NumC as number of classes=');             % Number of classes
lLowValue = zeros(NumC);                                                   % A zero matrix for saving the low limit of each class
lHighValue = zeros(NumC);                                                  % A zero matrix for saving the High limit of each class
%-----------------------------------------------------------------------------------------------------------------------------------------

%L = zeros(256);
for NoC = 1 : NumC
    lLowValue(NoC) = input ('Enter a value for Low Limit, as first number of class Number "c" ');
    lHighValue(NoC) = input ('Enter a value for High Limit, as last number of class Number "c" ');
    disp ('lLowValue in order as you input =');
    lLowValue(NoC)
    disp ('lHighValue in order as you input =');
    lHighValue(NoC)
    l = lHighValue(NumC);
    C = zeros(l,NumC);
end

for i = 1 : NumC
    for j =lLowValue(i) : lHighValue(i)
        C(j,i) = 1;
    end
end

%------------------------------------------------------------------------------------------------------------------------------------------------

% constructing A 
A = zeros(n,n);

for i = 1 : l
    for j =1 : NumC
        A(i,j) = C(i,j);
    end
end
 for i=l+1 : n 
     A(i,i) = 1;
 end
 
%Update Rule :
U0 = rand(m,k);
Z0 = rand(n,k);

maxiter = 100;  %according to an article
thr = 0.6;      %according to an article

for i =1 : maxiter
%     U = U0 .* ((X*A*Z0)./ ((U0*(Z0')*(A')*A*Z0)));
%     U = U.*(U>0);
%     Z = Z0 .* (((A')*(X')* U) ./ ((A')* A * Z0 *(U')*U));
%     Z = Z.*(Z>0);
    Z = Z0 .* (((A')*(X')* U0) ./ ((A')* A * Z0 *(U0')* U0));
    Z = Z.*(Z>0);
    U = U0 .* ((X*A*Z)./ ((U0*(Z')*(A')*A*Z)));
    U = U.*(U>0);
    Z0 = Z;
    U0 = U;
    if norm(X-U*((A*Z)')) < thr 
        break
    end
end


Xnew = U0 * (A*Z0)';
imwrite(Xnew,'d:\testing\image\Test.jpg');
figure
imshow(Xnew) ,  title ('CNFM image');
%figure
%imshow(U0);

%figure
%imshow((A*Z0)');
figure 
imhist(X), title (' Histogram original image') ;
hold on 
figure 
imhist(Xnew), title ('Histogram CNFM image') ; 