clear all
close all

f = imread('capture.jpg');
f = rgb2gray(f);
f = im2double(f);

h = fspecial('gaussian',15,2);
Blurred = imfilter(f,h,'circular');
noise = 0.001*rand(size(f));
g = Blurred + noise;
figure,imshow(g, []);

G = fftshift(fft2(g));
figure,imshow(log(abs(G)),[]);

h = ifftshift(fspecial('gaussian',size(f),2));
figure,imshow(h,[]);

H = fftshift(fft2(h));
figure,imshow(log(abs(H)),[]);

F =zeros(size(f));
R = 70;
for u=1:size(f,2)
    for v=1:size(f,1)
        du = u-size(f,2)/2;
        dv = v-size(f,1)/2;
        if du^2 + dv^2 <= R^2
            F(v,u) = G(v,u)/H(v,u);
        end
    end
end
figure, imshow(log(abs((F))),[]);
fRestore = real(ifft2(ifftshift(F)));
figure,imshow(fRestore,[]);