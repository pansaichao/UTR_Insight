rm(list = ls())
library(ggplot2) #加载ggplot2包
library(dplyr) #加载dplyr包
library(ggsci)   ##调色板
library(scales)
# # 安装并加载extrafont包
# install.packages("extrafont")
# library(extrafont)
# 
# # 导入所有系统可用的字体
# font_import()
# # 查看可用字体列表，确保其中有Arial
# fonts()
# # 注册Arial字体
# loadfonts(device = "win")


# #################################MRL与荧光强度相关性#################################
# 读取数据
flow_data1 <- read.csv("D:/code_work/article_plot/UTR_data/GFP_denovo_endogenous_experiment_data.csv", header = TRUE, encoding = "UTF-8")

# 筛选数据
flow_data2 <- flow_data1

# 获取 hHBA 的 MFI_avg 值
hHBA_mean <- flow_data2 %>% filter(No == "hHBA") %>% pull(MFI_avg)

# 设置图形大小
# 调整图的大小，单位为英寸，下面提供三种不同版式的尺寸设置
# 选择单栏图
# fig_width = 8.5 / 2.54  # 单栏图 8.5 cm = 3.35 英寸
# 选择 1.5 栏图
# fig_width = 12.0 / 2.54  # 1.5 栏图 12 cm = 4.72 英寸
# 选择双栏图
fig_width = 18.0 / 2.54  # 双栏图 18 cm = 7.09 英寸

# 设置图的高度，SCI投稿官网没有具体要求，这里设定为合适的比例
fig_height = fig_width * 0.75  # 高度为宽度的0.75倍

# 设置自定义颜色
custom_colors <- c("#6E9C72", "#C28C69", "#5E74A0")

# 设置字体和图片尺寸
theme_custom <- theme(
  text = element_text(family = "Arial"),  # 设置字体为 Arial
  axis.title = element_text(size = 10),  # 坐标轴标题字体大小
  axis.text = element_text(size = 8),  # 坐标轴刻度字体大小
  legend.text = element_text(size = 10),  # 图例文字大小
  legend.title = element_blank(),  # 去掉图例标题
  legend.position = "top",  # 图例位置
  plot.margin = margin(10, 10, 10, 10),  # 调整边距
  panel.grid.major = element_blank(),  # 去掉主网格线
  panel.grid.minor = element_blank(),  # 去掉次网格线
  panel.border = element_rect(size = 0.5)  # 设置边框线宽
)

scatter_plot <- ggplot(flow_data2, aes(x = pred_mrl, y = MFI_avg)) +
  geom_point(aes(color = hue), size = 2) +  # 设置散点大小
  geom_smooth(method = "lm", se = TRUE, color = "gray", linewidth = 0.5) +  # 添加拟合曲线
  labs(x = 'MRL', y = '24-hour average fluorescence intensity of GFP') +  # 设置坐标轴标签
  scale_y_continuous(labels = label_number()) +  # 美化 y 轴标签
  scale_color_manual(values = custom_colors) +  # 使用自定义颜色
  # scale_color_jama(alpha = 0.8) +  # 使用 JAMA 调色板
  theme_bw() +  # 使用黑白主题
  theme_custom + # 应用自定义主题
  stat_cor(method = "pearson", label.x = 3, label.y = 1500000) +  # 添加全局相关性和 p 值注释
  facet_wrap(~ source)  # 根据 source 分面显示

# 显示图表
print(scatter_plot)

# 保存为SVG文件
ggsave("D:/code_work/article_plot/result_5/scatter_plot_denovo_gfp_24h_1.svg", plot = scatter_plot, width = fig_width, height = fig_height, units = "in")


# #################################高MRL组与低MRL组对比#################################
rm(list = ls())
flow_data1 <- read.csv("D:/code_work/article_plot/UTR_data/GFP_denovo_endogenous_experiment_data.csv", header = TRUE, encoding = "UTF-8")

# 筛选数据
flow_data2 <- flow_data1[flow_data1$group != 'Positive control' & flow_data1$group != 'Rhegen 5UTR', ]

# 获取 hHBA 的 MFI_avg 值
hHBA_mean <- flow_data2 %>% filter(No == "hHBA") %>% pull(MFI_avg)

# 设置图形大小
# 调整图的大小，单位为英寸，下面提供三种不同版式的尺寸设置
# 选择单栏图
# fig_width = 8.5 / 2.54  # 单栏图 8.5 cm = 3.35 英寸
# 选择 1.5 栏图
# fig_width = 12.0 / 2.54  # 1.5 栏图 12 cm = 4.72 英寸
# 选择双栏图
fig_width = 18.0 / 2.54  # 双栏图 18 cm = 7.09 英寸

# 设置图的高度，SCI投稿官网没有具体要求，这里设定为合适的比例
fig_height = fig_width * 0.75  # 高度为宽度的0.75倍

# 设置字体和图片尺寸
theme_custom <- theme(
  text = element_text(family = "Arial"),  # 设置字体为 Arial
  axis.title = element_text(size = 10),  # 坐标轴标题字体大小
  axis.text = element_text(size = 10),  # 坐标轴刻度字体大小
  legend.text = element_text(size = 10),  # 图例文字大小
  legend.title = element_blank(),  # 去掉图例标题
  legend.position = "top",  # 图例位置
  plot.margin = margin(10, 10, 10, 10),  # 调整边距
  panel.grid.major = element_blank(),  # 去掉主网格线
  panel.grid.minor = element_blank(),  # 去掉次网格线
  panel.border = element_rect(size = 0.5)  # 设置边框线宽
)

# 绘制箱线图，并按 hue_2 分组，按 source 列分面
boxplot_24h <- ggplot(flow_data2, aes(x = hue_2, y = MFI_avg, fill = source)) +
  geom_boxplot() +
  labs(x = '', y = '24-hour average fluorescence intensity of GFP') +  # 设置坐标轴标签
  theme_bw() +
  theme_custom + # 应用自定义主题
  scale_y_continuous(labels = label_number(), limits = c(0, 1500000)) +  # 设置y轴范围
  facet_wrap(~source)  # 根据 source 列分面

# 使用JAMA调色板并显示
boxplot_24h_jama <- boxplot_24h + scale_fill_jama(alpha = 0.8)

# 显示图表
print(boxplot_24h_jama)

ggsave("D:/code_work/article_plot/result_5/barplot_top_MRL_bottom_MRL.svg", plot = boxplot_24h_jama, device = "svg", width = fig_width, height = fig_height)

