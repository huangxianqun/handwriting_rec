clear;clc;close all;
load('data/train.mat');
for num=1:size(train.inputs,2)
    % 读取输入输出向量
    image_vector=train.inputs(:,num);
    image_sign=train.targets(:,num);
    % 将向量转换成16x16矩阵（图片）
    image=zeros(16,16);
    for i=1:16
        for j=1:16
            image(i,j)=image_vector((i-1)*16+j,1);
        end
    end     
    %旋转图片
    for random=1:9
        if random\2==0
            x=-10;
        else
            x=10;
        end 
    image_rotate= imrotate(image,x*rand(1),'nearest','crop');
    % 将16x16矩阵（图片)转换成向量
    %imshow(image_rotate{random});
        for i=1:16
            for j=1:16
                image_vector_rotate((i-1)*16+j,1)=image(i,j);
            end
        end     
        train.inputs(:,random*1000+num)=image_vector_rotate;
        train.targets(:,random*1000+num)=train.targets(:,num);
    end
end
save train.mat train;