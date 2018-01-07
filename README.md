前前后后差不多用了一个月的时间，第一次用心地去做一件事，自己从头到尾去实现一个东西，哪怕功能不全，bug 这么多，深受折磨，也要坚持下去，所以才有今天这篇文章。

坚持是很重要的，一个一个功能的实现，都需要靠时间的坚持。有些 bug 在当时看来真的是无从下手，感觉要放弃了，但只要过几天再来看，好像也可以攻克了。

这个博客小项目基本功能齐全：
- 支持文章新建、编辑、删除等功能
- 支持图片素材上传
- 支持最简单的评论、还有标签 tag (分类) 功能
- 支持新建、删除标签 tag (分类）
- 支持评论的管理
- 支持留言
- 非常炫酷的星球大战介绍页面

基于 Spring + SpringMvc + Mybatis 整合框架， 使用 Mybatis 大神 Liuzh 的 [pagehelper](https://github.com/pagehelper/Mybatis-PageHelper) 分页插件，前端使用的模板是 w3school 的 w3.css 博客模板，后台集成了 [editormd](https://github.com/pandao/editor.md)  在线编辑器，介绍页面用的是星球大战的 starwarsintro.css。 

下面就来看看一张长图的截图效果：

![首页效果](https://static.oschina.net/uploads/img/201801/07134741_lWWt.jpg "在这里输入图片标题")

文章块

![文章块](https://static.oschina.net/uploads/img/201801/07135330_vWbl.png "在这里输入图片标题")

个人介绍

![intro](https://static.oschina.net/uploads/img/201801/07135506_QE5D.png "在这里输入图片标题")

最受欢迎的文章（我计算的是评论数最多的四篇文章，默认为前四篇）

![post](https://static.oschina.net/uploads/img/201801/07135657_0zYM.png "在这里输入图片标题")

标签分类

![标签分类](https://static.oschina.net/uploads/img/201801/07135907_RFPV.png "在这里输入图片标题")

博客页脚

![博客页脚](https://static.oschina.net/uploads/img/201801/07140023_dfzq.png "在这里输入图片标题")

联系我页面

![联系我页面](https://static.oschina.net/uploads/img/201801/07140158_PRDF.png "在这里输入图片标题")

关于我页面

![1](https://static.oschina.net/uploads/img/201801/07141529_aoN2.png "在这里输入图片标题")

![2](https://static.oschina.net/uploads/img/201801/07141558_0CSt.png "在这里输入图片标题")

后台管理页面的展示

![文章后台管理](https://static.oschina.net/uploads/img/201801/07160228_k641.png "在这里输入图片标题")

![分类管理](https://static.oschina.net/uploads/img/201801/07160312_NlKb.png "在这里输入图片标题")

![评论管理](https://static.oschina.net/uploads/img/201801/07160407_LdpF.png "在这里输入图片标题")

jar 包已上传，没有使用 maven 的原因是想减少点难度，缺点就是项目有点大，不过这样可以降低学习的难度，应该不会出现 jar 包版本冲突导致失去兴趣，无法继续学习。

[项目 github 地址
](http://git@github.com:oldbiwang/SSMBlogv2.git)

[项目 码云 地址](http://git@gitee.com:oldbiwang/SSMBlogv2.git)

[项目的腾讯云网址](http://www.oldbiwang.cn)

这次主要出于学习的目的，由于很多功能也没完善，我接下来有时间的话也会继续完善它，前端页面基本都是用框架和别人的例子修改的，因为我希望的把精力放在后端，你有好的前端展示文章的页面的话，可以给我建议，我觉得前端文章展示有点难看。

后台的展示页面，展示的美观程度也有待改善，但基本的功能是有的，能满足基本的博客管理，因为集成了强大好用的 editormd。我也想把我这次做这个博客小项目遇到的一些问题，以及学到的东西记录下来写成博客，但接下来毕业，时间比较紧，所以等我有时间一定要记录整理出来，方便以后我再次学习。

我希望以后能找到 Java 后端的工作，如果你喜欢的话，欢迎帮我 star 。
