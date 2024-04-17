

ch.out <- rep(NA,20) ## Calinksi index
sil.out <- rep(NA,20) ## Silhouette index
for (i in 2:20) {
  con.kmeans <- kmeans(con.som$codes[[1]], centers = i, nstart = 50)
  ch.out[i] <- calinhara(con.som$codes[[1]], con.kmeans$cluster)
  tmp <- silhouette(con.kmeans$cluster, dist(con.som$codes[[1]]))
  sil.out[i] <- mean(tmp[,3])
}

