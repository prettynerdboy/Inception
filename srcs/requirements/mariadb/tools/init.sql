CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
-- GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'%';
-- FLUSH PRIVILEGES;

-- dbの操作ユーザーの作成