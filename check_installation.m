function report = check_installation()
%CHECK_INSTALLATION Verify the dependencies required to run the models.

root = fileparts(mfilename("fullpath"));
setup_project();

report = struct();
report.matlabVersion = version;
report.matlabSupported = ~verLessThan("matlab", "24.2");
report.yalmipAvailable = exist("sdpvar", "file") == 2 && exist("optimize", "file") == 2;
report.gurobiAvailable = exist("gurobi", "file") == 2;
report.requiredFiles = {
    fullfile(root, "parameter_setting", "param_small_case.mat")
    fullfile(root, "parameter_setting", "param_zhang_2017.mat")
    fullfile(root, "cRTN_model", "main_small_case_crtn.m")
    fullfile(root, "cRTN_model", "main_flxb_crtn.m")
    };
report.filesAvailable = all(cellfun(@isfile, report.requiredFiles));
report.ok = report.matlabSupported && report.yalmipAvailable && ...
    report.gurobiAvailable && report.filesAvailable;

fprintf("MATLAB %s: %s\n", report.matlabVersion, statusText(report.matlabSupported));
fprintf("YALMIP: %s\n", statusText(report.yalmipAvailable));
fprintf("Gurobi MATLAB interface: %s\n", statusText(report.gurobiAvailable));
fprintf("Repository files: %s\n", statusText(report.filesAvailable));

if ~report.matlabSupported
    fprintf("  Requires MATLAB R2024b or newer.\n");
end
if ~report.yalmipAvailable
    fprintf("  Install YALMIP and add its folder to the MATLAB path.\n");
end
if ~report.gurobiAvailable
    fprintf("  Install Gurobi, install its MATLAB interface, and configure a license.\n");
end
if ~report.filesAvailable
    fprintf("  One or more bundled parameter/model files are missing.\n");
end
if ~report.ok
    error("Scheduling:InstallationIncomplete", ...
        "Installation is incomplete. Resolve the messages above before running a model.");
end
end

function text = statusText(value)
if value
    text = "OK";
else
    text = "MISSING";
end
end
