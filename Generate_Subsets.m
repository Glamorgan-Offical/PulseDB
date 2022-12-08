clear;clc;
%% Generating training, calibration, and testing subsets of PulseDB
% Note: Height, weight and BMI field for data will only be valid for
% segements from the VitalDB dataset, and wil be NaN for segments from
% the MIMIC-III matched subset, since these infroamtion are not included in
% the original MIMIC-III matched subset.
% Locate segment files
MIMIC_Path='Segment_Files/PulseDB_MIMIC';
Vital_Path='Segment_Files/PulseDB_Vital';

% Locate info files
Train_Info='Info_Files/Train_Info';
CalBased_Test_Info='Info_Files/CalBased_Test_Info';
CalFree_Test_Info='Info_Files/CalFree_Test_Info';
AAMI_Test_Info='Info_Files/AAMI_Test_Info';
AAMI_Cal_Info='Info_Files/AAMI_Cal_Info';

% Generate training set
Generate_Subset(MIMIC_Path,Vital_Path,Train_Info,'Subset_Files/Train_Subset')
% Generate calibration-based testing set
Generate_Subset(MIMIC_Path,Vital_Path,CalBased_Test_Info,'Subset_Files/CalBased_Test_Subset')
% Generate calibration-free testing set
Generate_Subset(MIMIC_Path,Vital_Path,CalFree_Test_Info,'Subset_Files/CalFree_Test_Subset')
% Generate AAMI testing set
Generate_Subset(MIMIC_Path,Vital_Path,AAMI_Test_Info,'Subset_Files/AAMI_Test_Subset')
% Generate AAMI calibration set
Generate_Subset(MIMIC_Path,Vital_Path,AAMI_Cal_Info,'Subset_Files/AAMI_Cal_Subset')
%% Generating supplementary trainining, calibration, and testing subsets from only VitalDB subjects
% Locate info files
VitalDB_Train_Info='Supplementary_Info_Files/VitalDB_Train_Info';
VitalDB_CalBased_Test_Info='Supplementary_Info_Files/VitalDB_CalBased_Test_Info';
VitalDB_CalFree_Test_Info='Supplementary_Info_Files/VitalDB_CalFree_Test_Info';
VitalDB_AAMI_Test_Info='Supplementary_Info_Files/VitalDB_AAMI_Test_Info';
VitalDB_AAMI_Cal_Info='Supplementary_Info_Files/VitalDB_AAMI_Cal_Info';

% Generate training set
Generate_Subset(MIMIC_Path,Vital_Path,VitalDB_Train_Info,'Supplementary_Subset_Files/VitalDB_Train_Subset')
% Generate calibration-based testing set
Generate_Subset(MIMIC_Path,Vital_Path,VitalDB_CalBased_Test_Info,'Supplementary_Subset_Files/VitalDB_CalBased_Test_Subset')
% Generate calibration-free testing set
Generate_Subset(MIMIC_Path,Vital_Path,VitalDB_CalFree_Test_Info,'Supplementary_Subset_Files/VitalDB_CalFree_Test_Subset')
% Generate AAMI testing set
Generate_Subset(MIMIC_Path,Vital_Path,VitalDB_AAMI_Test_Info,'Supplementary_Subset_Files/VitalDB_AAMI_Test_Subset')
% Generate AAMI calibration set
Generate_Subset(MIMIC_Path,Vital_Path,VitalDB_AAMI_Cal_Info,'Supplementary_Subset_Files/VitalDB_AAMI_Cal_Subset')






%% Function
function Generate_Subset(MIMIC_Path, Vital_Path,Info_File_Path, Save_Name)
%% Retrieve segments from files using the Info file
Info=load(Info_File_Path);
Field=fieldnames(Info);
Info=Info.(Field{1});
Len=numel(Info);


% Pre-allocate memory
Subset.Subject=cell(Len,1);
Subset.Signals=zeros(Len,3,1250);
Subset.SBP=NaN(Len,1);
Subset.DBP=NaN(Len,1);
Subset.Age=NaN(Len,1);
Subset.Gender=cell(Len,1);
Subset.Height=NaN(Len,1);
Subset.Weight=NaN(Len,1);
Subset.BMI=NaN(Len,1);



% Locate unique subjects in the Info file, load subject-by-subject
Subjects=unique({Info.Subj_Name});


pos=1;
f=waitbar(0,['Gathering Data For: ', Save_Name]);
f.Children.Title.Interpreter = 'none';
for i=1:numel(Subjects)
    waitbar(i/numel(Subjects),f)
    
    Subj_Name=Subjects{i};
    Subj_ID=Subj_Name(1:7);
    Source=str2double(Subj_Name(end));
    if Source==0
        Segment_Path=MIMIC_Path;
    elseif Source==1
        Segment_Path=Vital_Path;
    end
    
    
    
    Segments_File=load(fullfile(Segment_Path,Subj_ID));
    Subj_Segments=Segments_File.Subj_Wins;
    Selected_IDX=[Info(strcmp({Info.Subj_Name},Subj_Name)).Subj_SegIDX]; % All selected segments belonging to this subject
    
    for j=Selected_IDX
        Segment=Subj_Segments(j);
        Subset.Subject{pos}=Subj_Name;
        Subset.Signals(pos,:,:)=[Segment.ECG_F,Segment.PPG_F,Segment.ABP_Raw]';
        Subset.SBP(pos)=Segment.SegSBP;
        Subset.DBP(pos)=Segment.SegDBP;
        Subset.Age(pos)=Segment.Age;
        Subset.Gender{pos}=Segment.Gender;
        if Source==1 %Record information for VitalDB subjects
            Subset.Height(pos)=Segment.Height;
            Subset.Weight(pos)=Segment.Weight;
            Subset.BMI(pos)=Segment.BMI;
        end
        pos=pos+1;
    end
    
end
waitbar(1,f,'Saving File')
save(Save_Name, 'Subset','-v7.3')
delete(f)
end