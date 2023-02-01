function xcp = tf_Pb_Xi__SGxcp

xcp.events     =  repmat(struct('id',{}, 'sampletime', {}, 'offset', {}), getNumEvents, 1 );
xcp.parameters =  repmat(struct('symbol',{}, 'size', {}, 'dtname', {}, 'baseaddr', {}), getNumParameters, 1 );
xcp.signals    =  repmat(struct('symbol',{}), getNumSignals, 1 );
xcp.models     =  cell(1,getNumModels);
    
xcp.models{1} = 'tf_Pb_Xi__SG';
   
   
         
xcp.events(1).id         = 0;
xcp.events(1).sampletime = 2.5E-5;
xcp.events(1).offset     = 0.0;
    
xcp.signals(1).symbol =  'tf_Pb_Xi__SG_B.FromWorkspace1';
    
xcp.signals(2).symbol =  'tf_Pb_Xi__SG_B.HighpassFilter.HighpassFilter2';
    
xcp.signals(3).symbol =  'tf_Pb_Xi__SG_B.HighpassFilter1.HighpassFilter2';
    
xcp.signals(4).symbol =  'tf_Pb_Xi__SG_B.HighpassFilter2.HighpassFilter2';
    
xcp.signals(5).symbol =  'tf_Pb_Xi__SG_B.HighpassFilter3';
    
xcp.signals(6).symbol =  'tf_Pb_Xi__SG_B.Constant4';
    
xcp.signals(7).symbol =  'tf_Pb_Xi__SG_B.Constant5';
    
xcp.signals(8).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion';
    
xcp.signals(9).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion1';
    
xcp.signals(10).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion2';
    
xcp.signals(11).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion3';
    
xcp.signals(12).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion4';
    
xcp.signals(13).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion5';
    
xcp.signals(14).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion6';
    
xcp.signals(15).symbol =  'tf_Pb_Xi__SG_B.DataTypeConversion7';
    
xcp.signals(16).symbol =  'tf_Pb_Xi__SG_B.Gain';
    
xcp.signals(17).symbol =  'tf_Pb_Xi__SG_B.Gain1';
    
xcp.signals(18).symbol =  'tf_Pb_Xi__SG_B.Gain2';
    
xcp.signals(19).symbol =  'tf_Pb_Xi__SG_B.Gain3';
    
xcp.signals(20).symbol =  'tf_Pb_Xi__SG_B.Gain4';
    
xcp.signals(21).symbol =  'tf_Pb_Xi__SG_B.Gain5';
    
xcp.signals(22).symbol =  'tf_Pb_Xi__SG_B.Gain6';
    
xcp.signals(23).symbol =  'tf_Pb_Xi__SG_B.Gain7';
    
xcp.signals(24).symbol =  'tf_Pb_Xi__SG_B.RateTransition';
    
xcp.signals(25).symbol =  'tf_Pb_Xi__SG_B.RateTransition1';
    
xcp.signals(26).symbol =  'tf_Pb_Xi__SG_B.RateTransition2';
    
xcp.signals(27).symbol =  'tf_Pb_Xi__SG_B.RateTransition3';
    
xcp.signals(28).symbol =  'tf_Pb_Xi__SG_B.dtc';
    
xcp.signals(29).symbol =  'tf_Pb_Xi__SG_B.dtc1';
    
xcp.signals(30).symbol =  'tf_Pb_Xi__SG_B.dtc2';
    
xcp.signals(31).symbol =  'tf_Pb_Xi__SG_B.dtc3';
    
xcp.signals(32).symbol =  'tf_Pb_Xi__SG_B.dtc4';
    
xcp.signals(33).symbol =  'tf_Pb_Xi__SG_B.dtc5';
    
xcp.signals(34).symbol =  'tf_Pb_Xi__SG_B.dtc6';
    
xcp.signals(35).symbol =  'tf_Pb_Xi__SG_B.dtc7';
    
xcp.signals(36).symbol =  'tf_Pb_Xi__SG_B.IO3xxPCIRead';
    
xcp.signals(37).symbol =  'tf_Pb_Xi__SG_B.IO3xxPCIRead1';
    
xcp.signals(38).symbol =  'tf_Pb_Xi__SG_B.IO3xxPCIRead2';
    
xcp.signals(39).symbol =  'tf_Pb_Xi__SG_B.IO3xxPCIRead3';
         
xcp.parameters(1).symbol = 'tf_Pb_Xi__SG_P.Constant_Value';
xcp.parameters(1).size   =  1;       
xcp.parameters(1).dtname = 'real_T'; 
xcp.parameters(2).baseaddr = '&tf_Pb_Xi__SG_P.Constant_Value';     
         
xcp.parameters(2).symbol = 'tf_Pb_Xi__SG_P.Constant1_Value';
xcp.parameters(2).size   =  1;       
xcp.parameters(2).dtname = 'real_T'; 
xcp.parameters(3).baseaddr = '&tf_Pb_Xi__SG_P.Constant1_Value';     
         
