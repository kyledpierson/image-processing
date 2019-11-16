clc;
clear all;
close all;

% Atlas using different param files
atlas('params/atlas/shape-8g1.txt');
atlas('params/atlas/shape-8g10.txt');
atlas('params/atlas/shape-8t.txt');

atlas('params/atlas/back-5g1.txt');
atlas('params/atlas/back-8g1.txt');
atlas('params/atlas/back-8g10.txt');
atlas('params/atlas/back-5t.txt');
atlas('params/atlas/back-8t.txt');

atlas('params/atlas/brain-5g1.txt');
atlas('params/atlas/brain-7g1.txt');
atlas('params/atlas/brain-7g10.txt');
atlas('params/atlas/brain-5t.txt');
atlas('params/atlas/brain-7t.txt');
