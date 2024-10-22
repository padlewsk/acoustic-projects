function  SG__data_save(processed_data_struct, meas_seq_num)
%SG__SAVE Summary of this function goes here

    H21 = processed_data_struct.H21;
    H31 = processed_data_struct.H31;
    H41 = processed_data_struct.H41;
    C21 = processed_data_struct.C21;
    C31 = processed_data_struct.C31;
    C41 = processed_data_struct.C41;
    F   = processed_data_struct.F;

    save( strcat('C:/Speedgoat/temp/H21_',string(meas_seq_num),'.mat'),'H21');
    save( strcat('C:/Speedgoat/temp/H31_',string(meas_seq_num),'.mat'),'H31');
    save( strcat('C:/Speedgoat/temp/H41_',string(meas_seq_num),'.mat'),'H41');
    save( strcat('C:/Speedgoat/temp/C21_',string(meas_seq_num),'.mat'),'C21');
    save( strcat('C:/Speedgoat/temp/C31_',string(meas_seq_num),'.mat'),'C31');
    save( strcat('C:/Speedgoat/temp/C41_',string(meas_seq_num),'.mat'),'C41');
end
