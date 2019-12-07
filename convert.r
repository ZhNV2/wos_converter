library(bibliometrix)
library(gtools)
library(revtools)


# обязательно должны быть в формате .ciw
merge_blocks_in_data_frame <- function(files) {
  do.call(smartbind, lapply(files, read_bibliography))
}

tag_line <- function(tag, value) {
  if (!is.na(value)) {
    paste(tag, ' = {{', value, '}},\n', sep = '')
  }
}
# принимает data_frame, печатает его в файл *.bib
convert_ciw_to_bibtex <- function(data_frame, bibtex_filename) {
  close(file( bibtex_filename, open="w" ) )
  sink(file=bibtex_filename, append=TRUE)
  for (row in 1:nrow(data_frame)) {
    id = paste('ISI:',row,sep='')
    cat('\n')
    cat(paste('@article{', id, ',\n', sep = ''))
    cat(paste('Author = {', data_frame[row, "author_full"], '},\n', sep=''))
    cat(tag_line('Title', data_frame[row, "title"]))
    cat(tag_line('Journal', gsub('&', '\\\\&', data_frame[row, "journal"])))
    cat(tag_line('Year', data_frame[row, "year"]))
    cat(tag_line('Volume', data_frame[row, "volume"]))
    cat(tag_line('Number', data_frame[row, "issue"]))
    cat(tag_line('Pages', data_frame[row, "pages"]))
    cat(tag_line('Month', data_frame[row, "pd"]))
    cat(tag_line('Abstract', data_frame[row, "abstract"]))
    cat(tag_line('Publisher', data_frame[row, "pu"]))
    cat(tag_line('Address', data_frame[row, "pa"]))
    cat(tag_line('Type', data_frame[row, "dt"]))
    cat(tag_line('Language', data_frame[row, "language"]))

    t <- data_frame[row, "c1"]
    t <- gsub("\\[|\\]", "", t)
    t <- gsub(' and ', '', t)

    cat(tag_line('Affiliation', paste(data_frame[row, "rp"], '\n', t, sep = '')))
    cat(tag_line('DOI', data_frame[row, "doi"]))
    cat(tag_line('ISSN', data_frame[row, "issn"]))
    cat(tag_line('EISSN', data_frame[row, "ei"]))
    cat(tag_line('Keywords', gsub(' and ', ' ', data_frame[row, "keywords"])))

    cat(tag_line('Keywords-Plus', gsub(' and ', ' ', data_frame[row, "id"])))
    cat(tag_line('Research-Areas', data_frame[row, "sc"]))
    cat(tag_line('Web-of-Science-Categories', data_frame[row, "wc"]))
    cat(tag_line('Author-Email', data_frame[row, "em"]))
    cat(tag_line('ORCID-Numbers', data_frame[row, "oi"]))
    cat(tag_line('Funding-Acknowledgement', data_frame[row, "fu"]))
    cat(tag_line('Funding-Text', data_frame[row, "fx"]))

    cat(tag_line('Cited-References', data_frame[row, "cr"]))
    cat(tag_line('Number-of-Cited-References', data_frame[row, "nr"]))
    cat(tag_line('Times-Cited', data_frame[row, "tc"]))
    cat(tag_line('Usage-Count-Last-180-days', data_frame[row, "u1"]))
    cat(tag_line('Usage-Count-Since-2013', data_frame[row, "u2"]))
    cat(tag_line('Journal-ISO', data_frame[row, "ji"]))
    cat(tag_line('Doc-Delivery-Number', data_frame[row, "ga"]))
    cat(tag_line('Unique-ID', id))
    cat(tag_line('DA', data_frame[row, "da"]))
    cat('}')

  }
  sink(file=NULL)
  sink()
  
}

FOLDER = '/Users/Nikolay/Downloads/'
BLOCK = paste(FOLDER, 'savedrecs-', sep='')
OPEN_REFINE_INPUT_CSV = paste(FOLDER, 'open_refine_input.csv', sep='')
OPEN_REFINE_OUTPUT_CSV = paste(FOLDER, 'open_refine_input-csv.csv', sep='')
BIBTEX = paste(FOLDER, 'test.bib', sep='')

# blocks filenames
files <- c()
for (i in 3:6) {
  files <- append(files, paste(BLOCK, i, ".ciw", sep=''))
}

#merge in one date frame
df <- merge_blocks_in_data_frame(files)
write.csv2(df, file=OPEN_REFINE_INPUT_CSV)

#...processing with open refine
#read new data frame
t <- read_bibliography(OPEN_REFINE_OUTPUT_CSV)
#save to bibtex
convert_ciw_to_bibtex(t, BIBTEX)
D <- readFiles(BIBTEX)
X <- convert2df(D, dbsource = 'isi', format = 'bibtex')
result <- biblioAnalysis(X)
