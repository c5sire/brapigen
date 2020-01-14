## test issues: call 22, 23, 39
## test calls: CONTINUE WITH 41
## result section: Master
brapi_get_images_imageDbId(con = con, imageDbId = "img1")
brapi_get_methods_methodDbId(con = con, methodDbId = "m1")
brapi_get_locations_locationDbId(con = con, locationDbId = "1") # 6
brapi_get_trials_trialDbId(con = con, trialDbId = "101") # 8
brapi_get_studies_studyDbId(con = con, studyDbId = "1001") # 12
brapi_get_methods_methodDbId(con = con, methodDbId = "m1") # 25
brapi_get_scales_scaleDbId(con = con, scaleDbId = "s1") # 28
brapi_get_traits_traitDbId(con = con, traitDbId = "t1") # 31
brapi_get_variables_observationVariableDbId(con = con, observationVariableDbId = "MO_123:100002") # 33
brapi_get_breedingmethods_breedingMethodDbId(con = con, breedingMethodDbId = "bm1") # 35
brapi_get_germplasm_germplasmDbId(con = con, germplasmDbId = "1") # 37
brapi_get_markers_markerDbId(con = con, markerDbId = "mr01") # 40

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
brapi_get_studytypes(con = con)#, studyTypDbId = "", pageSize = 1000, page = 0) #19
brapi_get_observationlevels(con = con)#, pageSize = 1000, page = 0) # 20
brapi_get_observationunits(con = con)#, germplasmDbId = "", observationVariableDbId = "", studyDbId = "", locationDbId = "", trialDbId = "", programDbId = "", seasonDbId = "", observationLevel = "", observationTimeStampRangeStart = "", observationTimeStampRangeEnd = "", page = 0, pageSize = 1000) # 21
brapi_get_search_observationunits_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 22 !ISSUE: not able to generate searchResultsDbId from POST call
brapi_get_search_observationtables_searchResultsDbId(con = con, searchResultsDbId = "")#, Accept = "application/json", page = 0, pageSize = 1000) # 23 !ISSUE: not able to generate searchResultsDbId from POST call
brapi_get_methods(con = con)#, page = 0, pageSize = 1000) # 24
brapi_get_ontologies(con = con)#, page = 0, pageSize = 1000) # 26
brapi_get_scales(con = con)#, page = 0, pageSize = 1000) # 27
brapi_get_search_variables_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 29
brapi_get_traits(con = con)#, page = 0, pageSize = 1000) # 30
brapi_get_variables(con = con)#, observationVariableDbId = "", traitClass = "", page = 0, pageSize = 1000) # 32
brapi_get_breedingmethods(con = con)#, page = 0, pageSize = 1000) # 34
brapi_get_germplasm(con = con)#, germplasmPUI = "", germplasmDbId = "", germplasmName = "", commonCropName = "", page = 0, pageSize = 1000) # 36
brapi_get_markers(con = con)#, markerDbId = "", markerName = "", includeSynonyms = NA, type = "", page = 0, pageSize = 1000) # 39 ISSUE WITH markerDbId and includeSynonyms parameters

## result section: Master/Detail
brapi_get_studies_studyDbId_germplasm(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 13
brapi_get_studies_studyDbId_observationvariables(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 17
brapi_get_germplasm_germplasmDbId_attributes(con = con, germplasmDbId = "1")#, attributeDbIds = c("ATT01", "ATT05"), page = 0, pageSize = 1000) # 38
