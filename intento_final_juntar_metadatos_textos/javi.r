out <- vector("list", length(list))
for(i in c("D","E")){
  out[[i]] <- do.call("rbind", lapply(l, function(x) x[[i]]))
}