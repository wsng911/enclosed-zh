# Enclosed

## 功能特性

- 端对端加密（AES-GCM）
- 消息阅后即焚
- 自定义过期时间
- 密码保护
- 文件附件支持
- 默认简体中文界面

## 快速部署

```bash
docker run -d \
  -p 8787:8787 \
  -v $(pwd)/data:/app/.data \
  --name enclosed-zh \
  wsng911/enclosed-zh:latest
```

访问 `http://localhost:8787`
