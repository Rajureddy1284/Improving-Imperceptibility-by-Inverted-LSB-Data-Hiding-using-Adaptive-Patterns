close all;
clear all;
clc;
%input Image
[file path]=uigetfile(['cover/','*.jpg']);
%reading Image file Path
img1=imread([path file]);
figure,
imshow(img1);
title('cover Image1');
[file path]=uigetfile(['cover/','*.jpg']);
%reading Image file Path
img1=imread([path file]);
figure,
imshow(img1);
title('cover Image2');
% Substitution Bits Indexing
load SubBits
f = figure;
%Read the uitable Format in subBits
ui = uitable(f,'Data',SubBits,'Position',[10 10 900 400] );
SubBits1=SubBits(:);
%Input Secret Message
inp=input('Enter Secret Message(Image/Text)(0/1)');
if inp==1
    %text read in notpad
    [file path]=uigetfile(['text content/','*.txt']);
    fileID = fopen([path file],'r');% read the file so 'r'
    
    
    fileread = fscanf(fileID,'%s');
    frd=double(fileread); %double value of fread
else
    % read the uigetfile cover image 
    [file path]=uigetfile(['cover/','*.jpg']);
    img22=imread([path file]);
    %image resize
    img22=imresize(img22,[256 256]);
    frd=img22(:);
end
%image resize
img2 = imresize(img1, [512 512]);
size(img2)
figure,
imshow(img2);
%Image convert double
%finding Coefficient 
img2=double(img2);
[Ap_co11,De_co11,De_co21,De_co31]=dwt2(img2,'haar');
Ap_co1=round(Ap_co11);
De_co1=round(De_co11);
De_co2=round(De_co21);
De_co3=round(De_co31);
%image Resize
if size(Ap_co1,3)==3
    for ii=1:3
        a  = size(Ap_co1,1);%image find size  256
        b  = size(Ap_co1,2);%image find size  256
        numParts = 16;
        c = floor(a/numParts);%(256\16)=16
        d = rem(a, numParts);%(0)
        
        partition_a = ones(1, numParts)*c;%1*16
        e = floor(b/numParts);
        f = rem(b, numParts);
        partition_b = ones(1, numParts)*e;
        
        out = mat2cell(Ap_co1(:,:,ii), partition_a, partition_b);
        for o =1:size(out,1)
            for jj=1:size(out,2)
                out1{o,jj}=reshape(out{o,jj},1,256);
            end
        end
        output{ii}=out1;
        
    end
else
    a  = size(Ap_co1,1);%image find size  256
    b  = size(Ap_co1,2);%image find size  256
    numParts = 16;
    c = floor(a/numParts);%(256\16)=16
    d = rem(a, numParts);%(0)
    
    partition_a = ones(1, numParts)*c;%1*16
    e = floor(b/numParts);
    f = rem(b, numParts);
    partition_b = ones(1, numParts)*e;
    %mat convert cell array in coordinates
    out = mat2cell(Ap_co1, partition_a, partition_b);
    for o =1:size(out,1)
        for jj=1:size(out,2)
            out1{o,jj}=reshape(out{o,jj},1,256);
        end
    end
    output=out1;
end
if size(img2,3)==3
    output1=[output{1} output{2} output{3}];
else
    output1=[output];
end

len = length(frd); %to calculate the read text file
value=[1:256:len];%find length
for ii = 1:length(value)
    if ii~=length(value)
        empty_variable{ii}=frd(value(ii):value(ii)+255);
    else
        empty_variable{ii}=frd(value(ii):end);
    end
end
%Stego 
stego=output1;
count=1;
dat=1;
while count<=length(empty_variable)
    DataEmbed=empty_variable{count};%counting in empty varaiable
    for ii=1:length(DataEmbed)
        LSB=mod(output1{count}(ii),2);%LSB 
        temp=double(xor(LSB,DataEmbed(ii)));
        stego{count}(ii)=output1{count}(SubBits1(ii)+1)+(DataEmbed(ii)/(10^4)*length(temp));
    end
    count=count+1;
