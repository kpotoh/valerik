# Microbial images

## Plan

Raw

```txt
Мне нужно филогенетическое дерево внутри клад нескольких по тому 16s  что есть хотя это будет не очень репрезентативно по крайней мере это пойдет метод максимального правдоподобия наверное пойдет но тебе лучше знать клады для которых нужны деревья : Mycobacteria нужно дерево  в пределах пробы 2 см глубиной Готландская впадина и дерево между всеми остальными пробами где они там есть и наверное еще дерево с теми ребятами которые есть в NCBI, И тоже самое наверное для Архей (4 группы у меня разных тоже будет неплохо наверное) . и для JS1…

В статьях которые я скинул samulina есть прикольные диаграммы дисковые я думал для нескольких групп микробов сделать такие если ты вдруг придумаешь как их сделать то будет круто если нет то пофиг сделаю еще столбики уебищные в первой статье там диаграммы   у Shimizu... с 111 по 137 красивые вещи особенно там анализы главных компонент и еще дерево в конце вроде оно по всем таксонам которые у него есть. Knittel мне нравиться пузырьковой диаграммой

нужен анализ главных компонент с той геологической штукой (в которых нет 4 моих образцов по глубине) и корреляции групп JS1 с глубиной. Константин Сенсей наш еще про ГЦ состав говорил но наверное его можно для глубины сделать( для каждой пробы отдельно всех в кучу , типа как отношение к кислороду…
```

1. trees
2. **unneded** [pie](https://medium.com/@kvnamipara/a-better-visualisation-of-pie-charts-by-matplotlib-935b7667d77f) chart like in the [paper](./docs/Samylina2021_Article_OnThePossibilityOfAerobicMetha.pdf)
3. **done** Relative abundance VS depth - [stackplot](https://stackoverflow.com/questions/50802556/how-to-plot-a-vertical-area-plot-with-pandas)
4. Microbial community by 16S rRNA gene [NMDS](http://qiime.org/scripts/nmds.html) (non-metric multidimensional scaling ordination)
5. quime [beta diversity](http://qiime.org/scripts/beta_diversity.html) analysis
6. Chemicals VS community composition
7. GC content (genetics)

## NMDS

The microbial community composition differed significantly by station (Figure
24a; ANOSIM: R = 0.36, p = 0.006, 999 permutation) except between Stations H and I
(ANOSIM: R < 0.01, p= 0.17). The community composition differed also between 0-10cm
and 10-20 cm sediment depths (Figure 24b; ANOSIM: R = 0.35 p= 0.001). The surface
samples from all stations were clustered relatively closely (ANOSIM: R = 0.35, p = 0.018),
120compared to the deeper sediment samples (ANOSIM: R = 0.77, p = 0.001) (Figure 24b).
**The deeper the sediment cores, the microbial communities are more different among the
stations.** This reflects that geochemical gradients downcore shape specific niche
differentiation for microbial community.

Figure 24: Non-metric multidimensional scaling (NMDS) plot of microbial
communities based on Bray-Curtis dissimilarity for 16S rRNA gene libraries. The
community profiles from each sample; a) color represents sampling stations. Ellipses
represent 95% intervals around centroids for each sampling station. b) color
represents sediment depth.

## References

1. [Non-metric multidimensional scaling](https://mb3is.megx.net/gustame/dissimilarity-based-methods/nmds)
2. sklearn [MDS](https://scikit-learn.org/stable/modules/generated/sklearn.manifold.MDS.html) with `metric=False`
3. [Beta diversity](http://scikit-bio.org/docs/0.2.0/generated/skbio.diversity.beta.html) in python
