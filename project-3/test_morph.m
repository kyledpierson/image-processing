clc;
clear all;
close all;

% Morph using different param files
morph('params/morph/shape-8g1.txt');
morph('params/morph/shape-8g10.txt');
morph('params/morph/shape-8t.txt');

%morph('params/morph/ball-4g1.txt');
%morph('params/morph/ball-8g1.txt');
%morph('params/morph/ball-8g10.txt');
%morph('params/morph/ball-4t.txt');
%morph('params/morph/ball-8t.txt');

%morph('params/morph/face-10g1.txt');
%morph('params/morph/face-13g1.txt');
%morph('params/morph/face-13g10.txt');
%morph('params/morph/face-10t.txt');
%morph('params/morph/face-13t.txt');
