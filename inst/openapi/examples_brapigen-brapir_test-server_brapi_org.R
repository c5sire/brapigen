## tested calls: GET 72, POST 4
## result section: Master
brapi_get_locations_locationDbId(con = con, locationDbId = "1") # 6
brapi_get_trials_trialDbId(con = con, trialDbId = "101") # 8
brapi_get_studies_studyDbId(con = con, studyDbId = "1001") # 12
brapi_get_methods_methodDbId(con = con, methodDbId = "m1") # 25
brapi_get_scales_scaleDbId(con = con, scaleDbId = "s1") # 28
brapi_get_traits_traitDbId(con = con, traitDbId = "t1") # 31
brapi_get_variables_observationVariableDbId(con = con, observationVariableDbId = "MO_123:100002") # 33
brapi_get_breedingmethods_breedingMethodDbId(con = con, breedingMethodDbId = "bm1") # 35
brapi_get_germplasm_germplasmDbId(con = con, germplasmDbId = "1") # 37
brapi_get_germplasm_germplasmDbId_markerprofiles(con = con, germplasmDbId = "1") # 39
brapi_get_germplasm_germplasmDbId_mcpd(con = con, germplasmDbId = "1") # 40
brapi_get_germplasm_germplasmDbId_pedigree(con = con, germplasmDbId = "1")#, notation = "", includeSiblings = NA) # 41
brapi_get_germplasm_germplasmDbId_progeny(con = con, germplasmDbId = "1") # 42
brapi_get_markers_markerDbId(con = con, markerDbId = "mr01") # 47
brapi_get_samples_sampleDbId(con = con, sampleDbId = "sam01") # 58
brapi_get_vendor_orders_orderId_status(con = con, orderId = "vo1") # 63
brapi_get_vendor_plates_submissionId(con = con, submissionId = "ps1") # 64 MANUALLY ADDED DESCRIPTION OF submissionId as: The submissionId returned by the vendor, when a set of plates was successfully submitted. It is obtained from the response of "POST /vendor/plates" call.
brapi_get_vendor_specifications(con = con) # 65 MANUALLY ADAPTED function arguments!
brapi_get_images_imageDbId(con = con, imageDbId = "img1") # 69
brapi_get_people_personDbId(con = con, personDbId = "person1") # 72
brapi_post_search_programs(con = con)#, abbreviations = "", commonCropNames = "", leadPersonDbIds = "", leadPersonNames = "", objectives = "", page = 0, pageSize = 1000, programDbIds = , programNames = "") # 73
brapi_post_search_studies(con = con)#, active = NA, commonCropNames = "", germplasmDbIds = "", locationDbIds = "", observationVariableDbIds = "", page = 0, pageSize = 1000, programDbIds = "", programNames = "", seasonDbIds = "", sortBy = "", sortOrder = "", studyDbIds = "", studyNames = "", studyTypeDbIds = "", studyTypeNames = "", trialDbIds = "") # 74
brapi_post_search_observationtables(con = con)#, germplasmDbIds = '', locationDbIds = '', observationLevel = '', observationTimeStampRangeEnd = '', observationTimeStampRangeStart = '', observationVariableDbIds = '', page = 0, pageSize = 1000, programDbIds = '', seasonDbIds = '', studyDbIds = '', trialDbIds = '') # 75 changed: #' @details Returns a list of observationUnit with the observed Phenotypes. observationTimeStampRangeStart and observationTimeStampRangeEnd need to be specified in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) formatting.
brapi_post_search_observationunits(con = con)#, germplasmDbIds = '', locationDbIds = '', observationLevel = '', observationTimeStampRangeEnd = '', observationTimeStampRangeStart = '', observationVariableDbIds = '', page = 0, pageSize = 1000, programDbIds = '', seasonDbIds = '', studyDbIds = '', trialDbIds = '') # 76  changed: #' @details Returns a list of observationUnit with the observed Phenotypes. observationTimeStampRangeStart and observationTimeStampRangeEnd need to be specified in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) formatting.
brapi_post_search_variables(con = con)#, dataTypes = '', methodDbIds = '', observationVariableDbIds = '', observationVariableNames = '', observationVariableXrefs = '', ontologyDbIds = '', page = 0, pageSize = 1000, scaleDbIds = '', scaleXrefs = '', traitClasses = '', traitDbIds = '', traitXrefs = '') # 77
brapi_post_search_germplasm(con = con)#, accessionNumbers = '', commonCropNames = '', germplasmDbIds = '', germplasmGenus = '', germplasmNames = '', germplasmPUIs = '', germplasmSpecies = '', page = 0, pageSize = 1000) # 78
brapi_post_search_markers(con = con)#, includeSynonyms = NA, markerDbIds = '', markerNames = '', matchMethod = '', page = 0, pageSize = 1000, types = '') # 79
brapi_post_allelematrices_search(con = con)#, expandHomozygotes = NA, format = as.character(NA), markerDbId = '', markerProfileDbId = '', matrixDbId = '', page = 0, pageSize = 1000, sepPhased = '', sepUnphased = '', unknownString = '') # 80
brapi_post_search_samples(con = con)#, germplasmDbIds = '', observationUnitDbIds = '', page = 0, pageSize = 1000, plateDbIds = '', sampleDbIds = '') # 81

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
brapi_get_studies_studyDbId_table(con = con, studyDbId = "1001")#, format = "") # 18
brapi_get_studytypes(con = con)#, studyTypDbId = "", pageSize = 1000, page = 0) #19
brapi_get_observationlevels(con = con)#, pageSize = 1000, page = 0) # 20
brapi_get_observationunits(con = con)#, germplasmDbId = "", observationVariableDbId = "", studyDbId = "", locationDbId = "", trialDbId = "", programDbId = "", seasonDbId = "", observationLevel = "", observationTimeStampRangeStart = "", observationTimeStampRangeEnd = "", page = 0, pageSize = 1000) # 21
brapi_get_search_observationtables_searchResultsDbId(con = con, searchResultsDbId = "")#, Accept = "application/json", page = 0, pageSize = 1000) # 22
brapi_get_search_observationunits_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 23
brapi_get_methods(con = con)#, page = 0, pageSize = 1000) # 24
brapi_get_ontologies(con = con)#, page = 0, pageSize = 1000) # 26
brapi_get_scales(con = con)#, page = 0, pageSize = 1000) # 27
brapi_get_search_variables_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 29
brapi_get_traits(con = con)#, page = 0, pageSize = 1000) # 30
brapi_get_variables(con = con)#, observationVariableDbId = "", traitClass = "", page = 0, pageSize = 1000) # 32
brapi_get_breedingmethods(con = con)#, page = 0, pageSize = 1000) # 34
brapi_get_germplasm(con = con)#, germplasmPUI = "", germplasmDbId = "", germplasmName = "", commonCropName = "", page = 0, pageSize = 1000) # 36
brapi_get_search_germplasm_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 43
brapi_get_attributes(con = con)#, attributeCategoryDbId = "", page = 0, pageSize = 1000) # 44
brapi_get_attributes_categories(con = con, page = 0)#, pageSize = 1000) # 45
brapi_get_markers(con = con)#, markerDbId = "", markerName = "", includeSynonyms = NA, type = "", page = 0, pageSize = 1000) # 46
brapi_get_search_markers_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 48
brapi_get_allelematrices(con = con, studyDbId = "1001")#, page = 0, pageSize = 1000) # 49
brapi_get_allelematrices_search(con = con)#, markerProfileDbId = c(""), markerDbId = c(""), matrixDbId = c(""), format = "", expandHomozygotes = NA, unknownString = "", sepPhased = "", sepUnphased = "", page = 0, pageSize = 1000) # 50 Changed to _search!
brapi_get_markerprofiles(con = con)#, germplasmDbId = "", studyDbId = "", sampleDbId = "", extractDbId = "", page = 0, pageSize = 1000) # 51
brapi_get_maps(con = con)#, commonCropName = "", scientificName = "", type = , page = 0, pageSize = 1000) # 53
brapi_get_maps_mapDbId_positions(con = con, mapDbId = "gm2")#, linkageGroupName = "", page = 0, pageSize = 1000) # 55
brapi_get_maps_mapDbId_positions_linkageGroupName(con = con, mapDbId = "gm2", linkageGroupName = "3")#, min = , max = , page = 0, pageSize = 1000) # 56
brapi_get_samples(con = con)#, sampleDbId = "", observationUnitDbId = "", plateDbId = "", germplasmDbId = "", page = 0, pageSize = 1000) # 57
brapi_get_search_samples_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 4) # 59
brapi_get_vendor_orders(con = con)#, orderId = ""), submissionId = "") # 60
brapi_get_vendor_orders_orderId_plates(con = con, orderId = "vo1") # 61
brapi_get_vendor_orders_orderId_results(con = con, orderId = "vo1") # 62
brapi_get_lists(con = con)#, listType = "", listName = "", listDbId = "", listSource = "", page = 0, pageSize = 1000) # 66
brapi_get_images(con = con)#, imageDbId = "", imageName = "", observationUnitDbId = "", observationDbId = "", descriptiveOntologyTerm = "", page = 0, pageSize = 1000) # 68
brapi_get_search_images_searchResultsDbId(con = con, searchResultsDbId = "")#, page = 0, pageSize = 1000) # 70 Empty POST call!
brapi_get_people(con = con)#, firstName = "", lastName = "", personDbId = "", userID = "", page = 0, pageSize = 1000) # 71

## result section: Master/Detail
brapi_get_studies_studyDbId_germplasm(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 13
brapi_get_studies_studyDbId_observationvariables(con = con, studyDbId = "1001")#, pageSize = 1000, page = 0) # 17
brapi_get_germplasm_germplasmDbId_attributes(con = con, germplasmDbId = "1")#, attributeDbIds = c("", ""), page = 0, pageSize = 1000) # 38
brapi_get_markerprofiles_markerProfileDbId(con = con, markerProfileDbId = "P1")#, expandHomozygotes = NA, unknownString = "", sepPhased = "", sepUnphased = "", page = 0, pageSize = 1000) # 52
brapi_get_maps_mapDbId(con = con, mapDbId = "gm2")#, page = 0, pageSize = 1000) # 54
brapi_get_lists_listDbId(con = con, listDbId = "list1") # 67