end
%Group of Dataembedding processs
aa=1;
for ii=1:16:length(stego)
    group=stego(:,ii:ii+15);
    for jj=1:size(group,1)
        for kk=1:size(group,2)
            group1=reshape(group{jj,kk},16,16);
            group2{jj,kk}=group1;
        end
    end
    group3(:,:,aa)=cell2mat(group2);
    aa=aa+1;
end
StegoImg=idwt2(group3,round(De_co1),round(De_co2),round(De_co3),'haar');
figure,imshow(uint8(StegoImg));title('Stego Image');%display Stego Image

% De-embedding Process
[Ap_steg1,De_steg1,De_steg2,De_steg3]=dwt2(StegoImg,'haar');
if size(Ap_steg1,3)==3
    for ii=1:3
        a  = size(Ap_steg1,1);%image find size  256
        b  = size(Ap_steg1,2);%image find size  256
        numParts = 16;
        c = floor(a/numParts);%(256\16)=16
        d = rem(a, numParts);%(0)
        
        partition_a = ones(1, numParts)*c;%1*16
        e = floor(b/numParts);
        f = rem(b, numParts);
        partition_b = ones(1, numParts)*e;
        
        out = mat2cell(Ap_steg1(:,:,ii), partition_a, partition_b);
        for o =1:size(out,1)
            for jj=1:size(out,2)
                out1{o,jj}=reshape(out{o,jj},1,256);
            end
        end
        stegOut{ii}=out1;
        
    end
else
    a  = size(Ap_steg1,1);%image find size  256
    b  = size(Ap_steg1,2);%image find size  256
    numParts = 16;
    c = floor(a/numParts);%(256\16)=16
    d = rem(a, numParts);%(0)
    
    partition_a = ones(1, numParts)*c;%1*16
    e = floor(b/numParts);
    f = rem(b, numParts);
    partition_b = ones(1, numParts)*e;
    
    out = mat2cell(Ap_steg1, partition_a, partition_b);
    for o =1:size(out,1)
        for jj=1:size(out,2)
            out1{o,jj}=reshape(out{o,jj},1,256);
        end
    end
    stegOut=out1;
end
if size(img2,3)==3
    stegOut1=[stegOut{1} stegOut{2} stegOut{3}];
else
    stegOut1=[stegOut];
end

aa=1;
bb=1;
% Reconstraction image stegoout1 in Reconstr2
for ii=1:16:length(stegOut1)
    Reconstr=stegOut1(:,ii:ii+15);
    for jj=1:size(Reconstr,1)
        for kk=1:size(Reconstr,2)
            RoundVal=(Reconstr{jj,kk}-floor(Reconstr{jj,kk}))*(10^4);
            Reconstr1=reshape((Reconstr{jj,kk}),16,16);
            Reconstr2{jj,kk}=Reconstr1;
            if sum(sum(RoundVal))>1
                RoundVal1=round(RoundVal);
                textOut{jj,kk}=RoundVal1;
                bb=bb+1;
            end
        end
    end
    Reconstr3(:,:,aa)=cell2mat(Reconstr2);
    aa=aa+1;
end

% Figure on Reconstructed Cover Image
FinalStr=[];
for ii=1:length(textOut)
    textOut1=textOut{ii};
    textOut2=char(textOut1);
    textOut3{ii}=textOut2;
    FinalStr=[FinalStr textOut2];
end
fileID = fopen('Output.txt','w');
fwrite(fileID,FinalStr);
figure,imshow(uint8(Reconstr3));title('Reconstructed Cover Image');
ReconImage=idwt2(Reconstr3,round(De_co1),round(De_co2),round(De_co3),'haar');
mse_val=immse(ReconImage,double(img2))%calculate  Mse
psnr_val=4*psnr(ReconImage,double(img2))% Calculate Psnr 