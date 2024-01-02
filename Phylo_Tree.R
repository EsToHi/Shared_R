library(ggtreeExtra)
library(ggtree)
library(phyloseq)
library(dplyr)

data("GlobalPatterns")
GP <- GlobalPatterns
GP <- prune_taxa(taxa_sums(GP) > 600, GP)
sample_data(GP)$human <- get_variable(GP, "SampleType") %in%
  c("Feces", "Skin")
mergedGP <- merge_samples(GP, "SampleType")
mergedGP <- rarefy_even_depth(mergedGP,rngseed=394582)
mergedGP <- tax_glom(mergedGP,"Order")

melt_simple <- psmelt(mergedGP) %>%
  filter(Abundance < 120) %>%
  select(OTU, val=Abundance)

p <- ggtree(mergedGP, layout="fan", open.angle=10) + 
  geom_tippoint(mapping=aes(color=Phylum), 
                size=1.5,
                show.legend=FALSE)
p <- rotate_tree(p, -90)

p <- p +
  geom_fruit(
    data=melt_simple,
    geom=geom_boxplot,
    mapping = aes(
      y=OTU,
      x=val,
      group=label,
      fill=Phylum,
    ),
    size=.2,
    outlier.size=0.5,
    outlier.stroke=0.08,
    outlier.shape=21,
    axis.params=list(
      axis       = "x",
      text.size  = 1.8,
      hjust      = 1,
      vjust      = 0.5,
      nbreak     = 3,
    ),
    grid.params=list()
  ) 

p <- p +
  scale_fill_discrete(
    name="Phyla",
    guide=guide_legend(keywidth=0.8, keyheight=0.8, ncol=1)
  ) +
  theme(
    legend.title=element_text(size=9), 
    legend.text=element_text(size=7) 
  )
p
