# NYC-Taxi-Bigdata-Analysis
纽约出租车百万出行大数据分析项目

## 项目简介
针对网约车平台运力调配难、虚假订单难以自动识别、行程时长预估偏差大、用户运营无分层依据四大业务痛点，基于 Kaggle 百万级纽约出租车出行原始数据，独立搭建一套从原始数据清洗、特征衍生、异常识别、机器学习预测到用户分群、SQL 指标统计的完整数据分析链路，输出可直接落地的平台运营优化方案。

## 技术栈
Python 生态：Pandas、NumPy 用于海量数据清洗与特征计算；Matplotlib、Seaborn 完成全流程可视化；Scikit-learn 实现异常检测、聚类建模；LightGBM 构建梯度提升回归模型
数据库：MySQL，实现多维度运营数据聚合、分组排名统计
开发工具：Jupyter Notebook、Git 版本管理

## 项目目录结构
NYC-Taxi-Bigdata-Analysis/
├── charts/                     # 所有可视化结果截图
├── data/                       # 数据集字段说明文档
│   └── dataset_desc.md
├── docs/
│   └── analysis_report.md      # 完整业务分析报告
├── .gitignore                  # 仓库过滤配置
├── data_encoded.csv            # 清洗编码后标准建模数据集
├── nyc_taxi_sql_analysis.sql   # MySQL 统计脚本
├── NYC_Taxi_Trip_Duration_Analysis.ipynb # 核心分析代码
├── README.md
└── requirements.txt            # 项目依赖

## 项目流程
1. 数据预处理：百万级数据集采样优化、缺失/重复/地理异常数据清洗
2. 特征工程：时间特征（小时/工作日/月份）、经纬度距离空间特征构建
3. EDA探索分析：特征相关性、订单时段分布、服务商运营对比可视化
4. 异常检测：IsolationForest识别虚假、超长绕路异常订单
5. 回归建模：LightGBM预测行程时长，评估RMSE、输出特征重要性
6. 用户分层：K-Means聚类划分3类乘客出行画像
7. SQL统计：多维度订单、客流、服务商指标聚合
8. 业务输出：运力调度、风控、精细化营销优化方案

## 项目核心优势
1.针对超大原始数据集设计固定随机抽样方案，普通笔记本电脑即可完整复现整套分析流程
2.拓展用户聚类完整分析链路，包含分群合理性验证、人群特征解读，丰富分析维度
3.遵循标准化工程规范，配套完整中文业务分析文档，代码注释清晰、可复用性强
4.实现 Python 离线深度分析与 MySQL 业务报表统计联动，兼顾数据挖掘与日常运营需求

## 数据集说明
1. 原始数据来源：Kaggle公开数据集 Trip_Duration_Data.csv，包含145万+纽约出租车出行原始订单，文件体积超10GB；
2. 仓库存储规则：受硬件与GitHub文件大小限制，仓库不存放超大原始Trip_Duration_Data.csv；
3. 数据处理流程：本人独立完成原始数据集全链路清洗、时空特征衍生、异常过滤、分类特征LabelEncoder编码，最终导出data_encoded.csv标准化子集用于建模；
4. 字段、处理逻辑详情查阅：`data/dataset_desc.md`

## 运行方式
1. 安装依赖：`pip install -r requirements.txt`
2. 使用Jupyter Notebook打开主代码文件运行
3. MySQL导入sql脚本执行业务统计查询
