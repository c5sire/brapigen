## test calls: CONTINUE WITH 18
## result section: Master
brapi_get_images_imageDbId(con = con, imageDbId = "img1")
brapi_get_methods_methodDbId(con = con, methodDbId = "m1")
brapi_get_locations_locationDbId(con = con, locationDbId = "1") # 6
brapi_get_trials_trialDbId(con = con, trialDbId = "101") # 8
brapi_get_studies_studyDbId(con = con, studyDbId = "1001") # 12
brapi_get_germplasm_germplasmDbId(con = con, germplasmDbId = "3")

## result section: Detail
brapi_get_calls(con = con)#, dataType = "application/json") # 1
brapi_get_commoncropnames(con = con)#, pageSize = 1, page = 1) # 2
brapi_get_programs(con = con)#, commonCropName = "Tomatillo", programName = "Program 1", abbreviation = "P1", pageSize = 1, page = 0) # 3
brapi_get_search_programs_searchResultsDbId(con = con, searchResultsDbId = "")#, pageSize = 1000, page = 0) # 4
brapi_get_locations(con = con)#, locationType = "Storage location") # 5
brapi_get_trials(con = con)#, commonCropName = "", programDbId = "", locationDbId = "", active = NA, sortBy = "", sortOrder = "", pageSize = "", page = "") # 7
brapi_get_search_studies_searchResultsDbId(con = con, searchResultsDbId = "")#, pageSize = 1000, page = 0) # 9
brapi_get_seasons(con = con)#, seasonDbId = "", season = "", year = "", pageSize = 1000, page = 0) # 10
brapi_get_studies(con = con)#, commonCropName = "", studyTypeDbId = "", programDbId = "", locationDbId = "", seasonDbId = "", trialDbId = "", studyDbId = "", active = NA, sortBy = "", sortOrder = "", pageSize = 1000, page = 0) # 11
brapi_get_studies_studyDbId_layouts(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 14
brapi_get_studies_studyDbId_observations(con = con, studyDbId = "1001")# , observationVariableDbIds = '', page = 0, pageSize = 1000) # 15
brapi_get_studies_studyDbId_observationunits(con = con, studyDbId = "1001")#, observationLevel = "", pageSize = 1000, page = 0) # 16
brapi_get_studies_studyDbId_table(con = con, studyDbId = "1001")#, format = "csv") # 18
brapi_get_markers(con = con)


## result section: Master/Detail
brapi_get_studies_studyDbId_germplasm(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 13
brapi_get_studies_studyDbId_observationvariables(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 17
brapi_get_germplasm_germplasmDbId_attributes(con = con, germplasmDbId = "3")
