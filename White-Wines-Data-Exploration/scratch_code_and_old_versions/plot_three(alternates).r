
#-------------------------------------------------------------------------

# Plot Three Alternates

# 1: "r alcohol_density_quality_by_RS"
#```{r echo=FALSE, Plot_Three}
# Recreate the variables to be used in this plot
wines$quality.factor <- cut(wines$quality, breaks = c(0,4,5,6,7,9), 
                         labels=c('poor (3-4)', 'average (5)', 'above avg.(6)', 
                                 'good (7)', 'excellent (8-9)'))
wines$RS.sweetness <- cut(wines$residual.sugar, breaks = c(0, 1.2, 4, 12, 66), 
                          labels=c('RS <= 1.2', 'RS 1.2-4', 'RS 4-12', 
                                   'RS > 12'))
# Plot
ggplot(wines, aes(density, alcohol, color = quality.factor)) + 
  coord_cartesian(xlim = c(.987, 1.002), ylim = c(8, 14.3)) + 
  scale_y_continuous(breaks = seq(8, 14, 1)) + 
  geom_jitter(alpha = 2/3) + 
  geom_hline(aes(yintercept = median(wines$alcohol)), color = 'grey') + 
  geom_vline(aes(xintercept = median(wines$density)), color = 'grey') +
  geom_smooth(method = 'lm', size = .75, se=FALSE) + 
  scale_color_brewer(type='div', palette = 'RdBu', direction = -1) + 
  theme_dark() + 
  facet_wrap(~RS.sweetness, ncol = 2)
#```



# 2: r dens_rs-abv-qual_facet
#```{r p3_alt2}
ggplot(wines, aes(residual.sugar, density)) + 
  geom_jitter(aes(color = quality.factor), size = 1.5, alpha = 3/4) + 
  coord_cartesian(xlim = c(0.5, 33), ylim = c(.987, 1.003)) + 
  scale_x_continuous(trans = 'log2', breaks = c(1, 2, 4, 8, 16, 32)) + 
  geom_hline(aes(yintercept = median(wines$density)), 
             color = 'blue', linetype = 2) + 
  geom_vline(aes(xintercept = median(wines$residual.sugar)), 
             color = 'blue', linetype = 2) + 
  scale_color_brewer(type = 'div', palette = 'RdBu', direction = -1) + 
  theme_dark() + 
  facet_wrap(~alcohol.content, ncol = 3)
#```



theme(axis.line = element_line(colour = "darkblue", size = 1, linetype = "solid"))