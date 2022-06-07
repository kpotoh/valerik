# https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/plot.cca

library('vegan')

setwd("valerik/data/")

otus <- read.csv("processed/otu_table_for_cca1.csv")
metalls <- read.csv("processed/metalls.csv")
X <-  otus[2:ncol(otus)]
Y <- metalls[3:ncol(metalls)]
rownames(X) <- otus$Samples
rownames(Y) <- metalls$Sample


mplants_CCA <- cca(X, Y)
mplants_CCA
# the total variation in the data is:
round(mplants_CCA$tot.chi, 2)
# the sum of all canonical eigenvalues:
round(mplants_CCA$CCA$tot.chi, 2)
# all four explanatory variables explain
cat(round(mplants_CCA$CCA$tot.chi
          /mplants_CCA$tot.chi*100), "% of data", "\n")
# the first two (canonical) eigenvalues are:
round(mplants_CCA$CCA$eig[1:2], 2)

# so the first two canonical axes explain:
cat(round(sum(mplants_CCA$CCA$eig[1:2])
          /mplants_CCA$CCA$tot.chi*100), "%", "\n")
# 65% of the variation that can be explained

# with the four environmental variables
# but this is (the first two canonical axes explain):
cat(round(sum(mplants_CCA$CCA$eig[1:2])
          /mplants_CCA$tot.chi*100), "%", "\n")
# 37% of the total variation in the data

# plot(mplants_CCA, scaling = 2, main="Scaling2")
# plot(mplants_CCA, scaling = 1, main="Scaling1")

balt.cca <- cca(X, Y)
mod <- balt.cca
balt.cca$CCA$biplot
balt.cca$grand.total
head(summary(balt.cca), tail=5)
importance <- summary(balt.cca, display=c("wa"))$concont$importance
xlabel <- paste("CCA1 (", round(importance["Proportion Explained", "CCA1"], 3) * 100, "%)", sep="")
ylabel <- paste("CCA2 (", round(importance["Proportion Explained", "CCA2"], 3) * 100, "%)", sep="")

# scaling="sites"
png(file="../figures/CCA.png", width=700, height=500, pointsize = 13)
plot(balt.cca, type="p", display = c("wa","cn"), ylim=range(-1.6, 1.9), xlab=xlabel, ylab=ylabel,)
points(balt.cca, "species", pch = 3, cex = .4, col = rgb(red = 1, green = 0, blue = 0, alpha = 0.3))
points(balt.cca, pch=21, col="red", bg="green", cex=1.2, )
text(balt.cca, "sites", col="darkgreen", cex=0.9, font=2, pos=3, offset=.7)
dev.off()

balt.rda <- rda(X, Y)
plot(balt.rda)



data(varespec)
data(varechem)
## Common but bad way: use all variables you happen to have in your
## environmental data matrix
vare.cca <- cca(varespec, varechem)
vare.cca
plot(vare.cca, )
## Formula interface and a better model
vare.cca <- cca(varespec ~ Al + P*(K + Baresoil), data=varechem)
vare.cca
plot(vare.cca)
## Partialling out and negative components of variance
cca(varespec ~ Ca, varechem)
cca(varespec ~ Ca + Condition(pH), varechem)
## RDA
data(dune)
data(dune.env)
dune.Manure <- rda(dune ~ Manure, dune.env)
plot(dune.Manure) 
