
library(zoon)
library(ggplot2)
library(ggmap)
library(raster)
library(RStoolbox)
library(viridis)
library(reshape2
        )
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = LogisticRegression,
                                   output = PrintMap)

occ <- Occurrence(Carolina_Wren_Workflow)
cov <- Process(Carolina_Wren_Workflow)$df
levels(cov) <- c('background', 'presence')
out <- Output(Carolina_Wren_Workflow)
out.df <- as.data.frame(out, xy=TRUE)

Carolina_Wren_Workflow2 <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = LogisticRegression,
                                   output = PrintOccurrenceMap)

# plot square raster of predictions on two covariates we care about
df <- Process(Carolina_Wren_Workflow2)$df
model <- Model(Carolina_Wren_Workflow2)


covs <- c('pcMix', 'pcDec')
# not_covs <- all_covs[!all_covs %in% covs]
# mn <- as.list(colMeans(df[, not_covs]))

# range of values
pcMix_lim <- range(df[, 'pcMix'])
pcDec_lim <- range(df[, 'pcDec'])

# cell points
res <- 100
pcMix <- seq(pcMix_lim[1], pcMix_lim[2], length = res + 1)[-1]
pcDec <- seq(pcDec_lim[1], pcDec_lim[2], length = res + 1)[-1]

# cell values for grids
coords <- expand.grid(pcMix = pcMix,
                      pcDec = pcDec,
                      pcCon = mean(df[, 'pcCon']),
                      pcGr = mean(df[, 'pcGr']),
                      Lat = mean(df[, 'Lat']),
                      Lon = mean(df[, 'Lon']))

p <- predict(model$model$model, coords, type = 'response')

p_mat <- matrix(p,
                nrow = res,
                ncol = res,
                byrow = FALSE)

mp <- melt(p_mat)

zoon_theme <- theme_bw() +
  theme(
  plot.background = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(),
  panel.border = element_rect(colour = "black", fill = NA, size = 2.5),
  axis.title.x = element_text(hjust = 0.9, size = 20, face = 'bold'),
  axis.title.y = element_text(size = 20, face = 'bold'),
  legend.position = 'none'
  )

png('vignettes/Intro_Module_files/SDM_theory.png',
    width     = 12,
    height    = 3,
    units     = "in",
    res       = 1200,
    pointsize = 4)
require(gridExtra)
ll <- ggplot(cov, aes(longitude, latitude)) +
  geom_point(aes(colour = type), size = 1) +
  scale_colour_manual(values = c('grey', 'black')) +
  theme(axis.title.y = element_text(angle = 180, vjust = 0.1)) +
  zoon_theme +
  coord_fixed(ratio = 1)
  xlab('E') +
  ylab('N')
env <- ggplot(cov, aes(pcMix, pcDec)) +
  geom_point(aes(colour = type), size = 1) +
  zoon_theme +
  theme(axis.title.y = element_text(hjust = 0.9)) +
  scale_colour_manual(values = c('grey', 'black')) +
  xlab('Mixed Forest') +
  ylab('Deciduous')
epre <- ggplot(mp, aes(Var2, Var1, fill = value)) + geom_raster() +
  scale_fill_viridis() +
  zoon_theme +
  theme(axis.title.y = element_text(hjust = 0.9)) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  xlab('Mixed Forest') +
  ylab('Deciduous')
pred <- ggplot(out.df) +
  geom_raster(aes(x, y, fill = pcMix)) +
  zoon_theme +
  theme(axis.title.y = element_text(angle = 180, vjust = 0.1)) +
  scale_fill_viridis(direction = -1) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  xlab('E') +
  ylab('N')
grid.arrange(ll, env, epre, pred, ncol=4)

dev.off()



image(p_mat,
      xlab = 'pcMix',
      ylab = 'pcDec',
      col = rev(viridis::viridis(1000)),
      asp = 1,
      pty = 's')

