% Soroosh Shalileh
% Comparehension between different PCA implementations for Event detection Report
% PCA algorithm Ref No. is[9]
clear all; close all; clc;
Video1 = VideoReader('D:\testing\vids\ira_jump.avi');
get(Video1);

nFrames = Video1.NumberOfFrames;
vidHeight = Video1.Height;
vidWidth = Video1.Width;

% Preallocate the movie structure
mov(1:nFrames) = ...
    struct('cdata',zeros(vidHeight,vidWidth, 3,'uint8'),...
    'colormap',[]);
% Read one frame at a time
for f=1:nFrames
    mov(f).cdata = read(Video1,f);
end
% Size a figure based on the video's width and height
hf = figure;
set(hf, 'position', [150 150 vidWidth vidHeight])
% Play back the movie once at the video's frame rate
movie(hf, mov, 1, Video1.FrameRate);

%% Frame slicing and My Code for PCA
% SingleFrame(:,:,:,:) = zeros(vidHeight,vidWidth,,nFrames);
SingleGrayFrame(:,:,:) = zeros(vidHeight,vidWidth,nFrames);
% vectorize_gry_frame(:,:,:) = zeros(vidHeight,vidWidth,nFrames);
% U(:,:,:,:) = zeros(vidHeight,vidWidth,nFrames);
% S(:,:,:,:) = zeros(vidHeight,vidWidth,nFrames);
% V(:,:,:,:) = zeros(vidHeight,vidWidth,nFrames);
% sigma(:,:,:) = zeros(vidHeight,vidWidth,nFrames);
norm_gry_frame_in(:,:,:) = zeros(vidHeight,vidWidth,nFrames);

for i=1:nFrames
    SingleFrame(:,:,:,i) = read(Video1,i);
    SingleGrayFrame(:,:,i) = im2double(rgb2gray(SingleFrame(:,:,:,i)));
    % Vectorize the image
    [nRow, nCol, nFrame] = size(SingleGrayFrame(:,:,i));
    vectorize_gry_frame(:,:,i) = reshape(SingleGrayFrame(:,:,i), 1,(nRow*nCol));
    
    % PreProccessing Operation
    mu(i) = mean(vectorize_gry_frame(:,:,i));
    Scaled_img(:,:,i) = bsxfun(@minus, vectorize_gry_frame(:,:,i), mu(i));
    sigma4Normalization(i) = std(Scaled_img(:,:,i));
    normalize_img(:,:,i) = bsxfun(@rdivide,Scaled_img(:,:,i),sigma4Normalization(i));
    % Testing and showing the result of preproccessing operation
    reshaped_normalize_frame(:,:,i) = (reshape(normalize_img(:,:,i), nRow , nCol));
    % figure;imshow(reshaped_normalize_frame);
    
    % PCA algorithm Implementation
    m(i) = nCol;
    % sigma(:,:,i) = (1/m)*(reshaped_normalize_frame(:,:,i)' * reshaped_normalize_frame(:,:,i));
    sigma(:,:,i) = cov(reshaped_normalize_frame(:,:,i));
    [U(:,:,i) S(:,:,i) V(:,:,i)] = svd(sigma(:,:,i));
    
    % Visualization of svd algorithm results
    % % figure;
    % % subplot(4,1,1);imshow(sigma);title('Showing sigma');
    % % subplot(4,1,2);imshow(U);title('Showing U');
    % % subplot(4,1,3);imshow(V);title('Showing V');
    % % subplot(4,1,4);imshow(S);title('Showing S');
end
% PCA Evalution and selecting the k component
for j=1 : nFrames
    k = nCol*0.8;
    U_reduced(:,:,j) = U(:,1:k,j);
    z(:,:,j) = reshaped_normalize_frame(:,:,j) * U_reduced(:,:,j);
    % Reconstructing the image :
    frame_reconstruct (:,:,j) = z(:,:,j) * U_reduced(:,:,j)';
end
% Visualization the output of this section
% for l=1:nFrames
% figure;imshow(frame_reconstruct(:,:,l));title('MyPCA Output');
% end
% ************************************************************************

%% PCA ALgorilthm Using Matlab toolbox

for k=1: nFrames
    SingleGrayFrame(:,:,k) = im2double(rgb2gray(SingleFrame(:,:,:,i)));
    [U_matlab(:,:,k) S_matlab(:,:,k) V_matlab] = pca(SingleGrayFrame(:,:,i));
end
% Reconstructing the Original signal (???? ????? ??????? ??? ??? ?? ?? ????
% ?? ?? ?? ????? U,S,V ????? ???? ? ??? ???? ?? ????? ???? ?? ????? ?? ????
% ????? ???? ?????? ???.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for k=1: nFrames
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % U_Mat_reconstruct_frame = U_matlab(:,:,k) * SingleGrayFrame(:,:,k);
%%