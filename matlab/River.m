classdef River < handle
    properties(Constant)
        g = 9.81
    end
    properties
        slope = 1e-4
        discharge = 1000
        chezy = 50
        L = 10000
    end
    methods
        function out = critical_slope ( obj )
            out = obj.g / obj.chezy ^2;
        end
        function out=bed_elevation( obj )
            out = linspace(0, obj.L , 15);
        end
    end
end