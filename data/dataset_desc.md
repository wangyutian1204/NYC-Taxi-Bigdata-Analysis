# 数据集完整说明
1. 原始数据源：Kaggle公开数据集 Trip_Duration_Data.csv
   原始规模：145万+纽约出租车出行订单，文件体积超10GB，本地设备无法完整加载，故仓库不存放原始源文件
2. 成品数据集 data_encoded.csv：
   完成全流程数据处理、特征工程、分类特征LabelEncoder编码后导出，可直接用于建模分析，无需原始文件
3. 本地运行优化：代码内置随机采样逻辑，默认抽取30000行样本执行分析，降低内存占用
4. 核心字段：
vendor_id：出租车服务商编号
passenger_count：单次乘车人数
pickup_longitude/pickup_latitude：上车经纬度坐标
dropoff_longitude/dropoff_latitude：下车经纬度坐标
pickup_datetime：订单下单时间
trip_duration：行程时长（模型回归预测目标）
haversine_distance/euclidean_distance/manhattan_distance：三种球面距离衍生特征
avg_speed_kmh：平均车速衍生特征
log_trip_duration：目标标签对数变换值