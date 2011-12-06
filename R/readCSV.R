readMultiCSV =
function(txt, ...)
{
    # break the data into different blocks by splitting
    # on more than one new line.
  blocks = strsplit(txt, "\\\n{2,}")[[1]]

  ans = lapply(blocks, readCSVBlock, ...)
  names(ans) =  c("Total", "Week", "Region", "Cities", "Languages")
  ans
}

readCSVBlock =
function(txt, ...)
{
  con = textConnection(txt)
  on.exit(close(con))
  read.csv(con, ...)
}
