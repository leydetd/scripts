

ch.out <- rep(NA,20) ## Calinksi index
sil.out <- rep(NA,20) ## Silhouette index
for (i in 2:20) {
  wna.kmeans <- kmeans(wnaclim.s, centers = i, nstart = 50)
  ch.out[i] <- calinhara(wnaclim.s, wna.kmeans$cluster)
  tmp <- silhouette(wna.kmeans$cluster, dist(wnaclim.s))
  sil.out[i] <- mean(tmp[,3])
}

