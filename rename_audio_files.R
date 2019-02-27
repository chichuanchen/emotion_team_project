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
      emotion <- substr(.group_list[[i]], nchar(.group_list[[i]]) - 5, nchar(.group_list[[i]]) - 4)
      name_with_modify <- list.files(.group_list[i], pattern = "modify")
      if (!!length(name_with_modify)) {
        modify_new_name <-
          sprintf("%s_%s_A.wav", emotion, substring(.group_list[[i]], nchar(.group_list[[i]]) - 2))
        file_to_delete <- list.files(.group_list[i], pattern = "Sent1")
        file.rename(name_with_modify, modify_new_name)
        file.remove(file_to_delete)
        # print(emotion)
        # print(.group_list[[i]])
        print(paste0(name_with_modify, " was changed to ", modify_new_name))
        print(paste0(file_to_delete, " has been deleted"))
      } else {
        A_tbc <- list.files(.group_list[i], pattern = "Sent1")
        A_new_name <-
          sprintf("%s_%s_A.wav", emotion, substring(.group_list[[i]], nchar(.group_list[[i]]) - 2))
        file.rename(A_tbc, A_new_name)
        print(paste0(A_tbc, " was changed to ", A_new_name))
      }
      B_tbc <- list.files(.group_list[i], pattern = "Sent2")
      B_new_name <-
        sprintf("%s_%s_B.wav", emotion, substring(.group_list[[i]], nchar(.group_list[[i]]) - 2))
      file.rename(B_tbc, B_new_name)
      print(paste0(B_tbc, " was changed to ", B_new_name))
    }
  }))
}
