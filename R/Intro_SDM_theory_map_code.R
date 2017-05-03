
# packages
library(zoon)
library(ggplot2)
library(ggmap)
library(raster)
library(RStoolbox)
library(viridis)
library(reshape2)
library(gridExtra)
library(grid)

# zoon workflow to build carolina wren results
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

# base map version of predictions on environmental space
image(p_mat,
      xlab = 'pcMix',
      ylab = 'pcDec',
      col = rev(viridis::viridis(1000)),
      asp = 1,
      pty = 's')

# melted data to use to ggplot version
mp <- melt(p_mat)

## PLOTTING
# preparing ggplot theme settings
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

# PrintMap colour palette
#cls <- colorRampPalette(c('#e0f3db', '#a8ddb5', '#4eb3d3', '#08589e'))(10)

require(gridExtra)

png('vignettes/Images/SDM_theory_pb.png',
    width     = 7,
    height    = 3,
    units     = "in",
    res       = 1200,
    pointsize = 4)

# presence-background map
usa <- map_data('usa')

#mycolour <- viridis(1000)[800]

pb_map <- ggplot(cov, aes(longitude, latitude)) +
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = grey(0.9), color = grey(0.9)) +
  geom_point(aes(colour = type), size = 0.3) +
  scale_colour_manual(values = c('#D2B48C', 'black')) +
  zoon_theme +
  theme(axis.title.y = element_text(hjust = 0.9)) +
  xlim(-126, -66) +
  ylim(22, 52) +
  xlab('Longitude') +
  ylab('Latitude')

# presence-background on environmental space
pb_env <- ggplot(cov, aes(pcMix, pcDec)) +
  geom_point(aes(colour = type), size = 0.3) +
  zoon_theme +
  theme(axis.title.y = element_text(hjust = 0.9)) +
  scale_colour_manual(values = c('#D2B48C', 'black')) +
  xlab('Mixed Forest') +
  ylab('Deciduous')

grid.arrange(pb_map, pb_env, ncol=2)

dev.off()

png('vignettes/Images/SDM_theory_pred.png',
    width     = 7,
    height    = 3,
    units     = "in",
    res       = 1200,
    pointsize = 4)


# probability of occurrence predictions in environmental space
pred_env <- ggplot(mp, aes(Var1, Var2, fill = value)) + geom_raster() +
  scale_fill_viridis(direction = -1) +
  zoon_theme +
  theme(axis.title.y = element_text(hjust = 0.1)) +
  xlab('Mixed Forest') +
  ylab('Deciduous')

# probability of occurrence predictions map
pred_map <- ggplot(out.df) +
  geom_raster(aes(x, y, fill = pcMix)) +
  zoon_theme +
  scale_fill_viridis(direction = -1) +
  theme(axis.title.y = element_text(hjust = 0.1)) +
  xlim(-126, -66) +
  ylim(22, 52) +
  xlab('Longitude') +
  ylab('Latitude')

grid.arrange(pred_map, pred_env, ncol=2)

dev.off()

# legend plot
zoon_theme_legend <- theme_bw() +
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
    legend.position = 'right',
    legend.key.height = unit(6, "line"),
    legend.key.width = unit(3, "line")
  )

# figure to extract legend from
png('vignettes/Images/SDM_theory_legend.png',
    width     = 7,
    height    = 3,
    units     = "in",
    res       = 1200,
    pointsize = 4)
pred_legend <- ggplot(out.df) +
  geom_raster(aes(x, y, fill = pcMix)) +
  zoon_theme_legend +
  scale_fill_viridis(name = "", direction = -1) +
  theme(axis.title.y = element_text(hjust = 0.9)) +
  xlim(-126, -66) +
  ylim(22, 52) +
  xlab('Longitude') +
  ylab('Latitude')
pred_legend
dev.off()



