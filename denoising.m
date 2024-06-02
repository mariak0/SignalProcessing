clc; close all; clear all;
%%
%h(n) as a vector
h = [1,-1];
%number of samples
freqz(h, 1, 1000);
n=0:1000;
x=cos(pi/32*n);
%filter
y=filter(h, 1, x);
figure (2);
plot(x(1:100))
figure (3);
plot(y(1:100))
%
img = imread('photo.jpg');
figure(4);
imagesc(img);colormap gray
dy=filter([1,-1], 1, img);
figure(5);
imagesc(dy);colormap gray
dx=filter([1,-1], 1, img')';
figure(6)
imagesc(dx);colormap gray
figure(7)
dy2=filter([1,-1], 1, dy);
imagesc(dy2);colormap gray
figure(8)
dx2=filter([1,-1], 1, dx')';
imagesc(dx2);colormap gray
figure(9)
dydx=filter([1,-1], 1, dy')';
imagesc(dydx);colormap gray
figure(10)
dxdy=filter([1,-1], 1, dx);
imagesc(dxdy);colormap gray
%% filter2
img = imread('photo.jpg');
N = 20;
h = ones(2*N+1,2*N+1) / (2*N+1)^2;
y = filter2(h,img);
figure(11)
imshow(y/max(y(:)));
%% photo-deg.jpg
N = 20;
img2 = imread('photo-deg.jpg');
y = filter2(h, img2);
figure(12);
imshow(y/max(y(:)));
%% medfilt2
N = 6;
img2 = imread('photo-deg.jpg');
y = medfilt2(img2, [12, 12]);
figure(13);
imshow(y);


clc; close all; clear all;
v = VideoReader('500fps.avi');
i= 0;
while hasFrame(v)
i=i+1;
I = rgb2gray(im2double(readFrame(v)));
x(i) = I(293,323);
end
y = x-mean(x);
Y = abs(fftshift(fft(y,512)));
F = linspace (-250,250,512);
subplot(2,1,1)
plot(F,Y);
title('DFT before denoising');
h = fspecial('gaussian', [5 5], 2);
y_filtered = filter2(h, y);
Y_filtered = abs(fftshift(fft(y_filtered, 512)));
subplot(2,1,2)
plot(F, Y_filtered);
title('DFT after denoising');
