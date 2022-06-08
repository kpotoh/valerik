# https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/plot.cca

library('vegan')

setwd("valerik/data/")

# Example
data(BCI)
sp1 <- specaccum(BCI)
sp2 <- specaccum(BCI, "random")
sp2
summary(sp2)
plot(sp1, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
boxplot(sp2, col="yellow", add=TRUE, pch="+")

# Example stuff
## Fit Lomolino model to the exact accumulation
# mod1 <- fitspecaccum(sp1, "lomolino")
# coef(mod1)
# fitted(mod1)
# plot(sp1)
# ## Add Lomolino model using argument 'add'
# plot(mod1, add = TRUE, col=2, lwd=2)
# ## Fit Arrhenius models to all random accumulations
# mods <- fitspecaccum(sp2, "arrh")
# plot(mods, col="hotpink")
# boxplot(sp2, col = "yellow", border = "blue", lty=1, cex=0.3, add= TRUE)
# ## Use nls() methods to the list of models
# sapply(mods$models, AIC)


otus <- read.csv("processed/otu_table_for_cca1.csv")
X <-  otus[2:ncol(otus)]
rownames(X) <- otus$Samples

sp1 <- specaccum(X)
sp2 <- specaccum(X, "random")
sp2
summary(sp2)

png(file="../figures/specaccum.png", width=700, height=500, pointsize = 13)
plot(sp1, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue", xlab="Количество образцов", ylab="Количество OTUs")
boxplot(sp2, col="yellow", add=TRUE, pch="+")
dev.off()


















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

