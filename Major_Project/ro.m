% % Clear the existing workspace 
% clear all; 
%   
% % Clear the command window 
% clc; 
%   
% % Read the input image 
% input = imread('peppers.png'); 
%   
% % Convert image to greyscale 
% input=rgb2gray(input); 
%   
% % Resize the image to required size 
% input=imresize(input, [512 512]); 
%   
% % Message to be embedded 
% message='geeksforgeeks'; 
%   
% % Length of the message where each character is 8 bits 
% len = length(message) * 8; 
%   
% % Get all the ASCII values of the characters of the message 
% ascii_value = uint8(message); 
%   
% % Convert the decimal values to binary 
% bin_message = transpose(dec2bin(ascii_value, 8)); 
%   
% % Get all the binary digits in separate row 
% bin_message = bin_message(:); 
%   
% % Length of the binary message 
% N = length(bin_message); 
%   
% % Converting the char array to numeric array 
% bin_num_message=str2num(bin_message); 
%   
% % Initialize output as input 
% output = input; 
%   
% % Get height and width for traversing through the image 
% height = size(input, 1); 
% width = size(input, 2); 
%   
% % Counter for number of embedded bits 
% embed_counter = 1; 
%   
% % Traverse through the image 
% for i = 1 : height 
%     for j = 1 : width 
%           
%         % If more bits are remaining to embed 
%         if(embed_counter <= len) 
%               
%             % Finding the Least Significant Bit of the current pixel 
%             LSB = mod(double(input(i, j)), 2); 
%               
%             % Find whether the bit is same or needs to change 
%             temp = double(xor(LSB, bin_num_message(embed_counter))); 
%               
%             % Updating the output to input + temp 
%             output(i, j) = input(i, j)+temp; 
%               
%             % Increment the embed counter 
%             embed_counter = embed_counter+1; 
%         end
%           
%     end
% end
%   
% % Write both the input and output images to local storage 
% % Mention the path to a folder here. 
% imwrite(input, 'path_to_folder\originalImage.png'); 
% imwrite(output, 'path_to_folder\stegoImage.png'); 
close all;
clear all;
clc;
%input Image
[file path]=uigetfile(['cover/','*.TIF']);
img1=imread([path file]);
figure,
imshow(img1);
title('cover Image');

% Substitution Bits Indexing
load SubBits
 f = figure;
ui = uitable(f,'Data',SubBits,'Position',[20 20 800 300] );
%text read in notpad
[file path]=uigetfile(['text content/','*.txt']);
fileID = fopen([path file],'r');% read the file so 'r'
fread = fscanf(fileID,'%s');
frd=double(fread); %double value of fread
%image resize
img2 = imresize(img1, [256 256]);
size(img2)
figure,
imshow(img2);

for ii=1:3
    a  = size(img2, 1);
    b  = size(img2, 2);
    numParts = 16;
    c = floor(a/numParts);
    d = rem(a, numParts);
    
    partition_a = ones(1, numParts)*c;
    e = floor(b/numParts);
    f = rem(b, numParts);
    partition_b = ones(1, numParts)*e;
    
    out = mat2cell(img2(:,:,ii), partition_a, partition_b);
    output{ii}=out;
end
len = length(fread); %to calculate the read text file
val=[1:256:len];
for ii = 1:length(val)
    if ii~=length(val)
        empty_variable{ii}=frd(val(ii):val(ii)+255);
    else
        empty_variable{ii}=frd(val(ii):end);
    end
end


  a  = size(img2, 1);
    b  = size(img2, 2);
for ii = 1: a
      for jj = 1 : b
          watermark (ii,jj) = bitget(img1(ii,jj),1);
      end
  end    
figure(2)
imshow(watermark);  
title('extracted image');     % watermark image for watermarking




X = image;
S = secret message;

X2(:)=bitset(X(:),1,S(:));





