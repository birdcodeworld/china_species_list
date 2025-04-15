-- Diagnosis of flora and fauna species in China

--- Creating fields for vernacular names in Mandarin Chinese, English, Spanish, French, German, Russian, italian,
--- portuguese and japanese

ALTER TABLE bird_species_china ADD COLUMN name_zh varchar(80), ADD COLUMN name_en varchar(80),
ADD COLUMN name_es varchar(80), ADD COLUMN name_fr varchar(80), ADD COLUMN name_de varchar(80), 
ADD COLUMN name_rs varchar(80), ADD COLUMN name_it varchar(80), ADD COLUMN name_pr varchar(80),
ADD COLUMN name_jp varchar(80);

--- Annex of vernacular names in various languages to the list of bird species of China

UPDATE bird_species_china SET name_jp = multilingual_name_list.japanese
FROM multilingual_name_list WHERE bird_species_china.species = multilingual_name_list.species;