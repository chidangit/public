#!/bin/bash

# Thay đổi DNS server
echo "Thay đổi DNS server về 8.8.8.8..."
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Kiểm tra và cài đặt Docker nếu chưa được cài đặt
if ! command -v docker &> /dev/null
then
    echo "Docker chưa được cài đặt. Bắt đầu quá trình cài đặt..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo "Cài đặt Docker hoàn tất."
else
    echo "Docker đã được cài đặt."
fi

# Kiểm tra và cài đặt Git nếu chưa được cài đặt
if ! command -v git &> /dev/null
then
    echo "Git chưa được cài đặt. Bắt đầu quá trình cài đặt..."
    sudo apt update
    sudo apt install git -y
    echo "Cài đặt Git hoàn tất."
else
    echo "Git đã được cài đặt."
fi

# Xác nhận việc tạo người dùng mới
read -p "Bạn có muốn tạo người dùng mới không? (y/n): " create_new_user
if [ "$create_new_user" == "y" ]; then
    read -p "Nhập tên người dùng mới: " new_username
    sudo adduser $new_username
    sudo usermod -aG sudo $new_username
    echo "Người dùng mới đã được tạo và được gán quyền root."
else
    echo "Không tạo người dùng mới."
fi
