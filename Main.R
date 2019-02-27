#Constants
PATH_HELPER_FUNCTION = "D:\\emotion_audios\\rename_audio_files\\emotion_team_project\\helper_functions.R"
PATH_RENAME_AUDIO_FILES = "D:\\emotion_audios\\rename_audio_files\\emotion_team_project\\rename_audio_files.R"
PATH_ALL_FILES = "D:/emotion_audios/all_files"
#Source functions
source(PATH_HELPER_FUNCTION)  
source(PATH_RENAME_AUDIO_FILES)  
# Run
rename_audio_files(PATH_ALL_FILES)
