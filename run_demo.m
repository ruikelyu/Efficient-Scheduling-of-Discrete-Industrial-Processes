function [result, sol] = run_demo(varargin)
%RUN_DEMO Run the small cRTN example from any current folder.
%
% Name-value options:
%   "Scenario"  Electricity-price scenario (default 2)
%   "TimeLimit" Solver time limit in seconds (default 300)

root = setup_project();
check_installation();

p = inputParser;
addParameter(p, "Scenario", 2, @(x) isnumeric(x) && isscalar(x));
addParameter(p, "TimeLimit", 300, @(x) isnumeric(x) && isscalar(x) && x > 0);
parse(p, varargin{:});

scenario = p.Results.Scenario;
TIME_LIMIT = p.Results.TimeLimit;

run(fullfile(root, "cRTN_model", "main_small_case_crtn.m"));
end
