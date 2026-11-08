function [result, sol] = run_crtn(varargin)
%RUN_CRTN Run the flexible cRTN model from any current folder.
%
% Name-value options:
%   "NumberOfHeats"  Production target (default 3)
%   "DayIndex"       Electricity-price day, 1-31 (default 26)
%   "Gap"            Gurobi relative MIP gap (default 1e-4)
%   "TimeLimit"      Solver time limit in seconds (default 15000)

root = setup_project();
check_installation();

p = inputParser;
addParameter(p, "NumberOfHeats", 3, @(x) isnumeric(x) && isscalar(x) && x >= 1);
addParameter(p, "DayIndex", 26, @(x) isnumeric(x) && isscalar(x) && x >= 1 && x <= 31);
addParameter(p, "Gap", 1e-4, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, "TimeLimit", 15000, @(x) isnumeric(x) && isscalar(x) && x > 0);
parse(p, varargin{:});

NOF_HEAT = p.Results.NumberOfHeats;
day_index = p.Results.DayIndex;
gap = p.Results.Gap;
TIME_LIMIT = p.Results.TimeLimit;

run(fullfile(root, "cRTN_model", "main_flxb_crtn.m"));
end
