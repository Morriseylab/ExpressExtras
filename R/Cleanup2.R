#' Cleans up topTable results
#' converts logFC to FC
#' @param vals : output from topTable
#' @return Dataframe with limma output
#' @export
#' @examples
#' Cleanup2()

Cleanup2 <-function(tt){
  data('ptntype')
  res <- tt %>% mutate(fc = ifelse(logFC<0, -1*2^abs(logFC),2^logFC)) %>%
    dplyr::select(ENSEMBL,SYMBOL,ENTREZID,biotype,geneloc,logFC,fc,P.Value,adj.P.Val,t)
  res=left_join(res,ptntype,by=c("ENSEMBL"="ENSEMBL")) %>% dplyr::select(-gene) %>% dplyr::select(ENSEMBL:geneloc,protein_type,logFC:t)
  rownames(res) <- rownames(tt)
  return(res)
}
