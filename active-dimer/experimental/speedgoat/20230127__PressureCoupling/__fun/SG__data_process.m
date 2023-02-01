function data_struct = SG__data_process(data)
%SG__SAVE Summary of this function goes here
%   Detailed explanation goes here
    addpath('__fun');
    p = param_struct();
    
    H21 = [];               
    H31 = [];
    H41 = [];
    
    C21 = [];% coherence 
    C31 = [];% coherence
    C41 = [];% coherence  
    
    [H21,F] = tfestimate(data(:,1),data(:,2),p.wind,[],p.freq,p.fs_rec);
    [H31,F] = tfestimate(data(:,1),data(:,3),p.wind,[],p.freq,p.fs_rec);
    [H41,F] = tfestimate(data(:,1),data(:,4),p.wind,[],p.freq,p.fs_rec);
    
    [C21,F] = mscohere(data(:,1),data(:,2),p.wind,[],p.freq,p.fs_rec);
    [C31,F] = mscohere(data(:,1),data(:,3),p.wind,[],p.freq,p.fs_rec);
    [C41,F] = mscohere(data(:,1),data(:,4),p.wind,[],p.freq,p.fs_rec);
    
    %data_struct = struct;

    data_struct.H21 = H21;
    data_struct.H31 = H31;
    data_struct.H41 = H41;

    data_struct.C21 = C21;
    data_struct.C31 = C31;
    data_struct.C41 = C41;

    data_struct.F = F;
end
