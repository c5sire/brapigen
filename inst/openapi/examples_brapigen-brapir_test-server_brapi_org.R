## tested calls: GET 72, POST 21, PUT 10
##
## library(brapir)
## con <- brapi_db()$testserver
## class(con) <- c("list", "brapi", "brapi_con")
## con[["token"]] <- "YYYY"
##
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
brapi_get_vendor_plates_submissionId(con = con, submissionId = "ps1") # 64 MANUALLY ADDED DESCRIPTION OF submissionId as: character; required: TRUE; A unique alpha-numeric identifier, which identifies a set of plates which have been successfully submitted. It is obtained from the response of the "POST /vendor/plates" call implemented in the `brapi_post_vendor_plates()` function; default: &quot;&quot;.
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
brapi_post_search_images(con = con)#, descriptiveOntologyTerms = '', imageFileNames = '', imageFileSizeMax = as.integer(NA), imageFileSizeMin = as.integer(NA), imageHeightMax = as.integer(NA), imageHeightMin = as.integer(NA), imageLocation = list(), imageNames = '', imageTimeStampRangeEnd = '', imageTimeStampRangeStart = '', imageWidthMax = as.integer(NA), imageWidthMin = as.integer(NA), mimeTypes = '', observationDbIds = '', observationUnitDbIds = '') # 82
brapi_post_images(con = con, additionalInfo = list(company = "Wageningen University & Research", group =  "Plant Science Group",  businessUnit= "Biometris"), copyright = "Copyright 2020", description = "WUR Logo", descriptiveOntologyTerms = c("wur", "logo"), imageFileName = "WUR_RGB_standard.png", imageFileSize = 15121, imageHeight = 95, imageLocation = imageLocation, imageName = "wurLogo", imageTimeStamp = "2020-05-05", imageWidth = 500, mimeType = "image/png", observationDbIds = c( "1", "2"), observationUnitDbId = "1") # 83 Requirements: con$token <- "YYYY", library(geojsonR); init <- TO_GeoJson$new(); imageLocation <- list(); pointData <- c(5.665797, 51.984732); imageLocation[["geometry"]] <- init$Point(data = pointData, stringify = FALSE); imageLocation$type <- "Feature"; rm(init, pointData)
brapi_post_methods(con = con, class = "Numeric", description = "Net Weight/Ha", formula = "NA", methodName = "Phenotypic analysis", ontologyReference = ontologyReference, reference = "WEBPAGE") # 84 Requirements: con$token <- "YYYY", ontologyReference <- list(documentationLinks = data.frame(URL = "https://www.cropontology.org/terms/CO_333:1000040/", type = "webpage"), ontologyDbId = "CO_333:1000040", ontologyName = "cropontology.org", version = "5.0")
brapi_post_people(con = con, description = "Count BrAPIR", emailAddress = "somewhere.only@we.know", firstName = "Maikel", lastName = "Verouden", mailingAddress = "P.O. Box 16, 6700 AA Wageningen, The Netherlands", middleName = "", phoneNumber = "+31123456789", userID = "verou007") # 85 Requirement: con$token <- "YYYY"
brapi_post_scales(con = con, dataType = 'Ordinal', decimalPlaces = 0, ontologyReference = ontologyReference, scaleName = 'clothing sizes', validValues = validValues, xref = 'xref') # 86 Requirements: con$token <- "YYYY", ontologyReference = list(documentationLinks = data.frame(URL = "https://Ontology.org/s5", type = "RDF"), ontologyDbId = "MO_123", ontologyName = "Ontology.org", version = "17"); validValues = list(categories = c("xs", "s", "m", "l", "xl", "xxl"), max = 0, min = 0)
brapi_post_traits(con = con, alternativeAbbreviations = "", attribute = "size", class = "morphological trait", description = "Size designation of clothes", entity = "clothing", mainAbbreviation = "CS", ontologyReference = ontologyReference, status = "legacy", synonyms = "", traitName = "clothingSize", xref = "none") # 87 Requirements: con$token <- "YYYY", ontologyReference = list(documentationLinks = data.frame(URL = "https://Ontology.org/s6", type = "RDF"), ontologyDbId = "MO_123", ontologyName = "Ontology.org", version = "17")
brapi_post_lists(con = con, data = c("breedingStudy1", "breedingStudy2"), description = "list of breeding studies", listName = "breedList1", listOwnerName = "Rob Robertson", listOwnerPersonDbId = "person2", listSize = 2, listSource = "breeding program generator", listType = "studies") # 88 Requirement: con$token <- "YYYY"
brapi_post_phenotypes(con = con, format = as.character(NA), data = data) # 89 Requirements: con$token <- "YYYY"; data <- data.frame(observatioUnitDbId = "7", studyDbId = "1002"); datadf <- data.frame(collector = c("C. Technical", "C. Technical"), observationDbId = c("", ""), observationTimeStamp = c("2020-05-15T15:30:00.760Z", "2020-05-15T15:31:16.760Z"), observationVariableDbId = c("MO_123:100002", "MO_123:100003"), observationVariableName = c("Plant height", "Carotenoid"), season = c("spring", "spring"), value = c("1.75", "1.4")); data[["observations"]] <- list(datadf)
brapi_post_lists_listDbId_items(con = con, listDbId = "list1", items = c("4", "5")) # 90 Requirement: con$token <- "YYYY"
brapi_post_studies_studyDbId_table(con = con, studyDbId = "1001", data = data, headerRow = headerRow, observationVariableDbIds = observationVariableDbIds) # 91 Requirements: con$token <- "YYYY" for data, headerRow and observationVariableDbIds see example section of documentation
brapi_post_vendor_orders(con = con, clientId = "BrAPIR", numberOfSamples = 4, plates = plates, requiredServiceInfo = list(additionalProp1 = "stringAddProp1", additionalProp2 = "stringAddProp2", additionalProp3 = "stringAddProp3"), sampleType = "DNA", serviceIds = "vsp1") # 92 Requirements: con$token <- "YYYY" for plates see example section of documentation
brapi_post_vendor_plates(con = con, clientId = "BrAPIR", numberOfSamples = 4, plates = plates, sampleType = "DNA") # 93 Requirements: con$token <- "YYYY" for plates see example section of documentation
brapi_put_images_imageDbId(con = con, imageDbId = "img2", additionalInfo = additionalInfo <- list(additionalProp1 = "addProp1string", additionalProp2 = "addProp2string", additionalProp3 = "addProp3string"), copyright = "Copyright 2020", description = "BrAPI Logo 2020", descriptiveOntologyTerms = c("brapi", "logo", "svg"), imageFileName = "brapi-logo.svg", imageFileSize = 3676, imageHeight = 56, imageLocation = imageLocation, imageName = "modified_brapiLogo", imageTimeStamp = "2020-05-29T11:30:12.007Z", imageWidth = 258, mimeType = "image/svg", observationDbIds = c("1", "2"), observationUnitDbId = "1") # 94 Requirements: con$token <- "YYYY" and library(geojsonR); init <- TO_GeoJson$new(); imageLocation <- list(); pointData <- c(5.663038, 51.986648); imageLocation[["geometry"]] <- init$Point(data = pointData, stringify = FALSE); imageLocation[["type"]] <- "Feature"; rm(init, pointData)
brapi_put_images_imageDbId_imagecontent(con = con, imageDbId = "img2", imageFileName = "../../../Pictures/brapi-logo.svg") # 95 Requirement: con$token <- "YYYY"
brapi_put_lists_listDbId(con = con, listDbId = "list1", data = c("1", "2", "3", "4", "5"), description = "Example list of germplasm", listName = "Example List 1", listOwnerName = "Bob Robertson", listOwnerPersonDbId = "person1", listSize = 5, listSource = "User Created", listType = "germplasm") # 96 Requirement: con$token <- "YYYY"
brapi_put_methods_methodDbId(con = con, methodDbId = "m1", class = "Numeric", description = "Standard measuring tape", formula = "sqrt(a^2 + b^2) = c", methodName = "Tape Measurement", ontologyReference = ontologyReference, reference = "goggles.com") # 97 Requirements: con$token <- "YYYY"; ontologyReference <- list(documentationLinks = data.frame(URL = "https://ontology.org/m1",  type = "WEBPAGE"), ontologyDbId = "MO_123", ontologyName = "Ontology.org", version = "17")
brapi_put_people_personDbId(con = con, personDbId = "person1", description = "Test Example Person", emailAddress = "firstname.lastname@wur.nl", firstName = "Firstname", lastName = "Lastname", mailingAddress = "Droevendaalsesteeg 1, 6708 PB Wageningen, The Netherlands", middleName = "Middlename", phoneNumber = "+31317481234", userID = "gebrui001") # 98 Requirement: con$token <- "YYYYY"
brapi_put_samples(con = con, germplasmDbId = "2", notes = "Testing PUT function", observationUnitDbId = "3", plantDbId = "", plateDbId = "pl1", plateIndex = 16, plotDbId = "2", sampleDbId = "", sampleTimestamp = "2020-06-02T12:05:03Z", sampleType = "DNA", studyDbId = "1002", takenBy = "Rob", tissueType = "Stem") # 99 Requirement: con$token <- "YYYYY"
brapi_put_scales_scaleDbId(con = con, scaleDbId = "", dataType = "Ordinal", decimalPlaces = 0, ontologyReference = ontologyReference, scaleName = "Clothing Sizes", validValues = validValues, xref = "xref") # 100 Requirements: con$token <- "YYYY", use scaleDbId from brapi_post_scales() example 86; ontologyReference = list(documentationLinks = data.frame(URL = "https://Ontology.org/s5", type = "RDF"), ontologyDbId = "MO_123", ontologyName = "Ontology.org",version = "17"); validValues = list(categories = c("xxs", "xs", "s", "m", "l", "xl", "xxl"), max = 0, min = 0)
brapi_put_studies_studyDbId_layouts(con = con, studyDbId = '1001', layout = layout) # 101 Requirements: con$token <- "YYYY"; layout <- data.frame(blockNumber = c("12"), entryType = c("CHECK"), observationUnitDbId = c("1"), positionCoordinateX = c("12"), positionCoordinateXType = c("GRID_COL"), positionCoordinateY = c("12"), positionCoordinateYType = c("GRID_ROW"), replicate = c("1"))
brapi_put_studies_studyDbId_observations(con = con, studyDbId = '1001', observations = observations) # 102 Requirements: con$token <- "YYYY", observations <- data.frame(collector = c("Jack", "Freddy"), observationDbId = c("3", ""), observationTimeStamp = c(paste0(anytime::iso8601(lubridate::with_tz(Sys.time(), tzone = "UTC")), "Z"), paste0(anytime::iso8601(lubridate::with_tz(Sys.time(), tzone = "UTC")), "Z")), observationUnitDbId = c("2", "4"), observationVariableDbId = c("MO_123:100002", "MO_123:100006"), value = c("2.2", "0.8"))
brapi_put_traits_traitDbId(con = con, traitDbId = "", alternativeAbbreviations = c("clothSize", "sizeCloth"),                          attribute = "size", class = "physiological trait", description = "Size designation of clothes", entity = "clothing", mainAbbreviation = "CS", ontologyReference = ontologyReference, status = "legacy", synonyms = c("sizeClothing", "cSizes"), traitName = "clothingSize", xref = "xref") # 103 Requirements: con$token <- "YYYY", traitDbId retrieved by brapi_get_traits() after using brapi_post_traits() in example 87, ontologyReference <- list(documentationLinks = data.frame(URL = "https://Ontology.org/s6", type = "RDF"), ontologyDbId = "MO_123", ontologyName = "Ontology.org", version = "17")
brapi_put_studies_studyDbId_observationunits(con = con, studyDbId = "1002", observationUnits = observationUnits, observationUnitXrefList = observationUnitXrefList, treatmentList = treatmentList, observationsList = observationsList, seasonList = seasonList) # 104 Requirements: Requirements: con$token <- "YYYY", specification of other elements see example in documentation!

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
brapi_get_attributes_categories(con = con)#, page = 0, pageSize = 1000) # 45
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
