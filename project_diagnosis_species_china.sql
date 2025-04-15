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

--- Creation of a list of bird species in China segmented by taxonomic order

SELECT species AS 学名, family AS 科, name_zh AS 中文名, name_en AS 英文名, name_es AS 西班牙文名,
name_fr AS 法文名, name_de AS 德语名, name_rs AS 俄语名, name_it AS 意大利语名, name_pr AS 葡萄牙语名,
name_jp AS 日语名, SUM(numberofoccurrences) AS 出现次数, gbif_link, baidu_link
FROM bird_species_china WHERE ordern = 'Bucerotiformes'
GROUP BY 学名, 科, 中文名, 英文名, 西班牙文名, 法文名, 德语名, 俄语名, 意大利语名, 葡萄牙语名, 日语名, 
gbif_link, baidu_link
ORDER BY 出现次数 DESC;

--- Creation of GBIF Backbone and Baidu page links fields

ALTER TABLE bird_species_china ADD COLUMN gbif_link varchar(200), ADD COLUMN baidu_link varchar(200);

UPDATE bird_species_china SET gbif_link = 'https://www.gbif.org/species/' || specieskey;
UPDATE bird_species_china SET baidu_link = 'https://baike.baidu.com/item/' || name_zh;

--- Creation of the conservation status table for threatened species

SELECT species AS 学名, name_zh AS 中文名, name_en AS 英文名, name_es AS 西班牙文名, 
iucnredlistcategory AS 保护状况, SUM(numberofoccurrences) AS 出现次数
FROM bird_species_china 
WHERE ordern = 'Apodiformes' AND iucnredlistcategory <> 'LC' AND iucnredlistcategory is not null
GROUP BY 学名, 中文名, 英文名, 西班牙文名, 保护状况 ORDER BY 出现次数 DESC;


