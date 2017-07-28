classdef WbTester < MondrianTester
%WBTESTER provide an interface to apply white balance to image
%to the input Mondrian

	properties(Access = private)

		wbFunc = @CorrectionProvider.whiteBalance;  % White Balance is considered as a Correction function
	end

	methods
		function obj = WbTester(space, solution, corrFunc)
			% Constructor

			% default correction is gamma normalized
			if ~exist('corrFunc', 'var'), corrFunc = @CorrectionProvider.gamma_normalized; end

    	% superclass constructor call
    	obj = obj@MondrianTester(space, solution, corrFunc);

			% customize output path
			customOutPath = [obj.filenames.outDir 'WB/'];
    	obj.filenames.outDir = customOutPath;
		end

		function I = run(obj, experiment)
			% apply the correction to Mondrian from experiment

			obj.experiment = experiment;
			obj.loadExisting;

			obj.Iperceptual = obj.corrFunc(obj.readImage(obj.filenames.perceptual));
			% normalize
			obj.Iperceptual = obj.Iperceptual./max(obj.Iperceptual(:));

			I = obj.corrFunc(obj.wbFunc(obj.Iexperimental));
			% normalize
			I=I./max(I(:));
			obj.Ioutput = I;
		end

		function loadExisting(obj)
			% load existing files

			if strcmp(obj.experiment, 'None'), return, end

			obj.Iexperimental = obj.readImage(obj.filenames.myinput);
			obj.Iperceptual = obj.readImage(obj.filenames.perceptual);
		end
	end
end