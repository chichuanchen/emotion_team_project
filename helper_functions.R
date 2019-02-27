# Helper functions---------------------------------------

find_sent1 = function(path_with_sent1_files){
        # param: path_with_sent1_files
        #         - the path which contains the sent1 files
        # return:
        #         - the file string with path of the correct sint1 file
        find_targeted_sent(path_with_sent_files = path_with_sent1_files,
                           candidate_pattern = "Sent1",
                           target_pattern = "Sent1_modify")
}

find_sent2 = function(path_with_sent2_files){
        # param: path_with_sent2_files
        #         - the path which contains the sent2 files
        # return:
        #         - the file string with path of the correct sint2 file
        find_targeted_sent(path_with_sent_files = path_with_sent2_files,
                           candidate_pattern = "Sent2",
                           target_pattern = "Sent2")
}

find_targeted_sent = function(path_with_sent_files, candidate_pattern, target_pattern){
        # param: path_with_sent_files
        #         - the path which contains the sent files
        #        pattern
        #         - the pattern of the targeted file
        # return:
        #         - the file string with path of the targetd sint file
        list_sent_candidates = list.files(path_with_sent_files,full.names = T,
                                          pattern = candidate_pattern)
        list_boolean_targeted = grepl(pattern = targer_pattern,x = list_sent_candidates)
        if(any(list_boolean_targeted)){
                return(list_sent_candidates[list_boolean_targeted])
        }else if(length(list_sent_candidates)==1){
                return(list_sent_candidates)
        }else{
                stop(paste0("The number of Sent file with pattern: [",
                            target_pattern,
                            "] in ",
                            path_with_sent_files,
                            " is incorrect"))
        }        
}
