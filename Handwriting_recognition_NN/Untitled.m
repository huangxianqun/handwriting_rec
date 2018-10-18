close all;clear all;
map = false(10);
cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...    %机器人1
    0 1 0; ...
    1 1 0; ...
    0.8 0.8 0.8;  %路径1
    0.6 0.6 0.6;  %路径2
    0.4 0.4 0.4;  %路径3
    0.2 0.2 0.2;  %路径4
    0.1 0.1 0.1   %路径5
    0.8 0 0;      %机器人2
    0.6 0.4 0.12;      %机器人3
    0.63 0.12 0.94;      %机器人4
    0.19 0.5 0.07];     %机器人5   

colormap(cmap);
% Add an obstacle
map (2, 2:3) = true; map (2, 5:6) = true; map (2, 8:9) = true;
map (3, 2:3) = true; map (3, 5:6) = true; map (3, 8:9) = true;
map (5, 2:3) = true; map (5, 5:6) = true; map (5, 8:9) = true;
map (6, 2:3) = true; map (6, 5:6) = true; map (6, 8:9) = true;
map (8, 2:3) = true; map (8, 5:6) = true; map (8, 8:9) = true;
map (9, 2:3) = true; map (9, 5:6) = true; map (9, 8:9) = true;


            image(1.5, 1.5, map);
            grid on;
            axis image;
