# docker

##Docker remove all

```bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

Cú pháp Dockerfile
==================

Dockerfile là một tập hợp các định nghĩa, nó dùng để build một images

## Dockerfile Syntax

Cú pháp của Dockerfile bao gồm hai khối chính: comment và lệnh + đối số

Ví dụ:

```bash
# Print "Hello Docker!!!"

RUN echo "Hello Docker!!!"
```

## Dockerfile command

Lưu ý là tất cả các command dùng để build một image __chỉ__ chứa duy nhất trong
một Dockerfile. Thứ tứ các command trong Dockerfile cũng chính là thứ tự thực thi
khi tạo một image. Tuy vậy có một số lệnh có thể đặt bất kỳ đâu trong Dockerfile
như MAINTAINER (nhưng luôn phải sau FROM)

### ADD

`ADD` có hai đối số: một là nguồn và một là đích. Nó đơn giản là copy những tập
tin từ nguồn trên máy chủ vào trong địch trên file system của container. Nếu nguồn
là một URL thì nó sẽ download và đặt vào đích.

Ví dụ:

```bash
ADD ~/wl.txt /root/
```

### CMD

`CMD` tương tự như `RUN` nó sẽ thực thi một câu lệnh, nhưng điểm khác biệt là
các lệnh trong `CMD` sẽ mặc định được thực thi khi chạy `docker run` còn các
lệnh trong `RUN` sẽ được thực khi khi chạy `docker build`

Ví dụ

```bash
# docker build will execute these commands:
RUN apt-get update
RUN apt-get install softwares

# docker run will run this command by default:
CMD ["softwares"]
```

### RUN

`RUN` thực thi một lệnh trong quá trình build image.

Ví dụ:

```bash
RUN apt-get update -y
RUN apt-get install -y vim htop
```

### MAINTAINER

Lệnh này không thực thi gì cả, được dùng để khai báo tác giả của images. Nó
nên đi ngay sau FROM

### FROM

Đây là một trong số các lệnh quan trọng nhất của Dockerfile. Nó định nghĩa
một __base image__ được dùng để build. Nó có thể là bất cứ image nào mà bạn
tạo trước đó hoặc từ docker index. Nó lên là khai báo đầu tiên trong Dockerfile.

### USER

Dùng để thiết lập UID (quyền user) sẽ chạy container được tạo ra từ image này.

### VOLUME

Lệnh này sử dụng để bật quyền truy cập từ container tới một thư mục trên máy host.
Nhưng phải mount nó vào đâu đó trên filesytem của container.

### WORKDIR

Được sử dụng để chỉ định nơi mà các lệnh trong `CMD` để được thực thi. Dạng như
biến PATH
ví dụ
```bash
WORKDIR /etc/nginx
```

### Ví dụ

Build một image từ Dockerfile

```bash
docker build -t hello -f Dockerfile/Dockerfile.hello  .
docker build -t levinhtin/ubuntu:latest .
```

- `-t`: tên của images (docker images | grep hello)
- `-f`: chỉ định Dockerfile

Chạy/tạo một container từ image vừa build

```bash
docker run --name hello -i -t hello
docker run --name tinubu -i -t levinhtin/ubuntu:latest -d -p 80:80
```

- `--name:` tên của container

exec
```bash
docker exec -it ubuntu_bash bash
```