xcp.parameters(3).symbol = 'tf_Pb_Xi__SG_P.Constant2_Value';
xcp.parameters(3).size   =  1;       
xcp.parameters(3).dtname = 'real_T'; 
xcp.parameters(4).baseaddr = '&tf_Pb_Xi__SG_P.Constant2_Value';     
         
xcp.parameters(4).symbol = 'tf_Pb_Xi__SG_P.Constant4_Value';
xcp.parameters(4).size   =  1;       
xcp.parameters(4).dtname = 'int16_T'; 
xcp.parameters(5).baseaddr = '&tf_Pb_Xi__SG_P.Constant4_Value';     
         
xcp.parameters(5).symbol = 'tf_Pb_Xi__SG_P.Constant5_Value';
xcp.parameters(5).size   =  1;       
xcp.parameters(5).dtname = 'boolean_T'; 
xcp.parameters(6).baseaddr = '&tf_Pb_Xi__SG_P.Constant5_Value';     
         
xcp.parameters(6).symbol = 'tf_Pb_Xi__SG_P.Gain_Gain';
xcp.parameters(6).size   =  1;       
xcp.parameters(6).dtname = 'real_T'; 
xcp.parameters(7).baseaddr = '&tf_Pb_Xi__SG_P.Gain_Gain';     
         
xcp.parameters(7).symbol = 'tf_Pb_Xi__SG_P.Gain1_Gain';
xcp.parameters(7).size   =  1;       
xcp.parameters(7).dtname = 'real_T'; 
xcp.parameters(8).baseaddr = '&tf_Pb_Xi__SG_P.Gain1_Gain';     
         
xcp.parameters(8).symbol = 'tf_Pb_Xi__SG_P.Gain2_Gain';
xcp.parameters(8).size   =  1;       
xcp.parameters(8).dtname = 'real_T'; 
xcp.parameters(9).baseaddr = '&tf_Pb_Xi__SG_P.Gain2_Gain';     
         
xcp.parameters(9).symbol = 'tf_Pb_Xi__SG_P.Gain3_Gain';
xcp.parameters(9).size   =  1;       
xcp.parameters(9).dtname = 'real_T'; 
xcp.parameters(10).baseaddr = '&tf_Pb_Xi__SG_P.Gain3_Gain';     
         
xcp.parameters(10).symbol = 'tf_Pb_Xi__SG_P.Gain4_Gain';
xcp.parameters(10).size   =  1;       
xcp.parameters(10).dtname = 'real_T'; 
xcp.parameters(11).baseaddr = '&tf_Pb_Xi__SG_P.Gain4_Gain';     
         
xcp.parameters(11).symbol = 'tf_Pb_Xi__SG_P.Gain5_Gain';
xcp.parameters(11).size   =  1;       
xcp.parameters(11).dtname = 'real_T'; 
xcp.parameters(12).baseaddr = '&tf_Pb_Xi__SG_P.Gain5_Gain';     
         
xcp.parameters(12).symbol = 'tf_Pb_Xi__SG_P.Gain6_Gain';
xcp.parameters(12).size   =  1;       
xcp.parameters(12).dtname = 'real_T'; 
xcp.parameters(13).baseaddr = '&tf_Pb_Xi__SG_P.Gain6_Gain';     
         
xcp.parameters(13).symbol = 'tf_Pb_Xi__SG_P.Gain7_Gain';
xcp.parameters(13).size   =  1;       
xcp.parameters(13).dtname = 'real_T'; 
xcp.parameters(14).baseaddr = '&tf_Pb_Xi__SG_P.Gain7_Gain';     
         
xcp.parameters(14).symbol = 'tf_Pb_Xi__SG_P.IO334ADcalibration_P1';
xcp.parameters(14).size   =  1;       
xcp.parameters(14).dtname = 'real_T'; 
xcp.parameters(15).baseaddr = '&tf_Pb_Xi__SG_P.IO334ADcalibration_P1';     
         
xcp.parameters(15).symbol = 'tf_Pb_Xi__SG_P.IO334DACSetup_P1';
xcp.parameters(15).size   =  1;       
xcp.parameters(15).dtname = 'real_T'; 
xcp.parameters(16).baseaddr = '&tf_Pb_Xi__SG_P.IO334DACSetup_P1';     
         
xcp.parameters(16).symbol = 'tf_Pb_Xi__SG_P.IO334DACSetup_P2';
xcp.parameters(16).size   =  1;       
xcp.parameters(16).dtname = 'real_T'; 
xcp.parameters(17).baseaddr = '&tf_Pb_Xi__SG_P.IO334DACSetup_P2';     

function n = getNumParameters
n = 16;

function n = getNumSignals
n = 39;

function n = getNumEvents
n = 1;

function n = getNumModels
n = 1;

