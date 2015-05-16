% Soroosh Shalileh -- Final version
% implementations for Event detection Report -- "MyApporachFor Normalization" version
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
% % hf = figure;
% % set(hf, 'position', [150 150 vidWidth vidHeight])
% %
% % % Play back the movie once at the video's frame rate
% % movie(hf, mov, 1, Video1.FrameRate);

%% Dividing the input video into a single frame :
% Thus we can use each frame as a single input image to apple PCA algorithm

% Frame slicing :
for i=1:nFrames
    SingleFrame(:,:,:,i) = read(Video1,i);
    SingleGrayFrame(:,:,i) = im2double(rgb2gray(SingleFrame(:,:,:,i)));
    % Vectorize the image
    [nRow, nCol, nFrame] = size(SingleGrayFrame(:,:,i));
    vectorize_gry_frame(:,:,i) = reshape(SingleGrayFrame(:,:,i),[1 nRow*nCol]);
    
    %% PreProccessing Operation
    mu(i) = mean(vectorize_gry_frame(:,:,i));
    Scaled_img(:,:,i) = bsxfun(@minus, vectorize_gry_frame(:,:,i), mu(i));
    sigma4Normalization(i) = std(Scaled_img(:,:,i));
    normalize_img(:,:,i) = bsxfun(@rdivide,Scaled_img(:,:,i),sigma4Normalization(i));
    % Testing and showing the result of preproccessing operation
    reshaped_normalize_frame(:,:,i) = (reshape(normalize_img(:,:,i), nRow , nCol));
    % figure;imshow(reshaped_normalize_frame);
    
    %% PCA algorithm Implementation
    m(i) = nCol;
    % sigma(:,:,i) = (1/m)*(reshaped_normalize_frame(:,:,i)' * reshaped_normalize_frame(:,:,i));
    sigma(:,:,i) = cov(reshaped_normalize_frame(:,:,i));
    [U(:,:,i) S(:,:,i) V(:,:,i)] = svd(sigma(:,:,i));
    
    %% Visualization of svd algorithm results
    % % figure;
    % % subplot(4,1,1);imshow(sigma);title('Showing sigma');
    % % subplot(4,1,2);imshow(U);title('Showing U');
    % % subplot(4,1,3);imshow(V);title('Showing V');
    % % subplot(4,1,4);imshow(S);title('Showing S');
end
%% PCA Evalution and selecting the k component
for l=1 : nFrames
k = 110;
U_reduced(:,:,l) = U(:,1:k,l);
z(:,:,l) = reshaped_normalize_frame(:,:,l) * U_reduced(:,:,l);
% Reconstructing the image :
frame_reconstruct (:,:,l) = z(:,:,l) * U_reduced(:,:,l)';
end
% for j=1:nFrames
%     k(j) = 0;
%     thr(j) = 0;
%     while thr(j) <= 0.99
%         k(j) = k(j)+1;
% %         thr(:,:,j)= sum(bsxfun(@rdivide,diag((S(1:k,1:k,1:k))),diag((S(:,:,j)))));
%         % thr(j) = sum(mtimesx(S(:,:,i),(S)));
%     end
%  
%     U_reduced(:,:,j) = U(:,:,1:k(j));
%     % Achaving the Weight Matrix :
%     z(:,:,j) = reshaped_normalize_frame(:,:,j) * U_reduced(:,:,j) ;
%     
%     %% Reconstructing the image :
%     % img_reconstruct = z* U_reduced' ;
%     frame_reconstruct(:,:,j) = z(:,:,j) * U_reduced(:,:,j)' ;
% %     figure;imshow(frame_reconstruct(:,:,j));title('PCA Output');
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this version we run the pca algorithm  without running the
% Evalution part, and we choose the "k" value manually. Two main
% results have been achieved, first of all very bad quality for the out put
% frame have been achieved. This low contrast of the frame maybe is the
% rusults of preprocessing operation. So we will test the algorithm with
% different methods of Normalization (PreProcessing) and without this part
% in next version ("PCAonVideoEventDetection_Rev03").
% Another result of this progress is : implementing the Evalution part for
% PCA algorithm using in video is really hard and expensice by the cost of
% calculations. In the laters version we will test the different methods
% of implementations of this algorihm.


