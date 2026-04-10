%% Q2: Hybrid Intelligent System (ANFIS)
clear; clc;

% 1. Generate Training Data (50 Students)
rng(42); 
att = 40 + 60*rand(50,1); 
assig = 30 + 70*rand(50,1); 
test = 20 + 80*rand(50,1);
perf = (0.2*att + 0.3*assig + 0.5*test)/10; % Underlying logic
data = [att, assig, test, perf];

% 2. Generate Initial FIS (Grid Partitioning)
opt = genfisOptions('GridPartition');
opt.NumMembershipFunctions = [3 3 3];
opt.InputMembershipFunctionType = 'trimf';
initial_fis = genfis(data(:,1:3), data(:,4), opt);

% 3. Train ANFIS (Neural Network Integration)
[trained_fis, trainError] = anfis(data, initial_fis, 50);

% 4. Visualize
figure; plot(trainError); title('Q2: ANFIS Training Error');
xlabel('Epochs'); ylabel('Root Mean Square Error');
figure; gensurf(trained_fis); title('Q2: Student Performance Surface');

% Save the model
writeFIS(trained_fis, 'student_model.fis');
disp('Hybrid Student Model trained and saved.');
