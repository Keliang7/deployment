# 使用轻量级 Nginx 镜像
FROM nginx:alpine

# 删除默认配置
RUN rm -f /etc/nginx/conf.d/default.conf

# 拷贝我们生成的 Nginx 配置
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# 拷贝所有构建产物
COPY _stage_dist/ /usr/share/nginx/html/