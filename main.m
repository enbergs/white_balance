% Use wbTester to perform basic White Balance

close all
clear all

% Loading data
filename_basics = '../mondrian_factory/data/basics.mat';

load(filename_basics);  % to get the experiments list

% Parameters

space = 'HDR'
solution = 1  % out of 5 possibilities
corr_func = @CorrectionProvider.toneMapping

figs_on = true
save_on = true
stat_on = true

% Object

correcter = WbTester(space, solution, corr_func);

Costs = [];

%% runs

for experiment = experiments
	experiment=experiment{1}

	correcter.run(experiment);

	if save_on, correcter.save_output; correcter.savePres; correcter.saveDiff; end
	if figs_on, correcter.showPres(); end
	if stat_on, Costs = [Costs; correcter.allCosts()]; end
end