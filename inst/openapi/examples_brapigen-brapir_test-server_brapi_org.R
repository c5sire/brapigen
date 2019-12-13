## test calls
## result section: Master
brapi_get_germplasm_germplasmDbId(con = con, germplasmDbId = "3")
brapi_get_images_imageDbId(con = con, imageDbId = "img1")
brapi_get_methods_methodDbId(con = con, methodDbId = "m1")
brapi_get_studies_studyDbId(con = con, studyDbId = "1001")
brapi_get_locations_locationDbId(con = con, locationDbId = "1")
brapi_get_trials_trialDbId(con = con, trialDbId = "101")


## result section: Detail
brapi_get_calls(con = con) #, dataType = "application/json")
brapi_get_commoncropnames(con = con)
brapi_get_programs(con = con)
brapi_get_locations(con = con)#, locationType = "Storage location")
brapi_get_trials(con = con)
brapi_get_seasons(con = con)
brapi_get_studies(con = con)
brapi_get_studies_studyDbId_layouts(con = con, studyDbId = "1001") # CONTINUE HERE!
brapi_get_markers(con = con)


## result section: Master/Detail
brapi_get_studies_studyDbId_germplasm(con = con, studyDbId = "1001")
brapi_get_germplasm_germplasmDbId_attributes(con = con, germplasmDbId = "3")
