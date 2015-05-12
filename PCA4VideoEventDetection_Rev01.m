% This Code is created by Soroosh Shalileh to implemet the PCA algorithm
% for Event Detection in Videos.
% PCA algorithm Ref No. is[9]

clear all; close all; clear memory; clc;

%% Read and play back the movie file
% Reading the input video
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
for k = 1 : nFrames
    mov(k).cdata = read(Video1,k);
end

% Size a figure based on the video's width and height
hf = figure;
set(hf, 'position', [250 250 vidWidth vidHeight])

% Play back the movie once at the video's frame rate
movie(hf, mov, 1, Video1.FrameRate);

%% Dividing the input video into a single frame
% Thus we can use each frame as a single input image to apple PCA algorithm

for i = 1 : nFrames
    SingleFrame(:,:,:,i) = read(Video1,i);
    SingleGrayFrame(:,:,i) = im2double(rgb2gray(SingleFrame(:,:,:,i)));
    AverageSingleGrayFrame(:,i) = mean(SingleGrayFrame(:,:,i));
%     for j = 1 vidWidth
%     SingleGrayFrameScaled(:,i) = SingleGrayFrame(:,j);
end


