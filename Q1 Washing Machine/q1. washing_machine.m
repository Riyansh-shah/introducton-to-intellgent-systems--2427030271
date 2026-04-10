%% Q1: Fuzzy Logic System for Washing Machine Cycle Time
clear; clc;

% 1. Create FIS
fis = mamfis('Name', "WashingMachine");

% 2. Add Inputs
fis = addInput(fis, [0 10], 'Name', "DirtLevel");
fis = addMF(fis, "DirtLevel", 'trimf', [0 0 5], 'Name', "Low");
fis = addMF(fis, "DirtLevel", 'trimf', [2 5 8], 'Name', "Medium");
fis = addMF(fis, "DirtLevel", 'trimf', [5 10 10], 'Name', "High");

fis = addInput(fis, [0 10], 'Name', "LoadSize");
fis = addMF(fis, "LoadSize", 'trimf', [0 0 5], 'Name', "Small");
fis = addMF(fis, "LoadSize", 'trimf', [3 5 7], 'Name', "Medium");
fis = addMF(fis, "LoadSize", 'trimf', [5 10 10], 'Name', "Large");

% 3. Add Output
fis = addOutput(fis, [0 60], 'Name', "CycleTime");
fis = addMF(fis, "CycleTime", 'trimf', [0 10 30], 'Name', "Short");
fis = addMF(fis, "CycleTime", 'trimf', [20 30 45], 'Name', "Medium");
fis = addMF(fis, "CycleTime", 'trimf', [40 50 60], 'Name', "Long");

% 4. Add Rules (Dirt, Load, Time, Weight, Connection)
rules = [
    1 1 1 1 1; % Low & Small = Short
    2 2 2 1 1; % Medium & Medium = Medium
    3 3 3 1 1; % High & Large = Long
    3 1 2 1 1; % High & Small = Medium
    1 3 2 1 1; % Low & Large = Medium
    2 3 3 1 1; % Medium & Large = Long
];
fis = addRule(fis, rules);

% 5. Test & Plot
figure; plotfis(fis);
figure; gensurf(fis); title('Q1: Washing Machine Logic Surface');
disp('Washing Machine FIS created successfully.');



