####### rename audio files
# original format:
# G1-MicA_Sent1.wav
# G1-MicA_Sent1_modify.wav
# G1-MicB_Sent2.wav

## later found out there are more than these 3 types of names

# issues: 1) there is no emotion information in original file names
#         2) if there exists a "modify" file name, rename it
#         3) delete ones not needed at the end?

# goal format:
# AN_G01_A.wav
# AN_G01_B.wav

# for windows user: please change the file separator "\" to "/"
# mydir <- "D:/emotion_audios/all_files"

# usage example: rename_audio_files("D:/emotion_audios/all_files")
rename_audio_files <- function(mydir) {
  emotions <- dir(mydir, all.files = F, recursive = T)

  # list out all the group directories
  group_list <- sapply(emotions, function(.emotions) {
    list.dirs(file.path(mydir, .emotions), full.names = T, recursive = F)
  }, simplify = F, USE.NAMES = T)

  invisible(lapply(group_list, function(.group_list) {

    # print(paste0("emotion now: ", emotion))
    for (i in 1:length(.group_list)) {

      # local constants
      path_emotion_group <- .group_list[[i]]

      setwd(path_emotion_group) ## Not recommended (does not work for mclapply)
      # fix the modify files first
      # only A would have modify
      # emotion <- substr(path_emotion_group, nchar(path_emotion_group) - 5, nchar(path_emotion_group) - 4)

      # Solution 1: REGEX
      # locate the start and the length of the emotion type string
      locator <- regexpr(
        pattern = "(?<=all_files/)\\w*(?=/G)",
        text = path_emotion_group,
        perl = T
      )
      locator_starting_position <- locator
      locator_length <- attr(locator, "match.length")
      substr(
        x = path_emotion_group,
        start = locator_starting_position,
        stop = locator_starting_position + locator_length - 1
      )

      name_with_modify <- list.files(.group_list[i], pattern = "modify")
      if (!!length(name_with_modify)) {
        modify_new_name <-
          sprintf("%s_%s_A.wav", emotion, substring(path_emotion_group, nchar(path_emotion_group) - 2))
        file_to_delete <- list.files(.group_list[i], pattern = "Sent1")
        file.rename(name_with_modify, modify_new_name)
        file.remove(file_to_delete)
        # print(emotion)
        # print(path_emotion_group)
        print(paste0(name_with_modify, " was changed to ", modify_new_name))
        print(paste0(file_to_delete, " has been deleted"))
      } else {
        A_tbc <- list.files(.group_list[i], pattern = "Sent1")
        A_new_name <-
          sprintf("%s_%s_A.wav", emotion, substring(path_emotion_group, nchar(path_emotion_group) - 2))
        file.rename(A_tbc, A_new_name)
        print(paste0(A_tbc, " was changed to ", A_new_name))
      }
      B_tbc <- list.files(.group_list[i], pattern = "Sent2")
      B_new_name <-
        sprintf("%s_%s_B.wav", emotion, substring(path_emotion_group, nchar(path_emotion_group) - 2))
      file.rename(B_tbc, B_new_name)
      print(paste0(B_tbc, " was changed to ", B_new_name))
    }
  }))
}
##############################################

# Helper functions---------------------------------------

find_sent1 = function(path_with_sent1_files){
        # param: path_with_sent1_files
        #         - the path which contains the sent1 files
        # return:
        #         - the file string with path of the correct sint1 file
        list_sent1_candidates = list.files(path_with_sent1_files,full.names = T,
                                           pattern = "Sent1")
        list_boolean_modify = grepl(pattern = "modify",x = list_sent1_candidates)
        if(any(list_boolean_modify)){
                return(list_sent1_candidates[list_boolean_modify])
        }else if(length(list_sent1_candidates)==1){
                return(list_sent1_candidates)
        }else{
                error(paste0("The number of Sent 1 file in ",
                             path_with_sent1_files,
                             " is incorrect"))
        }
}
sent_filew

# Main funcions------------------------------------------
rename_audio_files <- function(mydir) {
        emotions <- dir(mydir, all.files = F, recursive = T)
        invisible(lapply(1:length(emotions), function(.emotion_index) {
                emotion_type <- emotions[.emotion_index]
                path_emotion <- file.path(mydir, emotion_type)
                
                list_group_names <- dir(path_emotion)
                
                invisible(lapply(1:length(list_group_names), function(.group_index) {
                        group_name = list_group_names[.group_index]
                        path_emotion_group = file.path(path_emotion,group_name)    
                        list_files = list.files(path_emotion_group,full.names = T) 
                        
                        # Call helper functions
                        # identift the correct sent 1 file
                        sent1_file_name = find_sent1(dir) # should output with path
                        
                        # new names
                        sent1_new_name = file.path(path_emotion_group,
                                                   paste0(emotion_type,"_",group_name,"_A.wav"))
                        sent2_new_name = file.path(path_emotion_group,
                                                   paste0(emotion_type,"_",group_name,"_B.wav"))
                        # sent1
                        file.rename(from = sent1_file_name,
                                    to = sent1_new_name)
                        # sent2
                        file.rename(from = sent2_file_name,
                                    to = sent2_new_name)
                }))
                # old file names
                
                # new file names
        }))
}
