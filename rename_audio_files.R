rename_audio_files <- function(mydir) {
        # param mydir        
        #       - the dir contains all the audio
        emotions <- dir(mydir, all.files = F, recursive = F)
        invisible(lapply(1:length(emotions), function(.emotion_index) {
                emotion_type <- emotions[.emotion_index]
                path_emotion <- file.path(mydir, emotion_type)
                
                list_group_names <- dir(path_emotion)
                
                invisible(lapply(1:length(list_group_names), function(.group_index) {
                        group_name = list_group_names[.group_index]
                        path_emotion_group = file.path(path_emotion,group_name)    
                        list_files = list.files(path_emotion_group,full.names = T) 
                        
                        # Check if already done-------------------------------
                        if (...){
                                return
                        }
                        
                        # Locate----------------------------------------------
                        # identift the correct sent 1 file
                        sent1_file_name = find_sent1(path_emotion_group) # should output with path
                        sent2_file_name = find_sent2(path_emotion_group)
                        
                        # Rename---------------------------------------------
                        # new names
                        sent1_new_name = file.path(path_emotion_group,
                                                   paste0(emotion_type,"_",group_name,"_A.wav"))
                        sent2_new_name = file.path(path_emotion_group,
                                                   paste0(emotion_type,"_",group_name,"_B.wav"))
                        
                        # sent1
                        rename_sent1_succes = file.rename(from = sent1_file_name,
                                                          to = sent1_new_name)
                        # sent2
                        rename_sent2_succes = file.rename(from = sent2_file_name,
                                                          to = sent2_new_name)
                        
                        if(!rename_sent1_succes){
                                warning(paste0("Failed: ", sent1_file_name))
                        }
                        if(!rename_sent2_succes){
                                warning(paste0("Failed: ", sent2_file_name))
                        }
                        
                
                        
                }))
                # old file names
                
                # new file names
        }))
}
