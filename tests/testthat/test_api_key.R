context("Using API keys")

test_that("API keys can be passed as search_* functions", {
  set_search_key("063198343fec41479da3478755fb9a81")
  familyid <- search_family_id(query = "Cyprinidae")
  expect_match(familyid$Cyprinidae$data$record_id, "bf72e220caf04592a68c025fc5c2bfb7")

  # taxonid <- search_taxon_id(query = "Uncia uncia",name = "scientificName")
  # expect_match(taxonid$scientificName, "Uncia uncia")
  #
  # checklist <- search_checklist(query="025397f9-9891-40a7-b90b-5a61f9c7b597")
  # expect_match(checklist$taxonTree$kingdom, "Animalia")
})
