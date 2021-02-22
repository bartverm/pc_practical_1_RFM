classdef River < handle
    properties(Constant)
        g = 9.81
    end
    properties
        slope = 1e-4
        discharge = 1000
        chezy = 50
    end
    methods
        function out = critical_slope ( obj )
            out = obj.g / obj.chezy ^2;
        end
    end
end